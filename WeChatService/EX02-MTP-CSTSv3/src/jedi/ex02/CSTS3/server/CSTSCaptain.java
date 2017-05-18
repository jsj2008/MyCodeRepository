package jedi.ex02.CSTS3.server;

import javax.servlet.ServletContext;

import jedi.ex02.CSTS3.server.util.JsonInitUtil;
import allone.Log.simpleLog.log.LogProxy;

public class CSTSCaptain {
	private boolean isRunning = true;

	@SuppressWarnings("deprecation")
	public boolean init(ServletContext context) {
		isRunning = true;
		JsonInitUtil.init();
		System.out.println("CSTS v3:[init] start config captain");
		while (isRunning && !StaticContext.getCSConfigCaptain().init(context)) {
			System.out.println("CSTS v3:[init] init config failed!");
			StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false, "CSTS v3:[init] init config failed!");
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("QuoteSource start config captain...");
		// 这里有疑问、是不是live是在obj文件里面的、这里的liveorDemo怎么获得
		boolean liveNotDemo = true;

		try {
			while (isRunning
					&& !StaticContext.getQuoteSourceCaptain().init(StaticContext.getCSConfigCaptain().getRecord(), liveNotDemo)) {
				System.out.println("CSTS v3:[init] init quoteSourceCaptain failed!");
				StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false,
						"CSTS v3:[init] init quoteSourceCaptain failed!");
				try {
					Thread.sleep(2000);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		System.out.println("CSTS v3:[init] init config succeed!");
		// LogProxy.init(StaticContext.getCSConfigCaptain().getLogPath());
		/**
		 * niuqq 2015-7-27 add monitor
		 */
		if (!StaticContext.getMonitorCaptain().init(context.getRealPath(""))) {
			LogProxy.ErrPrintln("CSTS v3:[init] init monitor failed!");
			StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false, "CSTS v3:[init] init monitor failed!");
		} else {
			LogProxy.OutPrintln("CSTS v3:[init] init monitor succeed!");
		}

		StaticContext.getTradeCaptain().init();
		// StaticContext.getClientTradeCaptain().init();

		System.out.println("CSTS v3:[init] start CADTS captain");
		while (isRunning && !StaticContext.getCADTSCaptain().init()) {
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("CSTS v3:[init] init CADTS failed");
			StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false, "CSTS v3:[init] init CADTS failed!");
		}
		System.out.println("CSTS v3:[init] init CADTS succeed!");

		System.out.println("CSTS v3:[init] start doc captain");
		while (isRunning && !StaticContext.getCSTSDoc().init()) {
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("CSTS v3:[init] init doc failed");
			StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false, "CSTS v3:[init] init doc failed!");
		}
		System.out.println("CSTS v3:[init] init doc succeed!");

		System.out.println("CSTS v3:[init] start net captain");
		while (isRunning && !StaticContext.getNetCaptain().init()) {
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("CSTS v3:[init] init net failed");
			StaticContext.getCSConfigCaptain().sendServerStateToConfigServer(false, "CSTS v3:[init] init net failed!");
		}
		System.out.println("CSTS v3:[init] init net succeed!");
		if (StaticContext.getCSConfigCaptain().isUseCmd()) {
			// CmdCaptain.getInstance().init();
		}
		return isRunning;
	}

	public void destroy() {
		isRunning = false;
		try {
			Thread.currentThread().interrupt();
		} catch (Exception e) {
		}
		StaticContext.getCSConfigCaptain().destroy();
		StaticContext.getNetCaptain().destroy();
		StaticContext.getCSTSDoc().destroy();
		StaticContext.getCADTSCaptain().destroy();
		StaticContext.getMonitorCaptain().destroy();

		StaticContext.getQuoteSourceCaptain().destroy();
		LogProxy.destory();
	}

}
