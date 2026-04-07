package com.poly.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.poly.model.User;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Nếu chưa đăng nhập hoặc không phải admin
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isRole()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
    }
}
