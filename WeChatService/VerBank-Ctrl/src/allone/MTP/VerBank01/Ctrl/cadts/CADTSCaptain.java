package allone.MTP.VerBank01.Ctrl.cadts;

import allone.CADTS.proxy.SimpleCADTSProxy;
import allone.CADTS.proxy.exception.CADTSException;
import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.config.ConfigCaptain;
import allone.MTP.VerBank01.comm.ServCallNameTable;
import allone.MTP.VerBank01.comm.IPOP.IPFather;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;
import allone.MTP.VerBank01.comm.information.InforFather;

public class CADTSCaptain extends SimpleCADTSProxy {

	public boolean init() {
		ConfigCaptain config = StaticContext.getConfigCaptain();
		init(config.getCADTSIp(), config.getCADTSCmdPort(), config.getCADTSDataPort(), config.getCADTSServName(), config.getCADTSPorxyName());
		getCaptain().setDefaultTradeTimeOut(6 * 60 * 1000);
		return true;
	}

	public OPFather trade(String toServer, IPFather ip) {
		long startTime = System.currentTimeMillis();
		OPFather op = null;
		try {
			op = (OPFather) trade(toServer, ServCallNameTable.FUN_VERBANK_TRADE, ip.get_ID(), ip);
		} catch (CADTSException e) {
			op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(e.getErrCode());
			op.setErrMessage(e.getMessage() + "   " + e.getErrCode());
			e.printStackTrace();
		} catch (Exception e) {
			op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_CADTS_EXCEPTION);
			op.setErrMessage(e.getMessage());
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis();
		op.set_tradeUsedTime(endTime - startTime);
		if (!op.isSucceed()) {
			LogProxy.printTrade(ip.get_ID(), ip, op, op.isSucceed());
		}
		return op;
	}

	@Override
	public Object receiveCMD(String arg0, String arg1, String arg2, Object tip) throws Exception {
		if (tip instanceof CtrlServerIPFather) {
			CtrlServerIPFather ip = (CtrlServerIPFather) tip;
			return StaticContext.getTradeCaptain().trade(ip);
		}

		return null;
	}

	@Override
	public void receiveData(String fromServ, String funName, String dataName, Object data) {

		// if (funName.equals(ServCallNameTable.FUN_VERBANK_INFO)) {
		// InforFather info = (InforFather) data;
		// StaticContext.getInfoOperatorCaptain().dealWithInfo(info);
		// }

		if (data instanceof InforFather) {
			InforFather info = (InforFather) data;
			StaticContext.getInfoOperatorCaptain().dealWithInfo(info);
			// LogProxy.printTrade(info.get_ID(), info, info.get_ID(), true);
		}
	}
}
