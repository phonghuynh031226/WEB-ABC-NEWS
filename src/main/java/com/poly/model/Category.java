package com.poly.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
//@AllArgsConstructor
@NoArgsConstructor
public class Category {
    private String id;
    private String name;
    
    // ✅ Tự viết constructor 2 tham số
    public Category(String id, String name) {
        this.id = id;
        this.name = name;
    }
}
