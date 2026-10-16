package com.codegym;

import java.security.NoSuchAlgorithmException;

/** Basic integer arithmetic operations packaged as a reusable Java library. */
public final class Calculator {
    private Calculator() {
    }

    public static int sum(int a, int b) {
        return a + b;
    }

    public static int sub(int a, int b) {
        return a - b;
    }

    public static int mul(int a, int b) {
        return a * b;
    }

    public static int divide(int a, int b) throws NoSuchAlgorithmException {
        if (b == 0) {
            throw new NoSuchAlgorithmException("Cannot divide by zero.");
        }
        return a / b;
    }
}
