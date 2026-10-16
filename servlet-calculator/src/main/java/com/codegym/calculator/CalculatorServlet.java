package com.codegym.calculator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CalculatorServlet", urlPatterns = "/calculator")
public class CalculatorServlet extends HttpServlet {

    private final Calculator calculator = new Calculator();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            double firstOperand = parseOperand(request.getParameter("firstOperand"));
            double secondOperand = parseOperand(request.getParameter("secondOperand"));
            String operator = request.getParameter("operator");
            if (operator == null) {
                throw new IllegalArgumentException("Vui lòng chọn phép tính.");
            }

            double result = calculator.calculate(firstOperand, secondOperand, operator);
            request.setAttribute("firstOperand", firstOperand);
            request.setAttribute("secondOperand", secondOperand);
            request.setAttribute("operator", operator);
            request.setAttribute("result", result);
        } catch (NumberFormatException exception) {
            request.setAttribute("error", "Vui lòng nhập hai số hợp lệ.");
        } catch (Exception exception) {
            request.setAttribute("error", exception.getMessage());
        }

        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }

    private double parseOperand(String value) {
        if (value == null || value.isBlank()) {
            throw new NumberFormatException("Missing operand");
        }
        double operand = Double.parseDouble(value);
        if (!Double.isFinite(operand)) {
            throw new NumberFormatException("Operand must be finite");
        }
        return operand;
    }
}
