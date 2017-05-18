package jedi.ex02.CSTS3.server.trade;

import java.util.HashMap;

import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import allone.CADTS.comm.ErrCodeTable;
import allone.Log.simpleLog.log.LogProxy;

public class TradeCaptain {
	

	private HashMap<String, CADTSTradeFather> tradeMap = new HashMap<String, CADTSTradeFather>();
	
	public void init() {
		
	}

	public OPFather doCADTSTrade(String fromServ, IPFather ip) {
		OPFather op;
		CADTSTradeFather tf = tradeMap.get(ip.get_ID());

		long startTime = System.currentTimeMillis();
		
		//如果没有则放入
		if (tf == null) {
			try {
				//通过名字组合获得CADTSTradeFather
				tf = (CADTSTradeFather) Class.forName(
						getClass().getPackage().getName() + ".CADTSTrade"
								+ ip.get_ID()).newInstance();
				//放入map
				tradeMap.put(ip.get_ID(), tf);
			} catch (Exception e) {
				op = new OPFather(ip);
				op.setErrCode(ErrCodeTable.ERR_OTHER);
				op.setErrMessage("Trade Code " + ip.get_ID() + " not find!");
				op.setSucceed(false);
				LogProxy.printTrade(ip.get_ID(), ip, op, op.isSucceed());
				return op;
			}
		}
		
		//交易命令 从手机端发送过来的
		OPFather opfather = tf.call_trade(ip, fromServ);
		opfather.set_tradeUsedTime(System.currentTimeMillis() - startTime);
		LogProxy.printTrade(ip.get_ID(), ip, opfather, opfather.isSucceed());
		return opfather;
	}

}
