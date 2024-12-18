<%@ page import="top.llong.javawebexp6.form.UserRegisterForm" %>
<%@ page import="top.llong.javawebexp6.dao.UserDao" %>
<%@ page import="top.llong.javawebexp6.dao.DaoUtil" %>
<%@ page import="top.llong.javawebexp6.DBUtil" %><%--
  Created by IntelliJ IDEA.
  User: llong
  Date: 2024/10/24
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>注册</title>
    </head>
    <body>
        <h3>注册成功
        </h3>
        <h4>3秒后返回上一页</h4>
        <script>
            setTimeout(() => {
                window.location.replace(document.referrer);
            }, 3000);
        </script>
    </body>
</html>
