<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-teal {
            background-color: teal;
            color: white;
        }
        .btn-teal:hover {
            background-color: #006d6d;
        }
        .left-panel {
            background-color: #f8f9fa;
            height: 100%;
            padding: 20px;
            border-right: 1px solid #ddd;
        }
        .tab-content {
            padding: 20px;
        }
        .nav-pills .nav-link.active {
            background-color: teal !important;
            color: white !important;
        }
        .nav-pills .nav-link {
            color: teal;
        }
        .nav-pills .nav-link:hover {
            color: #006d6d;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg" style="background: linear-gradient(to right, teal, #006d6d);">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-white" href="dashboard.jsp">Online Movie Ticket Reservation</a>
            <div class="d-flex">
                <a href="LogoutServlet" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Left Panel -->
            <div class="col-md-3 left-panel">
                <h4>Admin Panel</h4>
                <ul class="nav nav-pills flex-column" id="adminTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="user-management-tab" data-bs-toggle="tab" href="#user-management" role="tab" aria-controls="user-management" aria-selected="true">User Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="movie-management-tab" data-bs-toggle="tab" href="#movie-management" role="tab" aria-controls="movie-management" aria-selected="false">Movie Management</a>
                    </li>
                </ul>
            </div>

            <!-- Right Panel -->
            <div class="col-md-9">
                <div class="tab-content" id="adminTabsContent">
                    <!-- User Management Tab -->
                    <div class="tab-pane fade show active" id="user-management" role="tabpanel" aria-labelledby="user-management-tab">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>User Management</h3>
                            <a href="editUser.jsp" class="btn btn-teal btn-sm">Create New User</a>
                        </div>
                        <table class="table table-bordered table-striped mt-4">
                            <thead class="table-dark">
                                <tr>
                                    <th>Username</th>
                                    <th>Password</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String filePath = application.getRealPath("/users.txt");
                                    List<String[]> users = new ArrayList<>();
                                    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                                        String line;
                                        while ((line = reader.readLine()) != null) {
                                            users.add(line.split(","));
                                        }
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                    for (String[] user : users) {
                                %>
                                <tr>
                                    <td><%= user[0] %></td>
                                    <td><%= user[1] %></td>
                                    <td><%= user[2] %></td>
                                    <td>
                                        <a href="editUser.jsp?username=<%= user[0] %>" class="btn btn-primary btn-sm">Edit</a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Movie Management Tab -->
                    <div class="tab-pane fade" id="movie-management" role="tabpanel" aria-labelledby="movie-management-tab">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>Movie Management</h3>
                            <a href="addMovie.jsp" class="btn btn-teal btn-sm">Create New Movie</a>
                        </div>
                        <div class="mt-4">
                            <h5>Available Movies</h5>
                            <ul class="list-group">
                                <%
                                    File movieDir = new File(application.getRealPath("/"));
                                    File[] movieFiles = movieDir.listFiles((dir, name) -> name.endsWith("_seats.txt"));
                                    if (movieFiles != null && movieFiles.length > 0) {
                                        for (File movieFile : movieFiles) {
                                            String movieName = movieFile.getName().replace("_seats.txt", "").replace("_", " ");
                                %>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <%= movieName %>
                                    <a href="seats.jsp?movie=<%= movieFile.getName() %>" class="btn btn-outline-primary btn-sm">View Seats</a>
                                </li>
                                <% 
                                        }
                                    } else { 
                                %>
                                <li class="list-group-item">No movies available.</li>
                                <% } %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>