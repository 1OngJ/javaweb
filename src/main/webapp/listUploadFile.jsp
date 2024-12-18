<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>已上传文件列表</title>
    <style>
        body {
            font-family: monospace;
            background-color: #f0f0f0;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #a0a0a0;
            color: white;
        }
        a {
            color: #004e8f;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .file-size {
            font-size: smaller;
            color: #777;
        }
        .file-intro {
            font-size: smaller;
            color: #555;
        }
    </style>
</head>
<body>

<h1>已上传文件列表</h1>

<table>
    <thead>
    <tr>
        <th>文件名</th>
        <th>文件大小</th>
        <th>文件简介</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Map<String, String>> fileInfoList = (List<Map<String, String>>) request.getAttribute("fileInfoList");
        if (fileInfoList != null && !fileInfoList.isEmpty()) {
            for (Map<String, String> fileInfo : fileInfoList) {
                // 从 fileInfo 中获取每个文件的信息
                String fileName = fileInfo.get("fileName");
                String fileSize = fileInfo.get("fileSize");
                String fileIntro = fileInfo.get("fileIntro");
                String encodedFileName = fileInfo.get("encodedFileName");

                // 构建下载链接的 onclick 事件
                // 使用 encodeURIComponent 对 JavaScript 中的文件名进行编码
                String onclick = "window.location.href='" + request.getContextPath() +
                        "/download?filePath=upload/" + encodedFileName + "'";
    %>
    <tr>
        <td><%= fileName %></td>
        <td class="file-size"><%= fileSize %></td>
        <td class="file-intro"><%= fileIntro %></td>
        <td>
            <button type="button" onclick="<%= onclick %>">下载</button>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="4">没有上传的文件</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>