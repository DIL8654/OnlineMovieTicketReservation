package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;

public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String originalUsername = request.getParameter("originalUsername");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String status = request.getParameter("status"); // New field for user status (active or deactivated)

        String filePath = getServletContext().getRealPath("/users.txt");
        List<String[]> users = new ArrayList<>();
        boolean isNewUser = (originalUsername == null || originalUsername.isEmpty());

        if (!isNewUser) {
            // Update existing user
            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] user = line.split(",");
                    if (user[0].equals(originalUsername)) {
                        users.add(new String[]{username, password, role, firstName, lastName, status});
                    } else {
                        // Ensure the status field is included for existing users
                        if (user.length < 6) {
                            user = Arrays.copyOf(user, 6);
                            user[5] = "active"; // Default to active if status is missing
                        }
                        users.add(user);
                    }
                }
            }
        } else {
            // Add new user
            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    users.add(line.split(","));
                }
            }
            users.add(new String[]{username, password, role, firstName, lastName, "active"}); // New users are active by default
        }

        // Write updated user list back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String[] user : users) {
                writer.write(String.join(",", user));
                writer.newLine();
            }
        }

        response.sendRedirect("dashboard.jsp");
    }
}