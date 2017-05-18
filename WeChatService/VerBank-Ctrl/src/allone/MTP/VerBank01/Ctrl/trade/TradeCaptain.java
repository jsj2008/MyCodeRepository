package allone.MTP.VerBank01.Ctrl.trade;

import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.TDB.comm.IPFather4TDB;
import allone.MTP.VerBank01.WSFacade.comm.WSFacadeIPFather;
import allone.MTP.VerBank01.comm.ServCallNameTable;
import allone.MTP.VerBank01.comm.IPOP.IPFather;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;
import allone.MTP.VerBank01.trade.comm.IPFather4TradeServ;

public class TradeCaptain {
	private HashMap<String, TradeFather> tradeMap = new HashMap<String, TradeFather>();

	private ExecutorService threadPool = Executors.newCachedThreadPool();
	
	public boolean init() {
		return true;
	}
	
	public void destroy() {
		threadPool.shutdown();
	}
	
	public CtrlServerOPFather trade(CtrlServerIPFather ip) {
		long startTime = System.currentTimeMillis();
		CtrlServerOPFather op = doTrade(ip);
		long endTime = System.currentTimeMillis();
		op.set_tradeUsedTime(endTime - startTime);
		LogProxy.printTrade(ip.get_ID(), ip, op, op.isSucceed());
		return op;
	}
	
	public OPFather callTrade(IPFather ipFather) {
		OPFather opf = null;
		String toServer = null;
		if (ipFather instanceof IPFather4TradeServ) {
			toServer = ServCallNameTable.SERV_VERBANK_TRADESERVER;
		} else if (ipFather instanceof IPFather4TDB) {
			toServer = ServCallNameTable.SERV_VERBANK_TDB;
		} else if (ipFather instanceof WSFacadeIPFather) {
			toServer = ServCallNameTable.SERV_VERBANK_BANKINTERFACE;
		}
		
		if (toServer != null) {
			opf = StaticContext.getCadtsCaptain().trade(toServer, ipFather);
		}
		
		if (opf == null) {
			opf = new OPFather(ipFather);
			opf.setSucceed(false);
			opf.setErrCode(IPOPErrCodeTable.ERR_TypeError);
			opf.setErrMessage("unSupported IPFather!");
		}
		
		return opf;
	}
	
	public OPFather callTrade(String toServer, IPFather ipFather) {
		OPFather opf = StaticContext.getCadtsCaptain().trade(toServer, ipFather);
		return opf;
	}

	private CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		TradeFather tf = getTradeFather(ipFather.get_ID());
		CtrlServerOPFather op = null;
		if (tf == null) {
			op = new CtrlServerOPFather(ipFather);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_TradeIDNotFind);
			op.setErrMessage("Given trade ID not find! ID="
							+ ipFather.get_ID());
			return op;
		}
		try {
			op = tf.doTrade(ipFather);
		} catch (Exception e) {
			op = new CtrlServerOPFather(ipFather);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage("Trade err: exception=" + e);
			LogProxy.printException(e);
		}
		
		if (op == null) {
			op = new CtrlServerOPFather(ipFather);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage("Trade operator returns null!");
		}
		
		return op;
	}
	
	private TradeFather getTradeFather(String id) {
		TradeFather tf = null;
		// synchronized (tradeMap) {
		tf = (TradeFather) tradeMap.get(id);
		if (tf == null) {
			try {
				String clsName = TradeFather.getPackageName() + ".Trade" + id;
				Class<?> tfClass = Class.forName(clsName);
				tf = (TradeFather) tfClass.newInstance();
				tradeMap.put(id, tf);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// }

		return tf;
	}

	
	public void runTask(Runnable task) {
		
	}
}
