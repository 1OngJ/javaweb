<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="top.llong.javawebexp6.QuadraticEquationSolver.QuadraticEquationSolver" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quadratic Equation Solver</title>
</head>
<body>
<h2>一元二次方程求解器</h2>
<form action="solveQuadraticEquation.jsp" method="post">
    <label for="a">a:</label>
    <input type="text" name="a" id="a" required><br><br>
    <label for="b">b:</label>
    <input type="text" name="b" id="b" required><br><br>
    <label for="c">c:</label>
    <input type="text" name="c" id="c" required><br><br>
    <input type="submit" value="求解">
</form>

<jsp:useBean id="solver" class="top.llong.javawebexp6.QuadraticEquationSolver.QuadraticEquationSolver" scope="request" />
<%
    String aStr = request.getParameter("a");
    String bStr = request.getParameter("b");
    String cStr = request.getParameter("c");

    if (aStr != null && bStr != null && cStr != null) {
        try {
            double a = Double.parseDouble(aStr);
            double b = Double.parseDouble(bStr);
            double c = Double.parseDouble(cStr);

%>
<jsp:setProperty name="solver" property="a" value="<%= a %>" />
<jsp:setProperty name="solver" property="b" value="<%= b %>" />
<jsp:setProperty name="solver" property="c" value="<%= c %>" />

<script type="text/javascript">
    alert("<jsp:getProperty name='solver' property='solutionMessage' />");
</script>
<%
} catch (NumberFormatException e) {
%>
<script type="text/javascript">
    alert("请输入有效的数字。");
</script>
<%
        }
    }
%>
</body>
</html>