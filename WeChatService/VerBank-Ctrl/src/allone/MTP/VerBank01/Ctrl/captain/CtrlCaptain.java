package allone.MTP.VerBank01.Ctrl.captain;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.doc.KickCaptain;

public class CtrlCaptain {
	private boolean destroied = false;
	private static boolean isInited = false;

	public static boolean isInited() {
		return isInited;
	}

	public boolean init(String rootPath) {
		isInited = false;
		StaticContext.setDebug(false);
		LogProxy.setProgramName(StaticContext.getConfigCaptain().getCADTSPorxyName());
		System.out.println("[CTRL_SERV:init]Start to init config captain!");
		while (!destroied && !StaticContext.getConfigCaptain().init(rootPath)) {
			LogProxy.OutPrintln("[CTRL_SERV:init]Init config failed!");
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
			}
		}

		LogProxy.init(StaticContext.getConfigCaptain().getLogPath());
		LogProxy.setDebug(StaticContext.getConfigCaptain().isDebug());
		LogProxy.setBeanMaxDeep(5);
		LogProxy.setBeanMaxOpenCollectionSize(10);
		LogProxy.OutPrintln("[CTRL_SERV:init]Start to init CADTS captain!");
		while (!destroied && !StaticContext.getCadtsCaptain().init()) {
			LogProxy.OutPrintln("[CTRL_SERV:init]Init CADTS failed!");
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
			}
		}

		LogProxy.OutPrintln("[CTRL_SERV:init]Start to init Doc captain!");
		while (!destroied && !StaticContext.getDocCaptain().init()) {
			LogProxy.OutPrintln("[CTRL_SERV:init]Init Doc failed!");
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
			}
		}

		LogProxy.OutPrintln("[CTRL_SERV:init]Start to init Trade captain!");
		if (!StaticContext.getTradeCaptain().init()) {
			LogProxy.OutPrintln("[CTRL_SERV:init]Init Trade failed!");
			return false;
		}

		LogProxy.OutPrintln("[CTRL_SERV:init]Start to init SendConfig!");
		if (!StaticContext.getSendConfig().init(rootPath)) {
			LogProxy.OutPrintln("[CTRL_SERV:init]Init SendConfig failed!");
			return false;
		}

		LogProxy.OutPrintln("[CTRL_SERV:init]init succeed!");

		KickCaptain.getInstance().init();
		isInited = true;
		return true;
	}

	public void destroy() {
		StaticContext.setStillRunning(false);
		destroied = true;
		KickCaptain.getInstance().destroy();
		try {
			StaticContext.getTradeCaptain().destroy();
		} catch (Exception e) {
		}
		try {
			StaticContext.getDocCaptain().destroy();
		} catch (Exception e) {
		}
		try {
			StaticContext.getConfigCaptain().destroy();
		} catch (Exception e) {
		}
		try {
			StaticContext.getCadtsCaptain().destroy();
		} catch (Exception e) {
		}
		try {
			LogProxy.destory();
		} catch (Exception e) {
		}
	}

}
