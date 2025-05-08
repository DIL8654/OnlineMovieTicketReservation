<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= (request.getParameter("username") == null || request.getParameter("username").isEmpty()) ? "Create New User" : "Edit User" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-teal {
            background-color: teal;
            color: white;
        }
        .btn-teal:hover {
            background-color: #006d6d;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg" style="background: linear-gradient(to right, teal, #006d6d);">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-white" href="dashboard.jsp">Online Movie Ticket Reservation</a>
            <div class="d-flex">
                <a href="dashboard.jsp" class="btn btn-outline-light me-2">Dashboard</a>
                <a href="LogoutServlet" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Edit/Create User Section -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">
            <%= (request.getParameter("username") == null || request.getParameter("username").isEmpty()) ? "Create New User" : "Edit User" %>
        </h2>
        <%
            // Validate session
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Check if this is for creating a new user or editing an existing user
            String username = request.getParameter("username");
            String[] userDetails = null;
            boolean isNewUser = (username == null || username.isEmpty());

            if (!isNewUser) {
                // Read user details from file for editing
                String filePath = application.getRealPath("/users.txt");
                try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        String[] user = line.split(",");
                        if (user[0].equals(username)) {
                            userDetails = user;
                            break;
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

                // Redirect if user not found
                if (userDetails == null) {
                    response.sendRedirect("dashboard.jsp");
                    return;
                }
            }
        %>
        <form method="post" action="UpdateUserServlet" class="card p-4 shadow-lg">
            <% if (!isNewUser) { %>
                <input type="hidden" name="originalUsername" value="<%= userDetails[0] %>">
            <% } %>
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control rounded-pill" id="firstName" name="firstName" value="<%= isNewUser ? "" : (userDetails.length > 3 ? userDetails[3] : "") %>" required>
            </div>
            <div class="mb-3">
                <label for="lastName" class="form-label">Last Name</label>
                <input type="text" class="form-control rounded-pill" id="lastName" name="lastName" value="<%= isNewUser ? "" : (userDetails.length > 4 ? userDetails[4] : "") %>" required>
            </div>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control rounded-pill" id="username" name="username" value="<%= isNewUser ? "" : userDetails[0] %>" 
                       <%= (!isNewUser && !(session.getAttribute("user") != null && session.getAttribute("user").equals(userDetails[0]))) ? "readonly" : "" %> required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control rounded-pill" id="password" name="password" value="<%= isNewUser ? "" : userDetails[1] %>" required>
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">Role</label>
                <select class="form-select rounded-pill" id="role" name="role" required>
                    <option value="user" <%= (!isNewUser && "user".equals(userDetails[2])) ? "selected" : "" %>>User</option>
                    <option value="admin" <%= (!isNewUser && "admin".equals(userDetails[2])) ? "selected" : "" %>>Admin</option>
                </select>
            </div>
               <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select class="form-select rounded-pill" id="status" name="status" required>
                    <option value="active" <%= (!isNewUser && userDetails.length > 5 && "active".equals(userDetails[5])) ? "selected" : "" %>>Active</option>
                    <option value="deactivated" <%= (!isNewUser && userDetails.length > 5 && "deactivated".equals(userDetails[5])) ? "selected" : "" %>>Deactivated</option>
                </select>
            </div>
            <button type="submit" class="btn btn-teal w-100 rounded-pill">
                <%= isNewUser ? "Create User" : "Update User" %>
            </button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>