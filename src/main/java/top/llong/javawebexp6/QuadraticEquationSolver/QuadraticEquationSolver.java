package top.llong.javawebexp6.QuadraticEquationSolver;



public class QuadraticEquationSolver {
    private double a;
    private double b;
    private double c;
    private double discriminant;
    private String solutionMessage;

    public QuadraticEquationSolver() {}

    public void setA(double a) {
        this.a = a;
    }

    public void setB(double b) {
        this.b = b;
    }

    public void setC(double c) {
        this.c = c;
    }

    public String getSolutionMessage() {
        calculateSolutions();
        return solutionMessage;
    }

    private void calculateSolutions() {
        discriminant = b * b - 4 * a * c;

        if (discriminant < 0) {
            solutionMessage = "方程无解。";
        } else if (discriminant == 0) {
            double x = -b / (2 * a);
            solutionMessage = "方程有一个解：x = " + x;
        } else {
            double sqrtDiscriminant = Math.sqrt(discriminant);
            double x1 = (-b + sqrtDiscriminant) / (2 * a);
            double x2 = (-b - sqrtDiscriminant) / (2 * a);
            solutionMessage = "方程有两个解：x1 = " + x1 + ", x2 = " + x2;
        }
    }
}