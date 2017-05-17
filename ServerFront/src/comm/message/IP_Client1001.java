package comm.message;

import comm.db.User;

public class IP_Client1001 extends IPFather {
	private static final long serialVersionUID = 965952986130762209L;

	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
