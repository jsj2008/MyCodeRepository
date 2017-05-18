package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;

public abstract class TradeFather {	
	
	public static String getPackageName() {
		return TradeFather.class.getPackage().getName();
	}
	
	public abstract CtrlServerOPFather doTrade(CtrlServerIPFather ipFather);

	
	
	protected void runTask(Runnable task) {
		StaticContext.getTradeCaptain().runTask(task);
	}
}
