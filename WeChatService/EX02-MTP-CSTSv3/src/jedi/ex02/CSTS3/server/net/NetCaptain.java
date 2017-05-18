package jedi.ex02.CSTS3.server.net;

import jedi.ex02.CSTS3.server.StaticContext;

public class NetCaptain {
	private AcceptWorker acceptWorker = new AcceptWorker();

	// private SecurityXMLServer securityXML=new SecurityXMLServer();

	public NetCaptain() {

	}

	public boolean init() {
		// securityXML.init();
		// securityXML.start();
		return acceptWorker.init(StaticContext.getCSConfigCaptain().getClientSocketPort());
	}

	public void destroy() {
		acceptWorker.destroy();
		// securityXML.stopServer();s
	}
}
