package server.network.client;

import java.net.ServerSocket;
import java.net.Socket;

public class AcceptWorker extends Thread {
	private ServerSocket servSocket = null;
	private boolean isDestroy = false;

	public boolean init(int port) {
		try {
			servSocket = new ServerSocket(port);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		isDestroy = false;
		this.start();
		return true;
	}

	public void run() {
		while (!isDestroy) {
			try {
				Socket socket = servSocket.accept();
				dealWithNewSocket(socket);
			} catch (Exception e) {
				if (isDestroy) {
					return;
				}
				try {
					sleep(500);
				} catch (InterruptedException e1) {
				}
				e.printStackTrace();
			}
		}
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
