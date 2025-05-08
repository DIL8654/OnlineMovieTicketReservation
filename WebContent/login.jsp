<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow-lg" style="width: 25rem;">
            <h2 class="text-center mb-4">Login</h2>
            <form method="post" action="LoginServlet">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control rounded-pill" id="username" name="username" placeholder="Enter your username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control rounded-pill" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-teal w-100 rounded-pill">Login</button>
            </form>
            <% if (request.getParameter("error") != null) { %>
                <p class="text-danger text-center mt-3">
                    <% if ("deactivated".equals(request.getParameter("error"))) { %>
                        Your account has been deactivated. Please contact the administrator.
                    <% } else if ("invalid_password".equals(request.getParameter("error"))) { %>
                        Invalid password. Please try again.
                    <% } else if ("user_not_found".equals(request.getParameter("error"))) { %>
                        User not found. Please register first.
                    <% } %>
                </p>
            <% } %>
            <% if (request.getParameter("registered") != null) { %>
                <p class="text-success text-center mt-3">Registration successful! Please log in.</p>
            <% } %>
            <div class="text-center mt-3">
                <a href="register.jsp" class="text-teal">Don't have an account? Register here</a>
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