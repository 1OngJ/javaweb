<%@ page import="top.llong.javawebexp6.dao.UserDao" %>
<%@ page import="top.llong.javawebexp6.DBUtil" %>
<%@ page import="top.llong.javawebexp6.entity.User" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>修改</title>
    <style>
        body {
            font-family: monospace;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
        }
        #ctn {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        #main {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.2);

        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 8px;
            text-align: left;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"],
        select,
        textarea {
            font-family: monospace;
            padding: 5px;
            border: 1px solid #ccc;
            width: calc(100% - 12px);
            box-sizing: border-box;


        }
        input[type="radio"],
        input[type="checkbox"] {
            margin-right: 5px;
        }
        button {
            font-family: monospace;
            padding: 8px 15px;
            background-color: #d0d0d0;
            border: 1px solid #ccc;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #c0c0c0;
        }
        h1 {
            font-family: sans-serif;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
        <%

            // 获取请求参数 "suc" 的所有值
            String[] successParams = request.getParameterValues("suc");

            // 如果是修改成功，返回到管理页
//            String[] sucs = request.getParameterValues("suc");
            // 检查参数是否存在且不为空
            if (successParams != null && successParams.length > 0) {
                // 获取最后一个参数值
                String lastParamValue = successParams[successParams.length - 1];

                // 检查最后一个参数值是否为 "1"
                if ("1".equals(lastParamValue)) {
                    // 重定向到管理页
                    response.sendRedirect("search.jsp");
                    return;
                }
            }

            // 拿到用户id
            String id = request.getParameter("id");
            if (id == null) {
                response.sendRedirect("index.jsp");
            }

            // 从数据库取出用户
            User user = null;
            try {
                if (id != null) {
                    user = new UserDao(DBUtil.getConnection()).getUserById(Integer.valueOf(id));
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (user == null) {
                response.sendRedirect("index.jsp");
            }
        %>


        <div id="ctn">
            <form id="main" action="${pageContext.request.contextPath}/UserServlet" method="post" onsubmit="return submitClick()">
                <input type="hidden" name="action" value="modifyUser">
                <table id="table">
                    <tr>
                        <td>

                            <h1>修改</h1>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            用户名
                        </td>
                        <td>
                            <input id="userName" name="userName" value="<%=user.getName()%>">
                        </td>
                    </tr>

                    <tr>
                        <td>
                            当前密码
                        </td>
                        <td>
                            <input id="password_old" name="password_old" type="password">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            新密码
                        </td>
                        <td>
                            <input id="password" name="password" type="password">
                        </td>
                    </tr>

                    <tr>
                        <td>
                            确认密码
                        </td>
                        <td>
                            <input id="confirmPassword" type="password">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            用户类型
                        </td>
                        <td>
                            <select id="type" name="type">
                                <option value="管理员" <%="管理员".equals(user.getType()) ? "selected" : ""%>>管理员
                                </option>
                                <option value="普通用户" <%="普通用户".equals(user.getType()) ? "selected" : ""%>>普通用户
                                </option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            性别
                        </td>
                        <td>
                            <input name="gender" type="radio" value="男"
                                   id="man" <%="男".equals(user.getGender()) ? "checked" : ""%>><label
                                for="man">男</label>
                            <input name="gender" type="radio" value="女"
                                   id="women" <%="女".equals(user.getGender()) ? "checked" : ""%>><label
                                for="women">女</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            出生日期
                        </td>
                        <td>
                            <input id="birthday" name="birthday" type="date" value="<%=user.getBirthday().toString()%>">
                        </td>
                    </tr>

                    <tr>
                        <td>
                            兴趣爱好
                        </td>
                        <td>
                            <input name="hobby" type="checkbox" value="阅读" id="reading"
                                <%=user.getHobby().contains("阅读")?"checked":""%>><label for="reading">阅读</label>
                            <input name="hobby" type="checkbox" value="音乐" id="music"
                                <%=user.getHobby().contains("音乐")?"checked":""%>><label for="music">音乐</label>
                            <input name="hobby" type="checkbox" value="运动" id="sport"
                                <%=user.getHobby().contains("运动")?"checked":""%>><label for="sport">运动</label>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            电子邮件
                        </td>
                        <td>
                            <input id="email" name="email" type="email" value="<%=user.getEmail()%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            自我介绍
                        </td>
                        <td>
                            <textarea id="introduction" name="introduction" rows="10"
                                      cols="30"><%=user.getIntro()%></textarea>
                        </td>
                    </tr>
                </table>

                <input name="id" value="<%=user.getId()%>" style="display: none">
                <div id="buttons">
                    <button id="submit" type="submit">提交</button>
                    <button type="reset" onclick="window.location.reload()">重置</button>
                </div>
            </form>
        </div>


        <script>

            function submitClick() {
                console.log(111);
                const userName_ = document.querySelector("#userName");
                const passwordOld_ = document.querySelector("#password_old");
                const password_ = document.querySelector("#password");
                const confirmPassword_ = document.querySelector("#confirmPassword");
                const type_ = document.querySelector("#type");
                const gender_ = document.querySelector("input[name='gender']:checked");
                const birthday_ = document.querySelector("#birthday");
                const hobby_ = document.querySelectorAll("input[name='hobby']:checked");
                const email_ = document.querySelector("#email");
                const introduction_ = document.querySelector("#introduction");

                if (userName_.value == "" ||
                    (passwordOld_.value != "" && (password_.value == "" || confirmPassword_.value == "")) ||
                    gender_ == null || birthday_.value == "" || hobby_ == null || hobby_.length == 0 ||
                    email_.value == "" || introduction_.value == "" ||
                    type_.selectedIndex == -1) {

                    alert("请填写完整！！！");

                    return false;
                }

                if (passwordOld_.value != "" && password_.value != confirmPassword_.value) {
                    confirmPassword_.value = "";
                    alert("两次输入的密码不一致");
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>
