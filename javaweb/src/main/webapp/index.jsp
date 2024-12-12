<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>信息管理系统</title>
    <style>
        body {
            background-color: #e0e0e0;
            font-family: monospace;
            margin: 0;
            padding: 0;
            color: #333;
        }
        #main-ctn {
            display: flex;
            flex-direction: row;
            min-height: 100vh;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);

        }
        #sideBar {
            width: 200px;
            background-color: #d0d0d0; -right: 1px solid #bbb;
            padding: 15px;

        }
        #frame {
            flex: 1;
            background-color: #fff;

        }
        .btn {
            background-color: #c0c0c0;
            color: #333;
            padding: 12px;
            margin-bottom: 8px;
            border: none;
            text-align: center;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease, transform 0.2s ease;
            border-radius: 3px;

        }

        .btn:hover {
            cursor: pointer;
            background-color: #b0b0b0;
            transform: scale(1.05);
        }
        .active {
            background-color: #909090 !important;
            color: white !important;
            transform: scale(1.05);

        }
        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        h1 {
            text-align: center;
            font-family: "Impact", sans-serif;
            padding: 25px;
            margin: 0;
            background-color: #808080;
            color: white;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }
        body {
            font-family: monospace;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;

        }
        td {
            padding: 8px;
            text-align: left;
        }
        button:hover {
            background-color: #c0c0c0;
        }
    </style>
</head>
<body>
<h1>信息管理系统</h1>
<div id="main-ctn">
    <div id="sideBar">
        <div id="btn1" class="btn active">用户注册</div>
        <div id="btn2" class="btn">用户管理</div>
        <div id="btn3" class="btn">文件管理</div>
    </div>

    <div id="frame">
        <iframe id="iframe" src="registerForm.jsp">

        </iframe>
    </div>

</div>


<script>
    const btn1 = document.getElementById("btn1");
    const btn2 = document.getElementById("btn2");
    const btn3 = document.getElementById("btn3");

    let btns = [btn1, btn2, btn3];
    let pages = ["registerForm.jsp", "search.jsp","listUploadFile.jsp"];

    for (let i = 0; i < btns.length; i++) {
        btns[i].addEventListener("click", (e) => {
            document.getElementById("iframe").setAttribute("src", pages[i]);
            for (let j = 0; j < btns.length; j++) {
                if (j !== i)
                    btns[j].classList.remove("active");
                else
                    btns[j].classList.add("active");
            }
        });
    }
</script>
</body>
</html>