package com.poly.controller;

import com.poly.dao.NewsDAO;
import com.poly.model.News;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/home", ""})
//@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private NewsDAO dao = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<News> list = dao.findHomeNews(); // chỉ lấy tin có Home = true
        request.setAttribute("list", list);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
