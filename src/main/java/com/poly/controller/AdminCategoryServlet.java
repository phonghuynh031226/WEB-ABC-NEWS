package com.poly.controller;

import com.poly.dao.CategoryDAO;
import com.poly.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/category")
public class AdminCategoryServlet extends HttpServlet {
    private CategoryDAO dao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("delete")) {
            String id = request.getParameter("id");
            dao.delete(id);
            request.setAttribute("message", "🗑️ Xóa loại tin thành công!");
        }

        List<Category> list = dao.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/admin_category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");

        Category category = new Category(id, name);

        // Kiểm tra tồn tại
        Category existing = dao.findById(id);
        if (existing == null) {
            dao.insert(category);
            request.setAttribute("message", "✅ Thêm loại tin thành công!");
        } else {
            dao.update(category);
            request.setAttribute("message", "✏️ Cập nhật loại tin thành công!");
        }

        List<Category> list = dao.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/admin_category.jsp").forward(request, response);
    }
}
