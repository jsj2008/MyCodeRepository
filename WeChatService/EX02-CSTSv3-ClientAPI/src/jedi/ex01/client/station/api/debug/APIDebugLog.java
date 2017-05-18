package jedi.ex01.client.station.api.debug;

public class APIDebugLog {
	private final static APIDebugLog instance = new APIDebugLog();

	public static APIDebugLog getInstance() {
		return instance;
	}

	private APIDebugLogReceiver receiver;

	public void setReceiver(APIDebugLogReceiver receiver) {
		this.receiver = receiver;
	}

	public void logout(String log, int level) {
		if (receiver != null) {
			try {
				receiver.debugLog(log, level);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static final int level_debug=2;
	public static final int level_info=3;
	public static final int level_error=4;
}
