package top.llong.javawebexp6.entity;

import java.sql.Date;


/**
 * 用户实体类
 */
public class User {

    private Integer id;
    private String name;
    private String password;
    private String type;
    private String email;
    private String intro;
    private Date birthday;
    private String hobby;
    private String gender;
    private String fileName;
    private String fileIntro;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public User(Integer id, String name, String password, String type, String email, String intro, Date birthday, String hobby, String gender) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.type = type;
        this.email = email;
        this.intro = intro;
        this.birthday = birthday;
        this.hobby = hobby;
        this.gender = gender;
    }

    public User() {
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getHobby() {
        return hobby;
    }

    public void setHobby(String hobby) {
        this.hobby = hobby;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", name='" + name + '\'' + ", password='" + password + '\'' + ", type='" + type + '\'' + ", email='" + email + '\'' + ", intro='" + intro + '\'' + ", birthday=" + birthday + ", hobby='" + hobby + '\'' + ", gender='" + gender + '\'' + '}';
    }
}
