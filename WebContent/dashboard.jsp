<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
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
        <h2 class="text-center mb-4">Dashboard</h2>
        <%
          if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
          }

          String role = (String) session.getAttribute("role");
          if (role == null) {
              response.sendRedirect("login.jsp");
              return;
          }
          if ("admin".equals(role)) {
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
        %>
        <h3 class="text-center">Welcome Admin: <%= session.getAttribute("user") %></h3>
        <table class="table table-bordered table-striped mt-4">
            <thead class="table-dark">
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] user : users) { %>
                    <tr>
                        <td><%= user[0] %></td>
                        <td><%= user[1] %></td>
                        <td><%= user[2] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <h3 class="text-center">Welcome <%= session.getAttribute("user") %></h3>
        <% } %>
        <div class="text-center mt-4">
            <a href="seats.jsp" class="btn btn-teal rounded-pill">Book Seats</a>
        </div>
        <div class="text-center mt-4">
          <a href="addMovie.jsp" class="btn btn-teal rounded-pill">Add New Movie</a>
      </div>
      <div class="text-center mt-4">
        <a href="movies.jsp" class="btn btn-teal rounded-pill">View Available Movies</a>
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