<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow-lg" style="width: 25rem;">
            <h2 class="text-center mb-4">Register</h2>
            <form method="post" action="RegisterServlet">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control rounded-pill" id="username" name="username" placeholder="Enter your username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control rounded-pill" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-teal w-100 rounded-pill">Register</button>
            </form>
            <% if (request.getParameter("error") != null) { %>
                <p class="text-danger text-center mt-3">Registration failed. Please try again.</p>
            <% } %>
            <div class="text-center mt-3">
                <a href="login.jsp" class="text-teal">Already have an account? Login here</a>
            </div>
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
        .text-teal {
            color: teal;
        }
    </style>
</body>
</html>