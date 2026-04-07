package com.poly.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.poly.dao.UserDAO;
import com.poly.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Nếu đã đăng nhập rồi thì chuyển hướng luôn
        if (session != null && session.getAttribute("user") != null) {
            User u = (User) session.getAttribute("user");
            if (u.isRole()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/news");
            }
            return;
        }

        // Chưa đăng nhập -> hiển thị form login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("username");
        String pw = request.getParameter("password");

        User user = dao.findById(id);

        if (user != null && user.getPassword().equals(pw)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.isRole()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/news");
            }
        } else {
            request.setAttribute("message", "❌ Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
