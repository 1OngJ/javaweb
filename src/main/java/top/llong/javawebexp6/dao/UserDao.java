package top.llong.javawebexp6.dao;

import top.llong.javawebexp6.entity.User;
import top.llong.javawebexp6.form.UserModifyForm;
import top.llong.javawebexp6.form.UserRegisterForm;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 用户表 数据库操作工具类
 */
public class UserDao {

    // 连接对象
    private Connection connection;

    public UserDao(Connection connection) {
        this.connection = connection;
    }


    /**
     * 填充多个对象
     *
     * @param resultSet 结果集
     * @param users     待填充的用户对象列表
     * @throws SQLException
     */
    private static void fillResultSet(ResultSet resultSet, List<User> users) throws SQLException {
        while (resultSet.next()) {
            User user = new User();
            DaoUtil.fillFields(user, resultSet);
            users.add(user);
        }
    }

    /**
     * 修改用户
     *
     * @param userModifyForm 用户修改表单
     * @return 是否修改成功
     */
    public int modifyUser(UserModifyForm userModifyForm) {
        User userById = getUserById(Integer.valueOf(userModifyForm.getId()));
        String password = userById.getPassword();
        if (userModifyForm.getPasswordOld() != null && !userModifyForm.getPasswordOld().isBlank()) {
            // 进行密码校验
            if (!userById.getPassword().equals(userModifyForm.getPasswordOld())) {
                return -1;
            } else {
                password = userModifyForm.getPassword();
            }
        }


        try {
            String sql = "update user set name=?,password=?,type=?,gender=?,birthday=?,hobby=?,email=?,intro=? where id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userModifyForm.getUserName());
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, userModifyForm.getType());
            preparedStatement.setString(4, userModifyForm.getGender());
            preparedStatement.setDate(5, Date.valueOf(userModifyForm.getBirthday()));
            preparedStatement.setString(6, userModifyForm.getHobby());
            preparedStatement.setString(7, userModifyForm.getEmail());
            preparedStatement.setString(8, userModifyForm.getIntroduction());
            preparedStatement.setInt(9, userById.getId());

            int i = preparedStatement.executeUpdate();
            return i;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    /**
     * 获取所有用户
     *
     * @return 用户列表
     */
    public List<User> getAllUser() {
        List<User> users = new ArrayList<>();

        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("select * from user");
            fillResultSet(resultSet, users);
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    /**
     * 通过条件查找用户
     *
     * @param conditions 条件
     * @return 找到的用户列表
     */
    public List<User> getAllByCondition(Map<String, String[]> conditions) {



        List<User> users = new ArrayList<>();
        try {
            String sql = "select * from user where 1 = 1";
            Set<Map.Entry<String, String[]>> entries = conditions.entrySet();
            for (Map.Entry<String, String[]> stringStringEntry : entries) {
                sql += " and " + stringStringEntry.getKey() + " like ?";
            }
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            int i = 1;
            for (Map.Entry<String, String[]> entry : entries) {
                preparedStatement.setString(i, "%" + entry.getValue()[0] + "%");
                i++;
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            fillResultSet(resultSet, users);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    /**
     * 删除用户
     *
     * @param id 用户id
     * @return 是否成功
     */
    public boolean deleteUser(Integer id) {
        try {
            String sql = "delete from user where id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            int i = preparedStatement.executeUpdate();
            return i > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    /**
     * 通过用户id获取用户
     *
     * @param id 用户id
     * @return 用户
     */
    public User getUserById(Integer id) {
        User user = null;

        try {
            String sql = "select * from user where id = ?";

            connection.prepareStatement(sql);
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            List<User> users = new ArrayList<>();
            fillResultSet(resultSet, users);
            if (users.size() == 1) user = users.get(0);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    /**
     * 添加用户
     *
     * @param userRegisterForm 用户注册表单
     * @return 是否添加成功
     */
    public int addUser(UserRegisterForm userRegisterForm, String filePath) {

        try {
            String sql = "insert into user(name,password,type,gender,birthday,hobby,email,intro) values(?,?,?,?,?,?,?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, userRegisterForm.getUserName());
            preparedStatement.setString(2, userRegisterForm.getPassword());
            preparedStatement.setString(3, userRegisterForm.getType());
            preparedStatement.setString(4, userRegisterForm.getGender());
            preparedStatement.setDate(5, Date.valueOf(userRegisterForm.getBirthday()));
            preparedStatement.setString(6, userRegisterForm.getHobby());
            preparedStatement.setString(7, userRegisterForm.getEmail());
            preparedStatement.setString(8, userRegisterForm.getIntroduction());

            int i = preparedStatement.executeUpdate();
            return i;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
