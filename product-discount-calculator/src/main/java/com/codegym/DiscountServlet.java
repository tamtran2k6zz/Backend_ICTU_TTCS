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

/** Calculates the discount amount and final price submitted by the product form. */
public class DiscountServlet extends HttpServlet {
    private static final String RESULT_VIEW = "/WEB-INF/discount-result.jsp";
    private static final BigDecimal ONE_HUNDRED = BigDecimal.valueOf(100);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String description = request.getParameter("productDescription");
        String listPriceInput = request.getParameter("listPrice");
        String discountPercentInput = request.getParameter("discountPercent");

        try {
            String cleanDescription = description == null ? "" : description.trim();
            if (cleanDescription.isEmpty()) {
                throw new IllegalArgumentException("Product description is required.");
            }

            BigDecimal listPrice = parseDecimal(listPriceInput);
            BigDecimal discountPercent = parseDecimal(discountPercentInput);
            if (listPrice.signum() < 0 || discountPercent.signum() < 0
                    || discountPercent.compareTo(ONE_HUNDRED) > 0) {
                throw new IllegalArgumentException("Price must be non-negative and discount must be from 0 to 100.");
            }

            BigDecimal discountAmount = listPrice.multiply(discountPercent)
                    .divide(ONE_HUNDRED, 2, RoundingMode.HALF_UP);
            BigDecimal discountPrice = listPrice.subtract(discountAmount).setScale(2, RoundingMode.HALF_UP);

            request.setAttribute("calculationSuccess", true);
            request.setAttribute("productDescription", escapeHtml(cleanDescription));
            request.setAttribute("listPrice", format(listPrice));
            request.setAttribute("discountPercent", format(discountPercent));
            request.setAttribute("discountAmount", format(discountAmount));
            request.setAttribute("discountPrice", format(discountPrice));
        } catch (IllegalArgumentException exception) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("calculationSuccess", false);
            request.setAttribute("errorMessage", "Please enter a product description, a valid non-negative price, and a discount from 0 to 100%.");
        }

        request.getRequestDispatcher(RESULT_VIEW).forward(request, response);
    }

    private static BigDecimal parseDecimal(String value) {
        if (value == null || value.isBlank()) {
            throw new NumberFormatException("Missing numeric value.");
        }
        return new BigDecimal(value.trim());
    }

    private static String format(BigDecimal value) {
        NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
        formatter.setMinimumFractionDigits(2);
        formatter.setMaximumFractionDigits(2);
        return formatter.format(value);
    }

    private static String escapeHtml(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
