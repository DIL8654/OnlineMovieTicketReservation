package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;

public class AddMovieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieName = request.getParameter("movieName");
        String showDate = request.getParameter("showDate");
        String showTime = request.getParameter("showTime");

        if (movieName == null || movieName.isEmpty() || showDate == null || showDate.isEmpty() || showTime == null || showTime.isEmpty()) {
            response.sendRedirect("addMovie.jsp?error=1");
            return;
        }

        // Create a unique file name for the movie seats
        String fileName = movieName.replaceAll("\\s+", "_") + "_" + showDate + "_" + showTime.replace(":", "") + "_seats.txt";
        String filePath = getServletContext().getRealPath("/") + fileName;

        // Create the seats file with 100 available seats
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (int i = 1; i <= 100; i++) {
                writer.write(i + ",available");
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("addMovie.jsp?error=1");
            return;
        }

        // Redirect back to the dashboard
        response.sendRedirect("dashboard.jsp?success=1");
    }
}