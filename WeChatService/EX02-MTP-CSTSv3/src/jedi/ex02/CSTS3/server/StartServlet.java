package jedi.ex02.CSTS3.server;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

public class StartServlet extends HttpServlet implements ServletContextListener {



	/**
	 * 
	 */
	private static final long serialVersionUID = 5630055847192937746L;

	private CSTSCaptain captain = new CSTSCaptain();

	public void contextDestroyed(ServletContextEvent arg0) {
		
		captain.destroy();
		
	}

	public void contextInitialized(ServletContextEvent arg0) {
		final ServletContext context = arg0.getServletContext();
		
		new Thread(){
			public void run(){
				if (!captain.init(context)) {
					System.out.println("CSTS v3 init failed!");
					StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false, " #### [Serv_EX02P_MTP_CSTSV3 init failed!] ####");
				} else {
					System.out.println("CSTS v3 init succeed!");
					StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(true, " #### [Serv_EX02P_MTP_CSTSV3 init succeed!] ####");
				}
			}
		}.start();
	}

}
