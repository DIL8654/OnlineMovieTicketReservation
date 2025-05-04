<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Movie</title>
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
        <h2 class="text-center mb-4">Add New Movie</h2>
        <form method="post" action="AddMovieServlet" class="card p-4 shadow-lg">
            <div class="mb-3">
                <label for="movieName" class="form-label">Movie Name</label>
                <input type="text" class="form-control rounded-pill" id="movieName" name="movieName" placeholder="Enter movie name" required>
            </div>
            <div class="mb-3">
                <label for="showDate" class="form-label">Show Date</label>
                <input type="date" class="form-control rounded-pill" id="showDate" name="showDate" required>
            </div>
            <div class="mb-3">
                <label for="showTime" class="form-label">Show Time</label>
                <select class="form-select rounded-pill" id="showTime" name="showTime" required>
                    <option value="09:00">09:00</option>
                    <option value="12:00">12:00</option>
                    <option value="15:00">15:00</option>
                    <option value="18:00">18:00</option>
                    <option value="21:00">21:00</option>
                </select>
            </div>
            <button type="submit" class="btn btn-teal w-100 rounded-pill">Add Movie</button>
        </form>
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