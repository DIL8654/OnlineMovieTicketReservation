package model;

public class User {
    private String username;
    private String password;
    private String role;
    private String firstName;
    private String lastName;
    private String status;

    // Constructor with default values for firstName, lastName, and status
    public User(String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.firstName = ""; // Default to empty
        this.lastName = "";  // Default to empty
        this.status = "active"; // Default to active
    }

    // Constructor with all fields
    public User(String username, String password, String role, String firstName, String lastName, String status) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.firstName = firstName;
        this.lastName = lastName;
        this.status = status;
    }

    // Getters
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getStatus() { return status; }

    // Setters
    public void setUsername(String username) { this.username = username; }
    public void setPassword(String password) { this.password = password; }
    public void setRole(String role) { this.role = role; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public void setStatus(String status) { this.status = status; }
}