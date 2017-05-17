package comm;

import java.io.Serializable;

public class KickOutNode implements Serializable {
	private static final long serialVersionUID = 2947185864078914483L;

	private String kickerIp;

	public String getKickerIp() {
		return kickerIp;
	}

	public void setKickerIp(String kickerIp) {
		this.kickerIp = kickerIp;
	}
}
