package jedi.ex01.client.station.api.fix;

import jedi.ex01.client.station.api.doc.util.AccountScanUtil;

public class UserDocFixer extends Thread {

	private boolean isDestroy = false;

	public UserDocFixer() {
	}

	public void destroy() {
		isDestroy = true;
		this.interrupt();
	}

	public void run() {
		while (!isDestroy) {
			try {
				sleep(250);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (isDestroy) {
				return;
			}
			if (!isDestroy) {
				try {
					fixAccounts();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public synchronized void fixAccounts() {
		try {
			AccountScanUtil.fixAccount(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}