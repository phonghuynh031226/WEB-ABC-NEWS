package com.poly.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.poly.dao.NewsDAO;
import com.poly.model.News;

@WebServlet("/news-list")
public class NewsListServlet extends HttpServlet {
    private NewsDAO dao = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<News> list = dao.findAll();
        request.setAttribute("newsList", list);
        request.getRequestDispatcher("/news-list.jsp").forward(request, response);
    }
}
