package server.trade;

import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.transaction.UserTransaction;

import server.define.ErrCodeTable;

import comm.message.IPFather;
import comm.message.OPFather;

public class TradeCaptain {
	private HashMap<String, TradeFather> tradeHashMap = new HashMap<String, TradeFather>();

	public OPFather doTrade(IPFather ip) {
		return callLocalTrade(ip);
	}

	private OPFather callLocalTrade(IPFather ip) {
		TradeFather tf = (TradeFather) tradeHashMap.get(ip.get_ID());
		if (tf == null) {
			try {
				String nameString = getClass().getPackage().getName() + ".Trade" + ip.get_ID();
				tf = (TradeFather) Class.forName(nameString).newInstance();

				Context ctx = new InitialContext();
				// "java:comp/UserTransaction"
				UserTransaction ut = (UserTransaction) ctx.lookup("java:comp/UserTransaction");
				if (ut == null) {
					OPFather op = new OPFather(ip);
					op.setErrCode(ErrCodeTable.ERR_TradeIDNotFind);
					op.setErrMessage("UserTransaction not find!");
					op.setSucceed(false);
					return op;
				}
				tf.init(ut);

				tradeHashMap.put(ip.get_ID(), tf);
			} catch (Exception e) {
				OPFather op = new OPFather(ip);
				op.setErrCode(ErrCodeTable.ERR_TradeIDNotFind);
				op.setErrMessage("Trade Code " + ip.get_ID() + " not find!");
				op.setSucceed(false);
				e.printStackTrace();
				return op;
			}
		}
		return tf.call_trade(ip);
	}

}
