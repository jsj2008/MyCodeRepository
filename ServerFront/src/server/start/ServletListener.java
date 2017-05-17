package server.start;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

public class ServletListener extends HttpServlet implements ServletContextListener {
	private static final long serialVersionUID = -8805472483221381585L;

	public void contextDestroyed(ServletContextEvent arg0) {
		// DstsCaptain.destroy();
	}

	public void contextInitialized(ServletContextEvent arg0) {
		ServletContext context = arg0.getServletContext();
		if (context == null) {
			return;
		}

		String cfgFilePath = context.getRealPath("WEB-INF" + File.separator + "config");

		ServerCaptain.setConfigPath(cfgFilePath);

		Thread serverMainThread = new Thread(new Runnable() {
			public void run() {
				if (ServerCaptain.initCaptain()) {
					System.out.println("ServerCaptain init success");
				} else {
					System.out.println("ServerCaptain init failed");
				}
			}
		});
		serverMainThread.start();
	}
}
