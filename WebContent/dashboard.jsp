<!-- filepath: /Users/dilankamm/Documents/aize/sourcecodes/personal/OnlineMovieTicketReservation/WebContent/dashboard.jsp -->
<%@ page import="java.io.*, java.util.*" %>
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
      <h2>Welcome Admin: <%= session.getAttribute("user") %></h2>
      <table border="1">
          <thead>
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
<%
  } else {
%>
      <h2>Welcome <%= session.getAttribute("user") %></h2>
<%
  }
%>
<a href="LogoutServlet">Logout</a>