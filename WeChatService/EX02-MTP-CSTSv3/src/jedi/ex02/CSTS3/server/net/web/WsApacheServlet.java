package jedi.ex02.CSTS3.server.net.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;

@SuppressWarnings("deprecation")
public class WsApacheServlet extends WebSocketServlet {
	private static final long serialVersionUID = 5073864356337613898L;

	@Override
	protected StreamInbound createWebSocketInbound(String arg0,
			HttpServletRequest arg1) {
		String host = arg1.getRemoteHost();
		int port = arg1.getRemotePort();
		
		System.out.println("WsApacheServlet.createWebSocketInbound, --> " + host);
		System.out.println("WsApacheServlet.createWebSocketInbound, --> " + port);
        return new WsApacheMsgBound(host, port);
	}
}
