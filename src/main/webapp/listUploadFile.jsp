<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
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
        ServletContext context = application;
        String projectSourcePath = (String) context.getAttribute("projectSourcePath");

        String uploadPath = projectSourcePath + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "upload";
        File uploadDir = new File(uploadPath);

        File[] files = uploadDir.listFiles();

        if (files != null && files.length > 0) {
            Arrays.sort(files, (f1, f2) -> Long.compare(f2.lastModified(), f1.lastModified()));

            for (File file : files) {
                if (file.isFile()) {
                    long fileSize = file.length();
                    String formattedFileSize = fileSize < 1024 ? fileSize + " B" :
                            fileSize < 1024 * 1024 ? String.format("%.1f KB", fileSize / 1024.0) :
                                    String.format("%.1f MB", fileSize / (1024.0 * 1024.0));
                    String relativeFilePath = "upload" + File.separator + file.getName();

                    String encodedFilePath = URLEncoder.encode(relativeFilePath, "UTF-8");

                    // 获取文件简介
                    String introFilePath = uploadPath + File.separator + file.getName() + ".intro";
                    File introFile = new File(introFilePath);
                    String fileIntro = "";
                    if (introFile.exists()) {
                        Properties prop = new Properties();
                        try (FileInputStream fis = new FileInputStream(introFile)) {
                            prop.load(fis);
                            fileIntro = prop.getProperty("intro", "");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
    %>
    <tr>
        <td><%=file.getName()%></td>
        <td class="file-size"><%=formattedFileSize%></td>
        <td class="file-intro"><%=fileIntro%></td>
        <td>
            <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/download?filePath=<%=encodedFilePath%>'">下载</button>

        </td>
    </tr>
    <%
            }
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