package top.llong.javawebexp6.form;

import java.util.Arrays;

public class UserModifyForm {
    private String id;
    private String userName;
    private String passwordOld;
    private String password;
    private String type;
    private String gender;
    private String birthday;
    private String hobby;
    private String email;
    private String introduction;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPasswordOld() {
        return passwordOld;
    }

    public void setPasswordOld(String passwordOld) {
        this.passwordOld = passwordOld;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public void setHobby(String[] hobby) {
        this.hobby = Arrays.toString(hobby);

    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }


    public boolean validate() {
        return !(id == null || id.isBlank() || userName == null || userName.isBlank() || !(((passwordOld == null || passwordOld.isBlank())) || (password != null && !password.isBlank())) ||
                type == null || type.isBlank() || gender == null || gender.isBlank() || birthday == null || birthday.isBlank() ||
                hobby == null || hobby.isBlank() || email == null || email.isBlank() || introduction == null || introduction.isBlank());
    }
}
