package top.llong.javawebexp6.dao;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUtil {

    /**
     * 填充对象参数
     *
     * @param obj 待填充的对象
     * @param rs  填充的数据集
     * @param <T> 对象类型
     * @return 填充好的对象
     */
    /**
     * 填充对象参数
     *
     * @param obj 待填充的对象
     * @param rs  填充的数据集
     * @param <T> 对象类型
     * @return 填充好的对象
     */
    public static <T> boolean fillFields(T obj, ResultSet rs) {
        Field[] declaredFields = obj.getClass().getDeclaredFields();
        for (Field field : declaredFields) {
            String name = field.getName();
            try {
                Object value = rs.getObject(name);
                String methodName = "set" + name.substring(0, 1).toUpperCase() + name.substring(1);
                Method method = null;
                if (name.equals("birthday")) {
                    method = obj.getClass().getMethod(methodName, Date.class);
                    value = rs.getDate(name);

                }
                else
                    method = obj.getClass().getMethod(methodName, field.getType());

                method.invoke(obj, value);
            } catch (SQLException e) {

            }
            catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        return true;
    }
}
