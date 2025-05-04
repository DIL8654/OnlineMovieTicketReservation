<!-- filepath: /Users/dilankamm/Documents/aize/sourcecodes/personal/OnlineMovieTicketReservation/WebContent/seats.jsp -->
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seat Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg" style="background: linear-gradient(to right, teal, #006d6d);">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-white" href="dashboard.jsp">Online Movie Ticket Reservation</a>
            <div class="d-flex">
                <a href="dashboard.jsp" class="btn btn-outline-light me-2">Dashboard</a>
                <a href="LogoutServlet" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
      </nav>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Movie Theater Seat Booking</h2>
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String filePath = application.getRealPath("/seats.txt");
            List<String[]> seats = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    seats.add(line.split(","));
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        %>
        <form method="post" action="SeatBookingServlet">
            <table class="table table-bordered text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Seat Number</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] seat : seats) { %>
                        <tr>
                            <td><%= seat[0] %></td>
                            <td><%= seat[1].equals("available") ? "Available" : "Booked by " + seat[1] %></td>
                            <td>
                                <% if (seat[1].equals("available")) { %>
                                    <!-- Book Button -->
                                    <button type="submit" name="action" value="book_<%= seat[0] %>" class="btn btn-teal rounded-pill">Book</button>
                                <% } else if (seat[1].equals(session.getAttribute("user")) || "admin".equals(session.getAttribute("role"))) { %>
                                    <!-- Cancel Button -->
                                    <button type="submit" name="action" value="cancel_<%= seat[0] %>" class="btn btn-danger rounded-pill">Cancel</button>
                                <% } else { %>
                                    <!-- Disabled Button -->
                                    <button class="btn btn-secondary rounded-pill" disabled>Booked</button>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </form>
        <div class="text-center mt-4">
            <a href="dashboard.jsp" class="btn btn-teal rounded-pill">Back to Dashboard</a>
        </div>
    </div>
    <style>
        .btn-teal {
            background-color: teal;
            color: white;
        }
        .btn-teal:hover {
            background-color: #006d6d;
        }
    </style>
</body>
</html>