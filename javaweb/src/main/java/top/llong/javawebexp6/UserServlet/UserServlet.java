package top.llong.javawebexp6.UserServlet;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import top.llong.javawebexp6.DBUtil;
import top.llong.javawebexp6.dao.UserDao;
import top.llong.javawebexp6.entity.User;
import top.llong.javawebexp6.form.UserModifyForm;
import top.llong.javawebexp6.form.UserRegisterForm;

import java.io.File;
import java.util.HashMap;
import java.util.UUID;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/UserServlet")
@MultipartConfig
public class UserServlet extends HttpServlet {
    private UserDao userDao;
    // 相对路径
    private static final String UPLOAD_DIRECTORY = "upload";
    private String projectSourcePath; // 用于存储项目源代码目录的绝对路径

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        Connection connection = null;
        try {
            connection = DBUtil.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        userDao = new UserDao(connection);

        // 获取 ServletContext
        ServletContext context = getServletContext();

        // 获取项目部署后的根目录的绝对路径
        String appPath = context.getRealPath("");

        // 获取 webapp 目录的绝对路径
        String webappPath = new File(appPath).getParent();

        // 获取 src 目录的绝对路径
        String srcPath = new File(webappPath).getParent();

        // 获取 main 目录的绝对路径
        String mainPath = new File(srcPath).getParent();

        // 获取项目源代码目录的绝对路径
        projectSourcePath = new File(mainPath).getParent();

        // 将项目源代码目录的绝对路径存储为 ServletContext 的属性
        context.setAttribute("projectSourcePath", projectSourcePath);
        System.out.println("projectSourcePath: " + projectSourcePath);

        // 初始化一个 Map 来存储 UUID 文件名和原始文件名的对应关系
        Map<String, String> fileNamesMap = new HashMap<>();
        context.setAttribute("fileNamesMap", fileNamesMap);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addUser".equals(action)) {
            register(request, response);
        } else if ("modifyUser".equals(action)) {
            modifyUser(request, response);
        } else if ("getUserById".equals(action)) {
            getUserById(request, response);
        } else if ("searchUser".equals(action)) {
            searchUser(request,response);
        }
    }

    private void searchUser(HttpServletRequest request, HttpServletResponse response) {
        UserDao userDao = null;
        try {
            userDao = new UserDao(DBUtil.getConnection());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        Map<String, String[]> parameterMap = request.getParameterMap();
        List<User> allUsers = userDao.getAllByCondition(parameterMap);

        request.setAttribute("allUsers", allUsers); // 确保 User 对象列表被设置

        try {
            request.getRequestDispatcher("search.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }



    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserRegisterForm registerForm = new UserRegisterForm();
        registerForm.setUserName(request.getParameter("userName"));
        registerForm.setPassword(request.getParameter("password"));
        registerForm.setType(request.getParameter("type"));
        registerForm.setGender(request.getParameter("gender"));
        registerForm.setBirthday(request.getParameter("birthday"));
        registerForm.setHobby(request.getParameterValues("hobby"));
        registerForm.setEmail(request.getParameter("email"));
        registerForm.setIntroduction(request.getParameter("introduction"));


        Part filePart = request.getPart("file");
        String fileName = getSubmittedFileName(filePart);
        String originalFileName = fileName; // 保存原始文件名
        String savePath = "";
        if(fileName != null && !fileName.isBlank()){
            // 获取上传目录的绝对路径
            String uploadPath = projectSourcePath + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + UPLOAD_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            // 使用UUID重命名文件，避免文件名冲突
            fileName = UUID.randomUUID() + fileName.substring(fileName.lastIndexOf("."));

            // 构建文件的完整保存路径
            savePath = uploadPath + File.separator + fileName;
            // 将文件写入指定路径
            filePart.write(savePath);
            // 保存相对路径到数据库
            savePath = UPLOAD_DIRECTORY + File.separator + fileName;

            // 获取 ServletContext 中的 fileNamesMap
            ServletContext context = getServletContext();
            Map<String, String> fileNamesMap = (Map<String, String>) context.getAttribute("fileNamesMap");

            // 将 UUID 文件名和原始文件名的对应关系存储到 Map 中
            fileNamesMap.put(fileName, originalFileName);
        }

        int result = userDao.addUser(registerForm, savePath);
        if (result > 0) {
            request.setAttribute("message", "用户添加成功！");
            if(!savePath.isBlank()) request.setAttribute("filePath", savePath);
        } else {
            request.setAttribute("message", "用户添加失败！");
        }
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    private void modifyUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int state;
        UserModifyForm userModifyForm = new UserModifyForm();

        userModifyForm.setUserName(request.getParameter("userName"));
        userModifyForm.setPassword(request.getParameter("password"));
        userModifyForm.setType(request.getParameter("type"));
        userModifyForm.setBirthday(request.getParameter("birthday"));
        userModifyForm.setGender(request.getParameter("gender"));
        userModifyForm.setIntroduction(request.getParameter("introduction"));
        userModifyForm.setHobby(request.getParameterValues("hobby"));
        userModifyForm.setEmail(request.getParameter("email"));
        userModifyForm.setId(request.getParameter("id"));
        userModifyForm.setPasswordOld(request.getParameter("password_old"));

        if (!userModifyForm.validate()) {
            state = -2;
        } else {

            UserDao userDao = null;
            try {
                userDao = new UserDao(DBUtil.getConnection());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            state = userDao.modifyUser(userModifyForm);
        }

        request.setAttribute("state", getStateStr(state));

        request.getRequestDispatcher("modifyForm.jsp").forward(request, response);
    }

    private String getStateStr(int state) {
        return switch (state) {
            case 0 -> "修改失败";
            case 1 -> "修改成功";
            case -1 -> "旧密码错误";
            case -2 -> "参数未填写完整";
            default -> "";
        };
    }

    private void getUserById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userDao.getUserById(userId);

        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("viewUser.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "用户未找到！");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    private static String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

}