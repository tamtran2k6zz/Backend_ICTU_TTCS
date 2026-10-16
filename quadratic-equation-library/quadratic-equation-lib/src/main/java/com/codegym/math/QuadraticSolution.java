package com.codegym.math;

import java.util.List;

/** Immutable result containing the discriminant and zero, one, or two real roots. */
public final class QuadraticSolution {
    private final double discriminant;
    private final List<Double> realRoots;

    QuadraticSolution(double discriminant, List<Double> realRoots) {
        this.discriminant = discriminant;
        this.realRoots = List.copyOf(realRoots);
    }

    public double getDiscriminant() {
        return discriminant;
    }

    public List<Double> getRealRoots() {
        return realRoots;
    }

    public int getNumberOfRealRoots() {
        return realRoots.size();
    }

    @Override
    public String toString() {
        return "QuadraticSolution{discriminant=" + discriminant + ", realRoots=" + realRoots + '}';
    }
}
