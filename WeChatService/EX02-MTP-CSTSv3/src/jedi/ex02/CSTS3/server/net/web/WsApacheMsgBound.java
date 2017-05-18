package jedi.ex02.CSTS3.server.net.web;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;

import jedi.ex02.CSTS3.server.net.I_ClientNode;

import org.apache.catalina.websocket.MessageInbound;


@SuppressWarnings("deprecation")
public class WsApacheMsgBound extends MessageInbound implements INetWebSocket {
	
	private WsNetJob wsNetJob;
	private final String clientIp;
	private final int  clientPort;
	
	public WsApacheMsgBound(String ip, int port){
		this.clientIp = ip;
    	this.clientPort = port;
    	this.wsNetJob = new WsNetJob(this);
		new WebClientNode(this.wsNetJob);
	}

	@Override
	protected void onBinaryMessage(ByteBuffer arg0) throws IOException {
		System.out.println("--> onBinaryMessage: ");
		this.wsNetJob.onReadBinary(arg0);
	}

	@Override
	protected void onTextMessage(CharBuffer arg0) throws IOException {
		System.out.println("--> onTextMessage: " + arg0.toString());
		this.wsNetJob.onReadJsonText(arg0.toString());
	}
	
	protected void onClose(int status){
		System.out.println("--> onClose: " + this);
		this.wsNetJob.destroy();
		super.onClose(status);
	}
	
	@Override
	public String getRemoteIp() {
		return clientIp;
	}

	@Override
	public int getRemotePort() {
		return clientPort;
	}

	@Override
	public void sendTextMessage(String txtMsg) {
		if(txtMsg == null || txtMsg.length() == 0){
			return;
		}
		try {
			synchronized (this) {
				this.getWsOutbound().writeTextMessage(CharBuffer.wrap(txtMsg.toCharArray()));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sendBinaryMessage(ByteBuffer buffer) {
		if(buffer == null){
			return;
		}
		try {
			synchronized (this) {
				this.getWsOutbound().writeBinaryMessage(buffer);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void closeNetSocket() {
		try {
			synchronized (this) {
				this.getWsOutbound().close(1, null);
				this.wsNetJob.destroy();
			}
		} catch (IOException e) {
		}
	}
}
