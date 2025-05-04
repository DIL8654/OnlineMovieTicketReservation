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
        String seatNumber = request.getParameter("seatNumber");
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
                if (seat[0].equals(seatNumber) && seat[1].equals("available")) {
                    writer.write(seat[0] + "," + username);
                } else {
                    writer.write(seat[0] + "," + seat[1]);
                }
                writer.newLine();
            }
        }

        response.sendRedirect("seats.jsp");
    }
}