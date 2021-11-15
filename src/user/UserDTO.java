package user;

public class UserDTO {
    private String userID;
    private String userPassword;
    private String userEmail;
    private boolean userEmailChecked;
    private String userEmailHash;

    public UserDTO() {

    }

    public UserDTO(String userID, String userPassword, String userEmail, boolean userEmailChecked, String userEmailHash) {
        this.userID = userID;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userEmailChecked = userEmailChecked;
        this.userEmailHash = userEmailHash;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public boolean isUserEmailChecked() {
        return userEmailChecked;
    }

    public void setUserEmailChecked(boolean userEmailChecked) {
        this.userEmailChecked = userEmailChecked;
    }

    public String getUserEmailHash() {
        return userEmailHash;
    }

    public void setUserEmailHash(String userEmailHash) {
        this.userEmailHash = userEmailHash;
    }
}
