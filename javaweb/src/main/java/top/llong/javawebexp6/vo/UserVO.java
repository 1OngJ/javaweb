package top.llong.javawebexp6.vo;

import top.llong.javawebexp6.entity.User;

/**
 * 用户对象视图
 */
public class UserVO {
    private Integer id;
    private String name;
    private String type;
    private String email;
    private String intro;
    private String birthday;
    private String hobby;
    private String gender;


    public UserVO(User user) {
        this.id = user.getId();
        this.name = user.getName();
        this.type = user.getType();
        this.email = user.getEmail();
        this.intro = user.getIntro();
        this.birthday = user.getBirthday().toString();
        this.gender = user.getGender();

        this.hobby = "";
        String[] hobbies = user.getHobby().replace("[", "").replace("]", "").split(",");
        for (int i = 0; i < hobbies.length; i++) {
            this.hobby += hobbies[i].trim();
            if (i < hobbies.length - 1) {
                this.hobby += "、";
            }
        }

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

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
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
}
