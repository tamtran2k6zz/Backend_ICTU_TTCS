package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** A small servlet endpoint used to verify the Jakarta Servlet setup. */
public class HelloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!doctype html>");
            out.println("<html lang=\"vi\"><head><meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            out.println("<title>Hello Servlet</title>");
            out.println("<link rel=\"stylesheet\" href=\"" + request.getContextPath() + "/assets/styles.css\">");
            out.println("</head><body><main class=\"message-card\">");
            out.println("<p class=\"eyebrow\">JAKARTA SERVLET · TOMCAT 10+</p>");
            out.println("<h1>Chào mừng bạn đến với Servlet đầu tiên!</h1>");
            out.println("<p>Ứng dụng JSP/Servlet đang hoạt động.</p>");
            out.println("<a class=\"button-link\" href=\"" + request.getContextPath() + "/\">Quay lại trang thời gian</a>");
            out.println("</main></body></html>");
        }
    }
}
