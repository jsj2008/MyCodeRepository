package jedi.ex02.CSTS3.server.debug;

public class ThreadLog {

	private long lastLogTime;
	private StringBuffer log;

	public ThreadLog() {
		super();
		this.lastLogTime = System.currentTimeMillis();
		this.log = new StringBuffer();
	}

	public long getLastLogTime() {
		return lastLogTime;
	}

	public void setLastLogTime(long lastLogTime) {
		this.lastLogTime = lastLogTime;
	}

	public StringBuffer getLog() {
		return log;
	}

	public void setLog(StringBuffer log) {
		this.log = log;
	}

}
