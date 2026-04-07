package com.poly.controller;

import java.io.IOException;
import java.util.List;
import com.poly.dao.NewsDAO;
import com.poly.model.News;
import com.poly.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/news")
public class AdminNewsServlet extends HttpServlet {
    private NewsDAO dao = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // 🔹 Nếu không có action thì hiển thị danh sách
        if (action == null) {
            List<News> list;
            if (user.isRole()) {
                list = dao.findAll(); // admin thấy tất cả
            } else {
                list = dao.findByAuthor(user.getId()); // phóng viên chỉ thấy bài của mình
            }
            request.setAttribute("list", list);
            request.getRequestDispatcher("/admin_news.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "edit":
                String id = request.getParameter("id");
                News n = dao.findById(id);
                request.setAttribute("news", n);
                request.setAttribute("list", user.isRole() ? dao.findAll() : dao.findByAuthor(user.getId()));
                request.getRequestDispatcher("/admin_news.jsp").forward(request, response);
                break;

            case "delete":
                News del = dao.findById(request.getParameter("id"));
                // 🔐 Chỉ cho phép xóa bài của chính mình hoặc admin
                if (user.isRole() || (del != null && del.getAuthor().equals(user.getId()))) {
                    dao.delete(request.getParameter("id"));
                    request.setAttribute("message", "❌ Xóa bản tin thành công!");
                } else {
                    request.setAttribute("message", "🚫 Bạn không có quyền xóa bài viết này!");
                }
                request.setAttribute("list", user.isRole() ? dao.findAll() : dao.findByAuthor(user.getId()));
                request.getRequestDispatcher("/admin_news.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect("news");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String image = request.getParameter("image");
        String categoryId = request.getParameter("category");
        boolean home = "true".equals(request.getParameter("home"));

        // 🔸 Gán tác giả là người đăng nhập
        String author = user.getId();

        News n = new News(id, title, content, image, new java.sql.Date(System.currentTimeMillis()),
                author, categoryId, 0, home);

        if (dao.findById(id) == null) {
            dao.insert(n);
            request.setAttribute("message", "🟢 Thêm bản tin thành công!");
        } else {
            // 🔐 Chỉ admin hoặc chính tác giả mới được cập nhật
            News old = dao.findById(id);
            if (user.isRole() || old.getAuthor().equals(user.getId())) {
                dao.update(n);
                request.setAttribute("message", "🔵 Cập nhật bản tin thành công!");
            } else {
                request.setAttribute("message", "🚫 Bạn không thể chỉnh sửa bài viết của người khác!");
            }
        }

        request.setAttribute("list", user.isRole() ? dao.findAll() : dao.findByAuthor(user.getId()));
        request.getRequestDispatcher("/admin_news.jsp").forward(request, response);
    }
}
