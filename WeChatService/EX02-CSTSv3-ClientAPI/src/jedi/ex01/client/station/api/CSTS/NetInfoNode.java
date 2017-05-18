package jedi.ex01.client.station.api.CSTS;

public class NetInfoNode {

	public static final int TYPE_LOST=1;
	public static final int TYPE_CONNECT=2;
	
	public static final int REASON_NETLOST=1;
	public static final int REASON_TIMEOUT=2;
	
	private int type;
	private String ipAddress;
	private int port;
	private long time;
	private long loginUseTime;
	private int reason;
	private APIReConnectInfoNode[] reconnectVec;

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

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public long getLoginUseTime() {
		return loginUseTime;
	}

	public void setLoginUseTime(long loginUseTime) {
		this.loginUseTime = loginUseTime;
	}

	public int getReason() {
		return reason;
	}

	public void setReason(int reason) {
		this.reason = reason;
	}

	public APIReConnectInfoNode[] getReconnectVec() {
		return reconnectVec;
	}

	public void setReconnectVec(APIReConnectInfoNode[] reconnectVec) {
		this.reconnectVec = reconnectVec;
	}

}
