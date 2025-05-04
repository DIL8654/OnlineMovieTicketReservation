<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movies</title>
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
        <h2 class="text-center mb-4">Available Movies</h2>
        <div class="row">
            <%
                // Directory where movie seat files are stored
                String movieDirPath = application.getRealPath("/");
                File movieDir = new File(movieDirPath);

                // Filter files that match the movie seat file naming convention
                File[] movieFiles = movieDir.listFiles((dir, name) -> name.endsWith("_seats.txt"));

                if (movieFiles != null && movieFiles.length > 0) {
                    for (File movieFile : movieFiles) {
                        // Extract movie name from the file name
                        String fileName = movieFile.getName();
                        String movieName = fileName.substring(0, fileName.indexOf("_seats.txt")).replace("_", " ");
            %>
            <div class="col-md-4 mb-4">
                <div class="card shadow">
                    <img src="images/default_movie.jpg" class="card-img-top" alt="<%= movieName %>">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= movieName %></h5>
                        <a href="seats.jsp?movie=<%= fileName %>" class="btn btn-teal rounded-pill">Book</a>
                    </div>
                </div>
            </div>
            <% 
                    }
                } else { 
            %>
            <p class="text-center">No movies available at the moment.</p>
            <% } %>
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