# Online Movie Ticket Reservation Platform

This is a simple Java web-based application for an Online Movie Ticket Reservation system. It demonstrates basic login and access management using Java Servlets, JSP, and file-based storage.

## 📦 Project Structure

```
OnlineMovieTicketReservation/
├── src/
│   ├── model/              # User model class
│   ├── service/            # Authentication service
│   └── controller/         # Login, Register, Logout servlets
├── WebContent/             # JSP files for UI
├── users.txt               # File for storing user credentials
```

## 🧰 Technologies Used

- Java
- JSP
- Servlets
- HTML/CSS
- File I/O for data storage (no database)
- IntelliJ IDEA
- Git (for version control)

## 🚀 Setup Instructions

1. **Clone or extract the project** into a folder on your computer.

2. **Open IntelliJ IDEA** and select `File > Open` and navigate to the extracted folder.

3. **Configure your servlet container:**
   - Install and configure Apache Tomcat.
   - Add Tomcat as a server in IntelliJ: `File > Project Structure > Facets > Web`.
   - Set the web application directory to `WebContent`.

4. **Set deployment settings:**
   - Go to `Run > Edit Configurations`.
   - Add a new "Tomcat Server" configuration and point to the project.

5. **Build the project** and run it on Tomcat.

6. **Access the application:**
   - Open your browser and navigate to: `http://localhost:8080/OnlineMovieTicketReservation/login.jsp`

## 👤 Login Credentials

The project includes sample users in `users.txt`.

```
Username: john
Password: pass123

Username: admin
Password: adminpass
```

## ✅ Features Included

- User Registration
- User Login with session
- Access-protected dashboard
- Logout functionality

## 📂 Sample File: `users.txt`

```
john,pass123,user
admin,adminpass,admin
```

# Report

# User Management Implementation Report

## Overview
The user management system is implemented using Java Servlets, JSP, and file-based storage (`users.txt`). It supports the following CRUD operations:

- **Create**: User registration.
- **Read**: Viewing user profiles and admin access to user data.
- **Update**: Editing user profiles and resetting passwords.
- **Delete**: Deactivating user accounts.

---

## CRUD Operations

### 1. Create: User Registration

- **Feature**: Allows new users to register by providing their name, email (username), and password.
- **Implementation**:
  - **Servlet**: `RegisterServlet.java`
  - **JSP**: `register.jsp`
  - **Storage**: User details are stored in `users.txt` with default values for `firstName`, `lastName`, and `status` set to `"active"`.
  - **Validation**: Ensures that the username and password are not empty.
  - **Default Role**: New users are assigned the role `"user"`.

```java
User newUser = new User(username, password, "user");
if (auth.register(newUser)) {
    response.sendRedirect("login.jsp?registered=true");
} else {
    response.sendRedirect("register.jsp?error=1");
}
```

- **Sample Entry in `users.txt`**:
```
john,pass123,user,John,Doe,active
```

---

### 2. Read: User Profiles and Admin Access

- **Feature**:
  - Users can view their profile information.
  - Admins can view all user profiles in a tabular format.
- **Implementation**:
  - **JSP**: `dashboard.jsp`
  - **Session Management**: User role (`admin` or `user`) is stored in the session to control access.
  - **Admin Access**: Admins can view all users and their statuses.

```jsp
<% if ("admin".equals(role)) { %>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <% for (String[] user : users) { %>
                <tr>
                    <td><%= user[0] %></td>
                    <td><%= user[2] %></td>
                    <td><%= "deactivated".equals(user[5]) ? "Deactivated" : "Active" %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
<% } %>
```

---

### 3. Update: Edit Profile and Reset Password

- **Feature**:
  - Users can edit their profile details (e.g., first name, last name, password).
  - Admins can edit user details, including roles and statuses.
- **Implementation**:
  - **Servlet**: `UpdateUserServlet.java`
  - **JSP**: `editUser.jsp`
  - **Validation**: Ensures that required fields are not empty.
  - **Default Status**: If the `status` field is missing, it defaults to `"active"`.

```java
if (!isNewUser) {
    users.add(new String[]{username, password, role, firstName, lastName, status});
} else {
    users.add(new String[]{username, password, role, firstName, lastName, "active"});
}
```

```jsp
<form method="post" action="UpdateUserServlet">
    <input type="hidden" name="originalUsername" value="<%= userDetails[0] %>">
    <input type="text" name="firstName" value="<%= userDetails[3] %>">
    <input type="text" name="lastName" value="<%= userDetails[4] %>">
    <input type="password" name="password" value="<%= userDetails[1] %>">
    <select name="status">
        <option value="active" <%= "active".equals(userDetails[5]) ? "selected" : "" %>>Active</option>
        <option value="deactivated" <%= "deactivated".equals(userDetails[5]) ? "selected" : "" %>>Deactivated</option>
    </select>
    <button type="submit">Update</button>
</form>
```

---

### 4. Delete: Deactivate Account

- **Feature**:
  - Admins can deactivate user accounts.
  - Deactivated users cannot log in.
- **Implementation**:
  - **Servlet**: `UpdateUserServlet.java`
  - **JSP**: `dashboard.jsp` (Admin view)
  - **Validation**: Deactivated users are identified by the `status` field in `users.txt`.

```java
if ("deactivated".equals(parts[5])) {
    return "deactivated";
}
```

```java
if ("deactivated".equals(authResult)) {
    response.sendRedirect("login.jsp?error=deactivated");
}
```

```jsp
<td>
    <form method="post" action="UpdateUserServlet">
        <input type="hidden" name="originalUsername" value="<%= user[0] %>">
        <input type="hidden" name="status" value="<%= "active".equals(user[5]) ? "deactivated" : "active" %>">
        <button type="submit" class="btn <%= "active".equals(user[5]) ? "btn-danger" : "btn-success" %>">
            <%= "active".equals(user[5]) ? "Deactivate" : "Activate" %>
        </button>
    </form>
</td>
```

---

## File Structure

```
OnlineMovieTicketReservation/
├── src/
│   ├── model/
│   │   └── User.java
│   ├── service/
│   │   └── AuthService.java
│   └── controller/
│       ├── LoginServlet.java
│       ├── LogoutServlet.java
│       ├── RegisterServlet.java
│       ├── UpdateUserServlet.java
│       └── SeatBookingServlet.java
├── WebContent/
│   ├── login.jsp
│   ├── register.jsp
│   ├── dashboard.jsp
│   ├── editUser.jsp
│   ├── users.txt
│   └── bookings.txt
```

---

## Testing Scenarios

1. **Create**:
   - Register a new user and verify that the user is added to `users.txt` with default values.
   - Ensure duplicate usernames are not allowed.

2. **Read**:
   - Verify that users can view their profile.
   - Ensure admins can view all users and their statuses.

3. **Update**:
   - Edit a user's profile and verify that changes are reflected in `users.txt`.
   - Reset a user's password and ensure the new password works.

4. **Delete**:
   - Deactivate a user and verify that they cannot log in.
   - Reactivate a user and ensure they can log in again.

---

## Conclusion

The user management system provides a robust implementation of CRUD operations with clear separation of concerns. It ensures secure handling of user data and provides role-based access for admins and regular users.
