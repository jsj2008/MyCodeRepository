package allone.MTP.VerBank01.Ctrl.servlet;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import allone.MTP.VerBank01.Ctrl.captain.CtrlCaptain;

public class CtrlListener implements ServletContextListener {

	private CtrlCaptain captain = new CtrlCaptain();

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		captain.destroy();
	}

	@Override
	public void contextInitialized(ServletContextEvent evt) {
		final String rootPath = evt.getServletContext().getRealPath("WEB-INF");
		new Thread("CTRL-SERVER-STARTER") {

			@Override
			public void run() {
				if (captain.init(rootPath)) {
					System.out.println("[CTRL_SERV] init succeed!");
				} else {
					System.out.println("[CTRL_SERV] init failed!");
				}
			}

		}.start();
	}

}
