package comm;

import java.util.HashMap;

public class OPSplitNode {

	public static final int TIMEOUTSPLIT = 30 * 1000;

	private String guid;
	private int maxSplit;
	private int curSplit;
	private int timeOutGap;
	private long time;
	private SplitOPeventListener listener;

	private Object lock = new Object();
	private boolean isReturn = false;

	private HashMap<Integer, byte[]> map = new HashMap<Integer, byte[]>();

	public OPSplitNode(String guid, int maxSplit, boolean server) {
		super();
		this.guid = guid;
		this.maxSplit = maxSplit;
		this.timeOutGap = TIMEOUTSPLIT * (maxSplit + 1);
		this.time = System.currentTimeMillis();
	}

	public String getGuid() {
		return guid;
	}

	public int getMaxSplit() {
		return maxSplit;
	}

	public int getCurSplit() {
		return curSplit;
	}

	public int getTimeOutGap() {
		return timeOutGap;
	}

	public long getTime() {
		return time;
	}

	public void addSplit_Server(byte[] buf) {
		map.put(map.size() + 1, buf);
	}

	public byte[] getSplit_Server(int index) {
		if (index < 1 || index > maxSplit) {
			return null;
		}
		return map.get(index);
	}

	public synchronized void addSplit_Client(int index, byte[] buf, boolean end) {
		if (index < 1 || index > maxSplit) {
			return;
		}
		map.put(index, buf);
		curSplit++;
		if (end) {
			_doNotify();
		}
	}

	private void _doNotify() {
		synchronized (lock) {
			isReturn = true;
			lock.notifyAll();
		}
	}

	public boolean doWait(long timeOut) {
		synchronized (lock) {
			if (isReturn) {
				return true;
			}
			try {
				lock.wait(timeOut);
			} catch (InterruptedException e) {
				e.printStackTrace();
				return false;
			}
			return true;
		}
	}

	public byte[] getSplit_Client(int index) {
		if (index < 1 || index > maxSplit) {
			return null;
		}
		return map.get(index);
	}

	public SplitOPeventListener getListener() {
		return listener;
	}

	public void setListener(SplitOPeventListener listener) {
		this.listener = listener;
	}

}
