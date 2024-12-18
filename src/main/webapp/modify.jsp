<%@ page import="top.llong.javawebexp6.form.UserRegisterForm" %>
<%@ page import="top.llong.javawebexp6.form.UserModifyForm" %>
<%@ page import="top.llong.javawebexp6.dao.UserDao" %>
<%@ page import="top.llong.javawebexp6.DBUtil" %>
<%@ page import="top.llong.javawebexp6.UserServlet.UserServlet" %><%--
  Created by IntelliJ IDEA.
  User: llong
  Date: 2024/10/29
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>修改</title>
    </head>
    <body>

    <h3>修改成功
    </h3>
    <h4>3秒后返回上一页</h4>
    <script>
        setTimeout(() => {
            window.location.replace(document.referrer);
        }, 3000);
    </script>
    </body>
</html>
