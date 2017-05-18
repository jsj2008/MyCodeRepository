package jedi.ex02.CSTS3.server.net;

import java.net.ServerSocket;
import java.net.Socket;

import jedi.ex02.CSTS3.server.StaticContext;
import allone.Log.simpleLog.log.LogProxy;
import allone.util.attack.frequence.FAttackCaptain;

public class AcceptWorker extends Thread {
	private ServerSocket servSocket = null;
	private boolean isDestroy = false;
	private FAttackCaptain fattackCaptain = new FAttackCaptain();
	private static final String ThreadName="CSTSV3-AcceptWorker";
	public AcceptWorker() {

	}

	public boolean init(int port) {
		try {
			servSocket = new ServerSocket(port);
		} catch (Exception e) {
			e.printStackTrace();
			StaticContext.getMonitorCaptain().monitorThreadState(ThreadName, false);
			return false;
		}
		fattackCaptain.init(60 * 1000, 60, 5 * 60 * 1000);
		isDestroy = false;
		this.start();
		return true;
	}

	public void run() {
		while (!isDestroy) {
			try {
				StaticContext.getMonitorCaptain().monitorThreadState(ThreadName, true);
				Socket socket = servSocket.accept();
				if (!checkIsAttack(socket)) {
					try {
						socket.close();
					} catch (Exception e) {
					}
				} else {
					dealWithNewSocket(socket);
				}
				StaticContext.getMonitorCaptain().monitorThreadState(ThreadName, true);
			} catch (Exception e) {
				if (isDestroy) {
					return;
				}
				try {
					sleep(500);
				} catch (InterruptedException e1) {
				}
				LogProxy.printException(e);
				StaticContext.getMonitorCaptain().monitorThreadState(ThreadName, false);
			}
		}
	}

	private boolean checkIsAttack(Socket socket) {
		String address = socket.getInetAddress().getHostAddress();
		return FAttackCaptain.STATUS_OK == fattackCaptain.checkStatus(address);
	}

	private void dealWithNewSocket(Socket socket) {
		new NewSocketDealer(socket).start();
	}

	public void destroy() {
		isDestroy = true;
		try {
			servSocket.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
