package com.poly.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
//@AllArgsConstructor
@NoArgsConstructor
public class News {
    private String id;
    private String title;
    private String content;
    private String image;
    private Date postedDate;
    private String author;      // Mã người dùng (User.Id)
    private String categoryId;  // Mã loại tin (Category.Id)
    private int viewCount;
    private boolean home;       // true = hiển thị trên trang chủ
    
    
    // ✅ Constructor thủ công 9 tham số
    public News(String id, String title, String content, String image, java.sql.Date postedDate, String author, String categoryId, int viewCount, boolean home) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.postedDate = postedDate;
        this.author = author;
        this.categoryId = categoryId;
        this.viewCount = viewCount;
        this.home = home;
    }
}
