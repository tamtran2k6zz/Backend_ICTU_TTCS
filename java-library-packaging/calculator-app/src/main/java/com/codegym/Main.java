package com.codegym;

import java.security.NoSuchAlgorithmException;

public class Main {
    public static void main(String[] args) {
        System.out.println("Results from the packaged math-lib JAR:");
        System.out.println("Sum (5, 9): " + Calculator.sum(5, 9));
        System.out.println("Difference (5, 9): " + Calculator.sub(5, 9));
        System.out.println("Product (5, 9): " + Calculator.mul(5, 9));

        try {
            System.out.println("Quotient (10, 5): " + Calculator.divide(10, 5));
            Calculator.divide(10, 0);
        } catch (NoSuchAlgorithmException exception) {
            System.out.println("Expected division error: " + exception.getMessage());
        }
    }
}
