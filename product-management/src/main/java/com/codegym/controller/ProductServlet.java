package com.codegym.controller;

import com.codegym.model.Product;
import com.codegym.service.ProductService;
import com.codegym.service.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Optional;

@WebServlet(name = "ProductServlet", urlPatterns = "/products")
public class ProductServlet extends HttpServlet {
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null || action.isBlank() || "list".equals(action)) {
            listProducts(request, response);
            return;
        }

        switch (action) {
            case "search" -> searchProducts(request, response);
            case "create" -> forward(request, response, "/WEB-INF/views/create.jsp");
            case "view" -> showProduct(request, response, "/WEB-INF/views/view.jsp");
            case "edit" -> showProduct(request, response, "/WEB-INF/views/edit.jsp");
            case "delete" -> showProduct(request, response, "/WEB-INF/views/delete.jsp");
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                Product created = productService.create(readProduct(request));
                redirectWithMessage(request, response, "created", created.getId());
            } else if ("update".equals(action)) {
                int id = parseId(request.getParameter("id"));
                if (!productService.update(id, readProduct(request))) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                redirectWithMessage(request, response, "updated", id);
            } else if ("delete".equals(action)) {
                int id = parseId(request.getParameter("id"));
                if (!productService.delete(id)) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/products?message=deleted");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            request.setAttribute("formName", request.getParameter("name"));
            request.setAttribute("formPrice", request.getParameter("price"));
            request.setAttribute("formDescription", request.getParameter("description"));
            request.setAttribute("formManufacturer", request.getParameter("manufacturer"));
            String formPage = "update".equals(action) ? "/WEB-INF/views/edit.jsp" : "/WEB-INF/views/create.jsp";
            if ("update".equals(action)) {
                try {
                    Optional<Product> product = productService.findById(parseId(request.getParameter("id")));
                    if (product.isEmpty()) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        return;
                    }
                    request.setAttribute("product", product.get());
                } catch (IllegalArgumentException ignored) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
            }
            request.getRequestDispatcher(formPage).forward(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("products", productService.findAll());
        forward(request, response, "/WEB-INF/views/list.jsp");
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("products", productService.searchByName(request.getParameter("q")));
        request.setAttribute("searchPerformed", true);
        forward(request, response, "/WEB-INF/views/list.jsp");
    }

    private void showProduct(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        int id;
        try {
            id = parseId(request.getParameter("id"));
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Optional<Product> product = productService.findById(id);
        if (product.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("product", product.get());
        forward(request, response, page);
    }

    private Product readProduct(HttpServletRequest request) {
        String name = request.getParameter("name");
        String priceText = request.getParameter("price");
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");

        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Vui lòng nhập tên sản phẩm.");
        }
        if (manufacturer == null || manufacturer.isBlank()) {
            throw new IllegalArgumentException("Vui lòng nhập nhà sản xuất.");
        }

        BigDecimal price;
        try {
            price = new BigDecimal(priceText);
        } catch (NumberFormatException | NullPointerException exception) {
            throw new IllegalArgumentException("Giá sản phẩm phải là một số hợp lệ.");
        }
        if (price.signum() < 0) {
            throw new IllegalArgumentException("Giá sản phẩm không được nhỏ hơn 0.");
        }

        return new Product(0, name.trim(), price, description == null ? "" : description.trim(), manufacturer.trim());
    }

    private int parseId(String value) {
        try {
            int id = Integer.parseInt(value);
            if (id < 1) {
                throw new NumberFormatException("ID must be positive");
            }
            return id;
        } catch (NumberFormatException | NullPointerException exception) {
            throw new IllegalArgumentException("Mã sản phẩm không hợp lệ.");
        }
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String message, int id)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/products?message=" + message + "&id=" + id);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        request.getRequestDispatcher(page).forward(request, response);
    }
}
