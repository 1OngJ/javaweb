<%@ page import="top.llong.javawebexp6.dao.UserDao" %>
<%@ page import="top.llong.javawebexp6.DBUtil" %>
<%@ page import="top.llong.javawebexp6.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="top.llong.javawebexp6.vo.UserVO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>用户管理系统</title>
    <style>
        body {
            font-family: monospace;
            background-color: #f0f0f0;
            color: #333;
        }
        table {
            width: 45%;
            margin: 10px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px 12px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #a0a0a0;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #e0e0e0;
        }
        input[type="text"], input[type="submit"], input[type="button"] {
            font-family: monospace;
            padding: 5px;
            border: 1px solid #ccc;
            background-color: #fff;
        }
        input[type="submit"], input[type="button"] {
            background-color: #d0d0d0;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button{
            padding: 5px;
            border: 1px solid #ccc;
            background-color: #d0d0d0;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #c0c0c0;
        }
        button:hover {
            background-color: #c0c0c0;
        }
        a {
            color: #004e8f;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .search-row input[type="text"] {
            width: 40px;
        }
    </style>
</head>
<body>
<%!
    public String getStringOrBlank(String str) {
        return str == null || str.equals("null") ? "" : str;
    }
%>
<%
    UserDao userDao = null;
    try {
        userDao = new UserDao(DBUtil.getConnection());
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    List<User> allUsers = userDao.getAllByCondition(request.getParameterMap());
%>

<form action="search.jsp" method="get">
    <table border="1">
        <tr>
            <th>id</th>
            <th>姓名</th>
            <th>类型</th>
            <th>性别</th>
            <th>出生日期</th>
            <th>爱好</th>
            <th>邮箱</th>
            <th>自我介绍</th>
            <th>操作</th>
        </tr>
        <tr bgcolor="#faebd7">
            <td>查找</td>
            <td><input name="name" value="<%= getStringOrBlank(request.getParameter("name")) %>"></td>
            <td><input name="type" value="<%= getStringOrBlank(request.getParameter("type")) %>"></td>
            <td><input name="gender" value="<%= getStringOrBlank(request.getParameter("gender")) %>"></td>
            <td><input name="birthday" value="<%= getStringOrBlank(request.getParameter("birthday")) %>"></td>
            <td><input name="hobby" value="<%= getStringOrBlank(request.getParameter("hobby")) %>"></td>
            <td><input name="email" value="<%= getStringOrBlank(request.getParameter("email")) %>"></td>
            <td><input name="intro" value="<%= getStringOrBlank(request.getParameter("intro")) %>"></td>
            <td><input type="submit" value="查找" formmethod="post">   <input type="button" value="重置" id="reset"></td>

        </tr>

        <% if (allUsers != null) { %>
        <% for (User u : allUsers) {
            UserVO userVO = new UserVO(u); %>
        <tr>
            <td><%= userVO.getId() %></td>
            <td><%= userVO.getName() %></td>
            <td><%= userVO.getType() %></td>
            <td><%= userVO.getGender() %></td>
            <td><%= userVO.getBirthday() %></td>
            <td><%= userVO.getHobby() %></td>
            <td><%= userVO.getEmail() %></td>
            <td><%= userVO.getIntro() %></td>
            <td>
                <a href="modifyForm.jsp?id=<%= userVO.getId() %>"><button type="button">修改</button></a>

                <a href="delete.jsp?id=<%= userVO.getId() %>"><button type="button">删除</button></a>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr><td colspan="10">无查询结果</td></tr>
        <% } %>
    </table>
</form>

<script>
    document.getElementById("reset").addEventListener("click", function () {
        let pos = (window.location + "").indexOf("?");
        if (pos === -1) {
            window.location.reload();
        } else {
            window.location = (window.location + "").substring(0, pos);
        }
    });
</script>
</body>
</html>