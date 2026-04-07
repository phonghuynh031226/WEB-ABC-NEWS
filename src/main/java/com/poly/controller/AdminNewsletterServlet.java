package com.poly.controller;

import com.poly.dao.NewsletterDAO;
import com.poly.model.Newsletter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/newsletter")
public class AdminNewsletterServlet extends HttpServlet {
    private NewsletterDAO dao = new NewsletterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String message = null;

        try {
            if ("delete".equals(action)) {
                dao.delete(email);
                message = "🗑️ Xóa email đăng ký thành công!";
            } else if ("toggle".equals(action)) {
                dao.toggle(email);
                message = "🔁 Cập nhật trạng thái đăng ký thành công!";
            }
        } catch (Exception e) {
            message = "⚠️ Lỗi xử lý dữ liệu!";
            e.printStackTrace();
        }

        List<Newsletter> list = dao.findAll();
        request.setAttribute("list", list);
        if (message != null) request.setAttribute("message", message);

        request.getRequestDispatcher("/admin_newsletter.jsp").forward(request, response);
    }
}
