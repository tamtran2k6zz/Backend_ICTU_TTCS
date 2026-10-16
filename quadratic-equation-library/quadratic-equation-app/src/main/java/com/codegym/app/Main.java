package com.codegym.app;

import com.codegym.math.QuadraticEquationSolver;
import com.codegym.math.QuadraticSolution;

public class Main {
    public static void main(String[] args) {
        showSolution("Two distinct roots", 1, -3, 2);
        showSolution("One repeated root", 1, 2, 1);
        showSolution("No real roots", 1, 0, 1);
    }

    private static void showSolution(String label, double a, double b, double c) {
        QuadraticSolution solution = QuadraticEquationSolver.solve(a, b, c);
        System.out.printf("%s: %.2fx^2 + %.2fx + %.2f = 0; D = %.2f; roots = %s%n",
                label, a, b, c, solution.getDiscriminant(), solution.getRealRoots());
    }
}
