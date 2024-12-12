<%--
  Created by IntelliJ IDEA.
  User: Long
  Date: 2024/11/28
  Time: 0:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="top.llong.javawebexp6.JavaBean.EquationBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>计算结果</title>
</head>
<body>
<h1>计算结果</h1>
<% EquationBean equation = (EquationBean) request.getAttribute("equation"); %>
<p>方程: <%= equation.getA() %>x + <%= equation.getB() %>y + <%= equation.getC() %> = 0,  <%= equation.getC() %>x + <%= equation.getD() %>y + <%= equation.getF() %> = 0</p>
<p>结果: <%= equation.getResult() %></p>
</body>
</html>
