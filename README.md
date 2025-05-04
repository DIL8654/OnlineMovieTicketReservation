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

