package top.llong.javawebexp6.equationServlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import top.llong.javawebexp6.JavaBean.EquationBean;

import java.io.IOException;

@WebServlet("/EquationServlet")
public class EquationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 获取参数
        double a = Double.parseDouble(request.getParameter("a"));
        double b = Double.parseDouble(request.getParameter("b"));
        double c = Double.parseDouble(request.getParameter("c"));
        double d = Double.parseDouble(request.getParameter("d"));
        double e = Double.parseDouble(request.getParameter("e"));
        double f = Double.parseDouble(request.getParameter("f"));


        // 2. 创建JavaBean并设置属性
        EquationBean equationBean = new EquationBean();
        equationBean.setA(a);
        equationBean.setB(b);
        equationBean.setC(c);
        equationBean.setD(d);
        equationBean.setE(e);
        equationBean.setF(f);
        // 3. 计算结果
        String result = solveEquation(a, b, c, d, e, f);
        equationBean.setResult(result);

        // 4. 将JavaBean存储到request作用域
        request.setAttribute("equation", equationBean);

        // 5. 转发到result.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
        dispatcher.forward(request, response);
    }


    private String solveEquation(double a, double b, double c, double d, double e, double f){
        double determinant = a * d - b * c;

        if (determinant == 0) {
            if (a * f - c * e == 0 && b * f - d *e == 0)
                return "方程组有无数解";
            else
                return "方程组无解";
        } else {
            double x = (b * f - d*e) / determinant;
            double y = (c * e - a * f) / determinant;
            return "x=" + x + ", y=" + y;
        }
    }
}