<%@ page import="top.llong.javawebexp6.dao.UserDao" %>
<%@ page import="top.llong.javawebexp6.DBUtil" %><%--
  Created by IntelliJ IDEA.
  User: llong
  Date: 2024/10/24
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>删除</title>
    </head>
    <body>
        <%
            UserDao userDao = new UserDao(DBUtil.getConnection());
            String id = request.getParameter("id");
            if (id == null || id.isBlank()) return;
            boolean suc = userDao.deleteUser(Integer.parseInt(id));
        %>
        <%
            if (suc) {
        %>
        <h3>删除成功</h3>

        <%
        } else {
        %>
        <h3>删除失败</h3>

        <%
            }
        %>

        <h4>3秒后返回上一页</h4>
        <script>
            setTimeout(() => {
                window.location.replace(document.referrer);
            }, 3000);

        </script>

    </body>
</html>
