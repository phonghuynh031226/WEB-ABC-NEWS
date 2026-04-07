package com.poly.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
//@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String id;
    private String password;
    private String fullname;
    private Date birthday;
    private boolean gender;
    private String mobile;
    private String email;
    private boolean role; // true = Admin, false = Reporter
    
    // ✅ Thêm constructor 8 tham số này vào lớp User
    // Đây là bản sao của constructor mà Lombok lẽ ra phải tạo ra
    public User(String id, String password, String fullname, java.sql.Date birthday, boolean gender, String mobile, String email, boolean role) {
        this.id = id;
        this.password = password;
        this.fullname = fullname;
        this.birthday = birthday;
        this.gender = gender;
        this.mobile = mobile;
        this.email = email;
        this.role = role;
    }
}
