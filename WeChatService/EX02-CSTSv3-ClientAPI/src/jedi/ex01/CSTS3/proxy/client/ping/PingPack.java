package jedi.ex01.CSTS3.proxy.client.ping;

import jedi.ex01.CSTS3.comm.jsondata.CSTSPing;


public class PingPack {

	private CSTSPing ping;
	private boolean isTimeout = false;
	private boolean isPingReturned = false;
	private boolean isToIgnore = false;

	private Object lock = new Object();

	public PingPack(CSTSPing ping) {
		super();
		this.ping = ping;
	}

	public String getKey() {
		return ping.getID();
	}

	public boolean isTimeout() {
		if (isTimeout) {
			return true;
		}
		return getPing() >= PingCaptain.getTIMEOUTPING();
	}

	public boolean isToIgnore() {
		return isToIgnore;
	}

	public long getPing() {
		if (isTimeout) {
			return PingCaptain.getTIMEOUTPING();
		} else if (!isPingReturned) {
			return System.currentTimeMillis() - ping.getStartTime();
		} else {
			return ping.getPing();
		}
	}

	public void pingReturn(CSTSPing ping) {
		if (!ping.getID().equals(this.ping.getID())) {
			return;
		}
		ping.pingReturned();
		this.ping = ping;
		isPingReturned = true;
		isTimeout = false;
		doNotify();
	}

	public void ignore() {
		isToIgnore = true;
		doNotify();
	}

	public void doWait() {
		if (isPingReturned) {
			return;
		}
		synchronized (lock) {
			try {
				lock.wait(PingCaptain.getTIMEOUTPING());
			} catch (Exception e) {
				e.printStackTrace();
				isTimeout = true;
			}
		}
	}

	private void doNotify() {
		synchronized (lock) {
			lock.notifyAll();
		}
	}
}
