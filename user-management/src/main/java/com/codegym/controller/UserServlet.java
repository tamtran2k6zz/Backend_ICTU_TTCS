package com.codegym.controller;

import com.codegym.dao.UserDAO;
import com.codegym.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

/** Handles user list, CRUD, country search, and name sorting requests. */
public class UserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            switch (action == null ? "list" : action) {
                case "create" -> forward(request, response, "/user/create.jsp");
                case "edit" -> showUserForm(request, response, "/user/edit.jsp");
                case "delete" -> showUserForm(request, response, "/user/delete.jsp");
                case "list", "search", "sort" -> listUsers(request, response);
                default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException exception) {
            showDatabaseError(request, response);
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                User newUser = readUser(request, 0);
                int[] permissionIds = parsePermissionIds(request.getParameterValues("permissions"));
                userDAO.addUserTransaction(newUser, permissionIds);
            } else if ("edit".equals(action)) {
                int id = parseId(request.getParameter("id"));
                if (!userDAO.updateUser(readUser(request, id))) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
            } else if ("delete".equals(action)) {
                if (!userDAO.deleteUser(parseId(request.getParameter("id")))) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/users?message=" + action);
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            String formPage;
            if ("edit".equals(action)) {
                formPage = "/user/edit.jsp";
                try {
                    User existingUser = userDAO.selectUser(parseId(request.getParameter("id")));
                    if (existingUser == null) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        return;
                    }
                    if (request.getAttribute("user") == null) {
                        request.setAttribute("user", existingUser);
                    }
                } catch (IllegalArgumentException invalidId) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                } catch (SQLException databaseError) {
                    showDatabaseError(request, response);
                    return;
                }
            } else if ("create".equals(action)) {
                formPage = "/user/create.jsp";
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            forward(request, response, formPage);
        } catch (SQLException exception) {
            showDatabaseError(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = request.getParameter("country");
        String sortOrder = "DESC".equalsIgnoreCase(request.getParameter("sort")) ? "DESC" : "ASC";
        request.setAttribute("listUser", userDAO.selectAllUsers(country, sortOrder));
        request.setAttribute("countryFilter", country == null ? "" : country.trim());
        request.setAttribute("sortOrder", sortOrder);
        forward(request, response, "/user/list.jsp");
    }

    private void showUserForm(HttpServletRequest request, HttpServletResponse response, String page)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        User user = "/user/edit.jsp".equals(page)
                ? userDAO.getUserById(id)
                : userDAO.selectUser(id);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("user", user);
        forward(request, response, page);
    }

    private User readUser(HttpServletRequest request, int id) {
        String name = parameter(request, "name");
        String email = parameter(request, "email");
        String country = parameter(request, "country");
        User user = new User(id, name, email, country);
        request.setAttribute("user", user);

        if (name.isBlank() || email.isBlank() || country.isBlank()) {
            throw new IllegalArgumentException("Vui lòng nhập đầy đủ tên, email và quốc gia.");
        }
        if (name.length() > 120 || email.length() > 220 || country.length() > 120) {
            throw new IllegalArgumentException("Một hoặc nhiều trường vượt quá độ dài cho phép.");
        }
        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            throw new IllegalArgumentException("Email không hợp lệ.");
        }

        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setCountry(country.trim());
        return user;
    }

    private String parameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value == null ? "" : value.trim();
    }

    private int[] parsePermissionIds(String[] permissionValues) {
        if (permissionValues == null || permissionValues.length == 0) {
            return new int[0];
        }

        int[] permissionIds = new int[permissionValues.length];
        for (int index = 0; index < permissionValues.length; index++) {
            try {
                permissionIds[index] = Integer.parseInt(permissionValues[index]);
            } catch (NumberFormatException exception) {
                throw new IllegalArgumentException("Quyền hạn được chọn không hợp lệ.");
            }
            if (permissionIds[index] < 1 || permissionIds[index] > 4) {
                throw new IllegalArgumentException("Quyền hạn được chọn không hợp lệ.");
            }
        }
        return permissionIds;
    }

    private int parseId(String value) {
        try {
            int id = Integer.parseInt(value);
            if (id < 1) {
                throw new NumberFormatException("ID must be positive");
            }
            return id;
        } catch (NumberFormatException | NullPointerException exception) {
            throw new IllegalArgumentException("Mã User không hợp lệ.");
        }
    }

    private void showDatabaseError(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        request.setAttribute("error", "Không thể kết nối hoặc thao tác với cơ sở dữ liệu. Hãy kiểm tra cấu hình MySQL.");
        forward(request, response, "/user/error.jsp");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        request.getRequestDispatcher(page).forward(request, response);
    }
}
