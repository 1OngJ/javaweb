package top.llong.javawebexp6.UserServlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

@WebServlet("/download")
public class DownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 获取文件路径参数，现在是相对于 webapp 的相对路径，并进行 URL 解码
        String filePath = URLDecoder.decode(request.getParameter("filePath"), "UTF-8");
        if (filePath == null || filePath.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "filePath 参数不能为空");
            return;
        }

        // 2. 获取ServletContext和webapp目录的绝对路径
        ServletContext context = getServletContext();
        String webappDir = context.getRealPath("/");

        // 3. 构建文件的绝对路径，现在基于 webapp 目录
        String fullPath = webappDir + filePath;

        // 4. 安全性检查：防止路径遍历攻击, 确保文件在 upload 目录下
        String uploadDirectory = webappDir + "upload" + File.separator;

        // 使用 java.nio.file.Paths 和 java.nio.file.Path 来处理路径
        Path uploadPath = Paths.get(uploadDirectory).normalize();
        Path requestedPath = Paths.get(fullPath).normalize();

        if (!requestedPath.startsWith(uploadPath)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "禁止访问");
            return;
        }

        // 5. 读取文件
        File fileToDownload = new File(requestedPath.toString());
        if (!fileToDownload.exists() || !fileToDownload.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "文件未找到");
            return;
        }

        try (FileInputStream fileInputStream = new FileInputStream(fileToDownload);
             OutputStream outputStream = response.getOutputStream()) {

            // 6. 设置响应头
            response.setContentType("application/octet-stream"); // 设置为二进制流

            // 从 ServletContext 的 fileNamesMap 中获取原始文件名
            Map<String, String> fileNamesMap = (Map<String, String>) context.getAttribute("fileNamesMap");
            String fileName = filePath.substring(filePath.lastIndexOf("/") + 1); // 获取上传时的文件名
            String originalFileName = fileNamesMap.getOrDefault(fileName, fileName); // 获取原始文件名，如果找不到则使用上传时的文件名

            // 使用 attachment; filename*=UTF-8''filename 的格式设置 Content-Disposition 头部
            String encodedFileName = URLEncoder.encode(originalFileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);

            // 7. 将文件内容写入响应输出流
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "文件下载失败");
        }
    }
}