package com.poly.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

@WebFilter("/*")
public class I18nFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        String lang = req.getParameter("lang");

        // Nếu URL có ?lang=... thì lưu vào session
        if (lang != null) {
            req.getSession().setAttribute("lang", lang);
        }

        chain.doFilter(request, response);
    }
}
