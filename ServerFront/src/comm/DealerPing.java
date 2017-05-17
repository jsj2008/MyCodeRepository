package comm;

import java.io.Serializable;
import java.util.UUID;

public class DealerPing implements Serializable {
	private static final long serialVersionUID = 8582593028328418874L;
	
	private long startTime;
	private long endTime;
	private String ID;

	public DealerPing() {
		ID = UUID.randomUUID().toString();
		startTime = System.currentTimeMillis();
	}

	public String getID() {
		return ID;
	}

	public void pingReturned() {
		endTime = System.currentTimeMillis();
	}

	public long getPing() {
		return endTime - startTime;
	}

	public long getStartTime() {
		return startTime;
	}

	public void setStartTime(long startTime) {
		this.startTime = startTime;
	}
}
