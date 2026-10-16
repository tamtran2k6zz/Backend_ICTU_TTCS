package com.codegym.calculator;

public class Calculator {

    public double calculate(double firstOperand, double secondOperand, String operator) throws Exception {
        return switch (operator) {
            case "+" -> firstOperand + secondOperand;
            case "-" -> firstOperand - secondOperand;
            case "*" -> firstOperand * secondOperand;
            case "/" -> {
                if (secondOperand == 0.0d) {
                    throw new ArithmeticException("Không thể chia cho 0.");
                }
                yield firstOperand / secondOperand;
            }
            default -> throw new IllegalArgumentException("Toán tử không hợp lệ.");
        };
    }
}
