package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AuthService;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/users.txt");
        authService = new AuthService(filePath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String authResult = authService.authenticate(username, password);

        if ("authenticated".equals(authResult)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", authService.getRole(username, password));
            response.sendRedirect("dashboard.jsp");
        } else if ("deactivated".equals(authResult)) {
            response.sendRedirect("login.jsp?error=deactivated");
        } else if ("invalid_password".equals(authResult)) {
            response.sendRedirect("login.jsp?error=invalid_password");
        } else {
            response.sendRedirect("login.jsp?error=user_not_found");
        }
    }
}