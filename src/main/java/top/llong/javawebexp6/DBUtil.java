package top.llong.javawebexp6;

import javax.sql.DataSource;
import com.mysql.cj.jdbc.MysqlDataSource; // Or appropriate DataSource for your DB
import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static DataSource dataSource;

    static {
        try {
            initializeDataSource();
        } catch (SQLException e) {
            throw new RuntimeException("error: " + e.getMessage(), e);
        }
    }


    private static void initializeDataSource() throws SQLException {
        MysqlDataSource mysqlDS = new MysqlDataSource();
        mysqlDS.setURL("jdbc:mysql://www.namelessman.top:3306/JavaWebforLong?useUnicode=true&characterEncoding=UTF-8");
        mysqlDS.setUser("root");
        mysqlDS.setPassword("Fucku_bug");



        dataSource = mysqlDS;
    }



    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

}