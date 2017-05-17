package comm.db;

public class User extends BasicDBData4EX {

	private static final long serialVersionUID = 1095667536109847078L;

	private String userName;
	private String password;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}