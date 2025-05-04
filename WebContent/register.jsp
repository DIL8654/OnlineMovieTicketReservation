<form method="post" action="RegisterServlet">
  <input type="text" name="username" placeholder="Username" required>
  <input type="password" name="password" placeholder="Password" required>
  <button type="submit">Register</button>
</form>
<% if (request.getParameter("error") != null) { %>
  <p style="color: red;">Registration failed. Please try again.</p>
<% } %>
<a href="login.jsp">Already have an account? Login here</a>