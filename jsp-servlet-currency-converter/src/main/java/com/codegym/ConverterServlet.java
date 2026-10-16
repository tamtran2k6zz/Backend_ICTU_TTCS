package com.codegym;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** Converts a user-provided USD amount using the exchange rate from the form. */
public class ConverterServlet extends HttpServlet {
    private static final String RESULT_VIEW = "/WEB-INF/conversion-result.jsp";
    private static final Locale VIETNAMESE = Locale.forLanguageTag("vi-VN");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            BigDecimal rate = parseDecimal(request.getParameter("rate"));
            BigDecimal usd = parseDecimal(request.getParameter("usd"));

            if (rate.signum() <= 0 || usd.signum() < 0) {
                throw new IllegalArgumentException("Rate must be positive and USD must not be negative.");
            }

            BigDecimal vnd = rate.multiply(usd).setScale(2, RoundingMode.HALF_UP);
            request.setAttribute("conversionSuccess", true);
            request.setAttribute("rateFormatted", format(rate, 4));
            request.setAttribute("usdFormatted", format(usd, 4));
            request.setAttribute("vndFormatted", format(vnd, 2));
        } catch (IllegalArgumentException exception) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("conversionSuccess", false);
            request.setAttribute("errorMessage", "Vui lòng nhập tỉ giá dương và lượng USD không âm bằng số hợp lệ.");
        }

        request.getRequestDispatcher(RESULT_VIEW).forward(request, response);
    }

    private static BigDecimal parseDecimal(String value) {
        if (value == null || value.isBlank()) {
            throw new NumberFormatException("Missing numeric input.");
        }
        return new BigDecimal(value.trim());
    }

    private static String format(BigDecimal value, int maximumFractionDigits) {
        NumberFormat formatter = NumberFormat.getNumberInstance(VIETNAMESE);
        formatter.setMinimumFractionDigits(0);
        formatter.setMaximumFractionDigits(maximumFractionDigits);
        return formatter.format(value);
    }
}
