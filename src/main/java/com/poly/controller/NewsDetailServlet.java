package com.poly.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.poly.dao.NewsDAO;
import com.poly.model.News;

@WebServlet("/news-detail")
public class NewsDetailServlet extends HttpServlet {
    private NewsDAO dao = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        News news = dao.findAll().stream()
                        .filter(n -> n.getId().equals(id))
                        .findFirst().orElse(null);

        request.setAttribute("news", news);
        request.getRequestDispatcher("/news-detail.jsp").forward(request, response);
    }
}
