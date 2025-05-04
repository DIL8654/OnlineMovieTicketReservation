<form method="post" action="LoginServlet">
  <input type="text" name="username" placeholder="Username" required>
  <input type="password" name="password" placeholder="Password" required>
  <button type="submit">Login</button>
</form>
<% if (request.getParameter("error") != null) { %>
  <p style="color: red;">Invalid username or password. Please try again.</p>
<% } %>
<% if (request.getParameter("registered") != null) { %>
  <p style="color: green;">Registration successful! Please log in.</p>
<% } %>
<a href="register.jsp">Don't have an account? Register here</a>