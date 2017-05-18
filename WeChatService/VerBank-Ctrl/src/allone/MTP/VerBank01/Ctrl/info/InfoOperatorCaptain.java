package allone.MTP.VerBank01.Ctrl.info;

import java.util.HashMap;

import allone.MTP.VerBank01.Ctrl.info.opt.InfoOperatorFather;
import allone.MTP.VerBank01.Ctrl.info.opt.InfoOperator_TRADESERV3001;
import allone.MTP.VerBank01.comm.information.InforFather;

public class InfoOperatorCaptain {
	private HashMap<String, InfoOperatorFather> operatorMap = new HashMap<String, InfoOperatorFather>();

	public InfoOperatorCaptain() {
		super();
		init();
	}

	public void init() {
		operatorMap.put("TRADESERV3001", new InfoOperator_TRADESERV3001());
		// Info_TRADESERV3001
		// operatorMap.put("QGINFO1002", new InfoOperator_QGINFO1002());
		// operatorMap.put("TRADESERV1014", new InfoOperator_TRADESERV1014());
	}

	public void dealWithInfo(InforFather info) {

		String infoID = info.get_ID();
		InfoOperatorFather infoOper;
		boolean succeed = false;
		Exception ex = null;
		synchronized (operatorMap) {
			infoOper = operatorMap.get(infoID);
			if (infoOper == null) {
				return;
			}
		}
		try {
			infoOper.dealWithInfo(info);
		} catch (Exception e) {
			ex = e;
			succeed = false;
		}
		String result = "" + succeed;
		if (ex != null) {
			result += "(" + ex.toString() + ")";
		}
		allone.Log.simpleLog.log.LogProxy.printTrade("(Info)" + infoID, info, result, true);
	}
}
