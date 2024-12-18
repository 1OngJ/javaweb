<%--
  Created by IntelliJ IDEA.
  User: Long
  Date: 2024/11/27
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>二元一次方程组求解</title>
</head>
<body>
<h1>求解二元一次方程组</h1>
<form action="EquationServlet" method="post">
    <label for="a">a:</label><input type="text" name="a" id="a" required><br>
    <label for="b">b:</label><input type="text" name="b" id="b" required><br>
    <label for="c">c:</label><input type="text" name="c" id="c" required><br>
    <label for="d">d:</label><input type="text" name="d" id="d" required><br>
    <label for="e">e:</label><input type="text" name="e" id="e" required><br>
    <label for="f">f:</label><input type="text" name="f" id="f" required><br>
    <input type="submit" value="计算">
</form>
</body>
</html>
