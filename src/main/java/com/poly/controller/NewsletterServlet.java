package com.poly.controller;

import com.poly.util.MailHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.mail.MessagingException;

@WebServlet("/newsletter")
public class NewsletterServlet extends HttpServlet {
    // cấu hình SMTP - thay đổi theo provider của bạn
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USER = "phonghuynh031226@gmail.com"; // thay
    private static final String SMTP_PASS = "rfcz tokr poul qdlf";   // thay (app password)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        resp.getWriter().write("NewsletterServlet đang hoạt động!");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        HttpSession session = req.getSession();

        if (email == null || email.trim().isEmpty()) {
            session.setAttribute("newsMessage", "Vui lòng nhập email.");
            resp.sendRedirect(req.getContextPath() + "/home"); // hoặc trang hiện tại
            return;
        }

        // TODO: (Tùy chọn) Lưu email vào DB bằng DAO nếu muốn tránh duplicate
        // ex: newsletterDao.save(email);

        // gửi email xác nhận
        MailHelper mail = new MailHelper(SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, true);
        String subject = "Xác nhận đăng ký nhận bản tin ABC News";
        String html = "<p>Xin chào!</p>"
                    + "<p>Cảm ơn bạn đã đăng ký nhận bản tin từ ABC News.</p>"
                    + "<p>Nếu bạn không đăng ký, hãy bỏ qua email này.</p>"
                    + "<br><p>ABC News</p>";

        try {
            mail.send(SMTP_USER, email, subject, html);
            session.setAttribute("newsMessage", "Đăng ký thành công! Kiểm tra email để xác nhận.");
        } catch (MessagingException ex) {
            ex.printStackTrace();
            session.setAttribute("newsMessage", "Gửi mail thất bại: " + ex.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
