package allone.register.server.captain;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/**
 * @author zhang.lei
 *
 */
public class RegisterServerListener implements ServletContextListener {
	private RegisterServerCaptain captain = new RegisterServerCaptain();

	@Override
	public void contextDestroyed(ServletContextEvent evt) {
		captain.destroy();
	}

	@Override
	public void contextInitialized(ServletContextEvent evt) {
		final String rootPath = evt.getServletContext().getRealPath("WEB-INF");
		new Thread("EX-Cloud-RegisterServer-Starter") {
			public void run() {
				if (captain.init(rootPath)) {
					System.out.println("==========>>>>>> [" + "EX-Cloud-RegisterServer" + "] 初始化成功!**********");
				} else {
					System.out.println("==========>>>>>> [" + "EX-Cloud-RegisterServer" + "] 初始化失败!!!!!@#$%^&*&^%$#@#$%^&*");
				}
			};
		}.start();
	}
}
