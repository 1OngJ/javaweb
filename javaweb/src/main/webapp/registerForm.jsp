<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>注册</title>
    <style>
        body {
            font-family: monospace;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        #main {
            background-color: white;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
            width: 400px;
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
            width: calc(100% - 12px);
            padding: 5px;
            border: 1px solid #ccc;
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
            margin-right: 5px;
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

    <div id="ctn">
        <form id="main" action="${pageContext.request.contextPath}/UserServlet" method="post" enctype="multipart/form-data" onsubmit="return submitClick()">
            <input type="hidden" name="action" value="addUser">
            <table id="table">
                <tr>
                    <td>

                        <h1>注册</h1>

                    </td>
                </tr>
                <tr>
                    <td>
                        用户名
                    </td>
                    <td>
                        <input id="userName" name="userName">
                    </td>
                </tr>

                <tr>
                    <td>
                        密码
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
                            <option value="管理员">管理员</option>
                            <option value="普通用户">普通用户</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        性别
                    </td>
                    <td>
                        <input name="gender" type="radio" value="男" id="man"><label for="man">男</label>
                        <input name="gender" type="radio" value="女" id="women"><label for="women">女</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        出生日期
                    </td>
                    <td>
                        <input id="birthday" name="birthday" type="date">
                    </td>
                </tr>

                <tr>
                    <td>
                        兴趣爱好
                    </td>
                    <td>
                        <input name="hobby" type="checkbox" value="阅读" id="reading"><label
                            for="reading">阅读</label>
                        <input name="hobby" type="checkbox" value="音乐" id="music"><label for="music">音乐</label>
                        <input name="hobby" type="checkbox" value="运动" id="sport"><label for="sport">运动</label>
                    </td>
                </tr>

                <tr>
                    <td>
                        电子邮件
                    </td>
                    <td>
                        <input id="email" name="email" type="email">
                    </td>
                </tr>
                <tr>
                    <td>
                        自我介绍
                    </td>
                    <td>
                        <textarea id="introduction" name="introduction" rows="10" cols="30"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        上传文件
                    </td>
                    <td>
                        <input id="file" name="file" type="file">
                    </td>
                </tr>
            </table>

            <div id="buttons">
                <button id="submit" type="submit">提交</button>
                <button type="reset">重置</button>
            </div>
        </form>
    </div>

    <script>

        function submitClick() {
            console.log(111);
            const userName_ = document.querySelector("#userName");
            const password_ = document.querySelector("#password");
            const confirmPassword_ = document.querySelector("#confirmPassword");
            const type_ = document.querySelector("#type");
            const gender_ = document.querySelector("input[name='gender']:checked");
            const birthday_ = document.querySelector("#birthday");
            const hobby_ = document.querySelectorAll("input[name='hobby']:checked");
            const email_ = document.querySelector("#email");
            const introduction_ = document.querySelector("#introduction");
            const file_ = document.querySelector("#file");

            if (userName_.value == "" ||
                password_.value == "" || confirmPassword_.value == "" ||
                gender_ == null || birthday_.value == "" || hobby_ == null || hobby_.length == 0 ||
                email_.value == "" || introduction_.value == "" ||
                type_.selectedIndex == -1) {

                alert("请填写完整！！！");

                return false;
            }

            if (password_.value != confirmPassword_.value) {
                confirmPassword_.value = "";
                alert("两次输入的密码不一致");
                return false;
            }
            // 对文件大小进行验证
            if (file_.files.length > 0) {
                if(file_.files[0].size > 1024 * 1024 * 2) {
                    alert("上传的文件不能超过2MB");
                    return false;
                }
            }
            return true;
        }
        </script>
    </body>
</html>
