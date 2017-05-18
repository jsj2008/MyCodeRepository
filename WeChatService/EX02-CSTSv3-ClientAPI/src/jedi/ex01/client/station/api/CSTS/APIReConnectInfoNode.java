package jedi.ex01.client.station.api.CSTS;

public class APIReConnectInfoNode {

	private long time;
	private String ipAddress;
	private int port;
	private boolean succeed;
	private int result;
	private long loginUsedTime;

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public boolean isSucceed() {
		return succeed;
	}

	public void setSucceed(boolean succeed) {
		this.succeed = succeed;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public long getLoginUsedTime() {
		return loginUsedTime;
	}

	public void setLoginUsedTime(long loginUsedTime) {
		this.loginUsedTime = loginUsedTime;
	}

}
