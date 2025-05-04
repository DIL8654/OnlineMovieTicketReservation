package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.*;

public class SeatBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");
        String filePath = getServletContext().getRealPath("/seats.txt");

        List<String[]> seats = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                seats.add(line.split(","));
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String[] seat : seats) {
                String seatNumber = seat[0];
                String seatStatus = seat[1];

                if (action.startsWith("book_") && action.substring(5).equals(seatNumber) && seatStatus.equals("available")) {
                    // Book the seat
                    writer.write(seatNumber + "," + username);
                } else if (action.startsWith("cancel_") && action.substring(7).equals(seatNumber)) {
                    // Cancel the booking if the user is the one who booked it or is an admin
                    if (seatStatus.equals(username) || "admin".equals(role)) {
                        writer.write(seatNumber + ",available");
                    } else {
                        writer.write(seatNumber + "," + seatStatus);
                    }
                } else {
                    // Keep the seat as is
                    writer.write(seatNumber + "," + seatStatus);
                }
                writer.newLine();
            }
        }

        response.sendRedirect("seats.jsp");
    }
}