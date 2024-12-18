package top.llong.javawebexp6.UserServlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.*;

@WebServlet("/FileListServlet")
public class FileListServlet extends HttpServlet {
    private String projectSourcePath;

    @Override
    public void init() throws ServletException {
        super.init();
        ServletContext context = getServletContext();
        projectSourcePath = (String) context.getAttribute("projectSourcePath");
        System.out.println("FileListServlet projectSourcePath: " + projectSourcePath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取 ServletContext
        ServletContext context = getServletContext();

        // 使用相对于 webapp 的相对路径
        String relativeUploadPath = "upload";

        // 获取 webapp 目录的绝对路径
        String uploadPath = context.getRealPath(relativeUploadPath);

        System.out.println("FileListServlet uploadPath: " + uploadPath);

        File uploadDir = new File(uploadPath);

        // 获取文件列表
        File[] files = uploadDir.listFiles();

        // 用于存储文件信息的列表
        List<Map<String, String>> fileInfoList = new ArrayList<>();

        if (files != null && files.length > 0) {
            // 按照最后修改时间对文件进行倒序排序
            Arrays.sort(files, (f1, f2) -> Long.compare(f2.lastModified(), f1.lastModified()));

            for (File file : files) {
                if (file.isFile()) {
                    // 文件大小
                    long fileSize = file.length();
                    String formattedFileSize = fileSize < 1024 ? fileSize + " B" :
                            fileSize < 1024 * 1024 ? String.format("%.1f KB", fileSize / 1024.0) :
                                    String.format("%.1f MB", fileSize / (1024.0 * 1024.0));

                    // 文件名（解码）
                    String decodedFileName = URLDecoder.decode(file.getName(), "UTF-8");

                    // 文件简介
                    String introFilePath = uploadPath + File.separator + decodedFileName + ".intro";
                    File introFile = new File(introFilePath);
                    String fileIntro = "";
                    if (introFile.exists()) {
                        Properties prop = new Properties();
                        try (FileInputStream fis = new FileInputStream(introFile)) {
                            prop.load(fis);
                            fileIntro = prop.getProperty("intro", "");
                        } catch (Exception e) {
                            e.printStackTrace();
                            fileIntro = "读取简介失败"; // 添加错误提示
                        }
                    }

                    // 将文件信息添加到列表中
                    Map<String, String> fileInfo = new HashMap<>();
                    fileInfo.put("fileName", decodedFileName); // 使用解码后的文件名
                    fileInfo.put("fileSize", formattedFileSize);
                    fileInfo.put("fileIntro", fileIntro);
                    fileInfo.put("encodedFileName", file.getName()); // 编码后的文件名，用于下载链接
                    fileInfoList.add(fileInfo);
                }
            }
        }

        // 将文件信息列表保存到 request 中
        request.setAttribute("fileInfoList", fileInfoList);

        // 将请求转发到 JSP 页面
        request.getRequestDispatcher("listuploadfile.jsp").forward(request, response);
    }
}