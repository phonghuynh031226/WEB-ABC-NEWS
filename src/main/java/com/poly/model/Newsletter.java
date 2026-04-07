package com.poly.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
//@AllArgsConstructor
@NoArgsConstructor
public class Newsletter {
    private String email;
    private boolean enabled; // true = còn hiệu lực, false = hủy
    
    // ✅ Thêm constructor 2 tham số thủ công
    public Newsletter(String email, boolean enabled) {
        this.email = email;
        this.enabled = enabled;
    }
}
