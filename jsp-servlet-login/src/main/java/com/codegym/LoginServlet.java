package com.codegym;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** Checks the exercise's fixed credentials and forwards to the result page. */
public class LoginServlet extends HttpServlet {
    private static final String DEMO_USERNAME = "admin";
    private static final String DEMO_PASSWORD = "admin";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean loginSuccess = DEMO_USERNAME.equals(username) && DEMO_PASSWORD.equals(password);

        request.setAttribute("loginSuccess", loginSuccess);
        request.getRequestDispatcher("/WEB-INF/login-result.jsp").forward(request, response);
    }
}
