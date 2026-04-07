package com.poly.controller;

import com.poly.dao.UserDAO;
import com.poly.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/user")
public class AdminUserServlet extends HttpServlet {
    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String message = null;

        if ("delete".equals(action)) {
            String id = request.getParameter("id");
            dao.delete(id);
            message = "🗑️ Xóa người dùng thành công!";
        }

        List<User> list = dao.findAll();
        request.setAttribute("list", list);
        if (message != null) request.setAttribute("message", message);

        request.getRequestDispatcher("/admin_user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String birthdayStr = request.getParameter("birthday");
        Date birthday = null;
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            birthday = Date.valueOf(birthdayStr);
        }

        boolean gender = "true".equals(request.getParameter("gender"));
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        boolean role = "true".equals(request.getParameter("role"));

        User u = new User(id, password, fullname, birthday, gender, mobile, email, role);

        User existing = dao.findById(id);
        if (existing == null) {
            dao.insert(u);
            request.setAttribute("message", "✅ Thêm người dùng mới thành công!");
        } else {
            dao.update(u);
            request.setAttribute("message", "✏️ Cập nhật thông tin người dùng thành công!");
        }

        List<User> list = dao.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/admin_user.jsp").forward(request, response);
    }
}
