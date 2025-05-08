package service;

import model.User;
import java.io.*;
import java.util.*;

public class AuthService {
    private String filePath;

    public AuthService(String filePath) {
        this.filePath = filePath;
    }

    public String authenticate(String username, String password) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(username)) {
                    if (parts[1].equals(password)) {
                        if ("deactivated".equals(parts[5])) { // Check if the user is deactivated
                            return "deactivated";
                        }
                        return "authenticated";
                    }
                    return "invalid_password";
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "user_not_found";
    }

    public boolean register(User user) {
        if (isUserExists(user.getUsername())) {
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(user.getUsername() + "," + user.getPassword() + "," + user.getRole()  + "," + user.getFirstName()  + "," + user.getLastName() + ",active"); // Default status is active
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean isUserExists(String username) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(username)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getRole(String username, String password) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(username) && parts[1].equals(password)) {
                    return parts[2]; // Return the role
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}