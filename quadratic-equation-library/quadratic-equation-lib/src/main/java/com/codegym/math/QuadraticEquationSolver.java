package com.codegym.math;

import java.util.List;

/** Solves quadratic equations of the form ax^2 + bx + c = 0 over the real numbers. */
public final class QuadraticEquationSolver {
    private QuadraticEquationSolver() {
    }

    public static QuadraticSolution solve(double a, double b, double c) {
        if (!Double.isFinite(a) || !Double.isFinite(b) || !Double.isFinite(c)) {
            throw new IllegalArgumentException("Coefficients must be finite numbers.");
        }
        if (a == 0.0) {
            throw new IllegalArgumentException("Coefficient 'a' must not be zero for a quadratic equation.");
        }

        double discriminant = Math.fma(b, b, -4.0 * a * c);
        if (discriminant < 0.0) {
            return new QuadraticSolution(discriminant, List.of());
        }
        if (discriminant == 0.0) {
            double root = -b / (2.0 * a);
            return new QuadraticSolution(discriminant, List.of(root));
        }

        // The q-form avoids loss of precision when b and sqrt(discriminant) nearly cancel.
        double squareRoot = Math.sqrt(discriminant);
        double q = -0.5 * (b + Math.copySign(squareRoot, b));
        double firstRoot = q / a;
        double secondRoot = c / q;
        double smallerRoot = Math.min(firstRoot, secondRoot);
        double largerRoot = Math.max(firstRoot, secondRoot);
        return new QuadraticSolution(discriminant, List.of(smallerRoot, largerRoot));
    }
}
