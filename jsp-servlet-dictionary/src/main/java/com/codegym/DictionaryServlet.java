package com.codegym;

import java.io.IOException;
import java.util.Locale;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** Looks up a word in the exercise's built-in English–Vietnamese dictionary. */
public class DictionaryServlet extends HttpServlet {
    private static final String RESULT_VIEW = "/WEB-INF/dictionary-result.jsp";
    private static final Map<String, String> DICTIONARY = Map.ofEntries(
            Map.entry("hello", "Xin chào"),
            Map.entry("how", "Thế nào"),
            Map.entry("book", "Quyển sách"),
            Map.entry("computer", "Máy tính"),
            Map.entry("student", "Sinh viên"),
            Map.entry("school", "Trường học"),
            Map.entry("water", "Nước"),
            Map.entry("thank you", "Cảm ơn"),
            Map.entry("good morning", "Chào buổi sáng")
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String submittedWord = request.getParameter("word");
        String searchWord = submittedWord == null ? "" : submittedWord.trim();
        request.setAttribute("searchWord", escapeHtml(searchWord));

        if (searchWord.isEmpty()) {
            request.setAttribute("wordFound", false);
            request.setAttribute("message", "Vui lòng nhập từ khóa để tra cứu.");
        } else {
            String translation = DICTIONARY.get(searchWord.toLowerCase(Locale.ROOT));
            request.setAttribute("wordFound", translation != null);

            if (translation != null) {
                request.setAttribute("translation", translation);
            } else {
                request.setAttribute("message", "Không tìm thấy từ: " + escapeHtml(searchWord));
            }
        }

        request.getRequestDispatcher(RESULT_VIEW).forward(request, response);
    }

    private static String escapeHtml(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
