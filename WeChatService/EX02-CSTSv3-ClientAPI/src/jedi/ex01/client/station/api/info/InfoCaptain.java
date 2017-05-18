package jedi.ex01.client.station.api.info;

import java.util.HashMap;

import jedi.ex01.CSTS3.comm.info.InfoFather;

public class InfoCaptain {
	private static InfoCaptain instance = new InfoCaptain();
	private HashMap operatorMap = new HashMap();

	private InfoCaptain() {
		initOperator();
	}

	private void initOperator() {
		operatorMap.put("TRADESERV1003", new InfoOperator_TRADESERV1003());
		operatorMap.put("TRADESERV1004", new InfoOperator_TRADESERV1004());
		operatorMap.put("TRADESERV1005", new InfoOperator_TRADESERV1005());
		operatorMap.put("TRADESERV1006", new InfoOperator_TRADESERV1006());
		operatorMap.put("TRADESERV1010", new InfoOperator_TRADESERV1010());
		operatorMap.put("TRADESERV1011", new InfoOperator_TRADESERV1011());
		operatorMap.put("TRADESERV1012", new InfoOperator_TRADESERV1012());
		operatorMap.put("TRADESERV1013", new InfoOperator_TRADESERV1013());
		operatorMap.put("TRADESERV1014", new InfoOperator_TRADESERV1014());
		operatorMap.put("TRADESERV1015", new InfoOperator_TRADESERV1015());
		operatorMap.put("TRADESERV1016", new InfoOperator_TRADESERV1016());
		operatorMap.put("TRADESERV1007", new InfoOperator_TRADESERV1007());
		operatorMap.put("TRADESERV1008", new InfoOperator_TRADESERV1008());
		
	}

	public static InfoCaptain getInstance() {
		return instance;
	}

	public boolean onInfo(InfoFather info) {
		InfoOperator operator = (InfoOperator) operatorMap.get(info.getID());
		if (operator != null) {
			operator.onInfo(info);
			return true;
		} else {
			System.out.println("Can not find operator for info "
					+ info.getID());
			return false;
		}
	}
}
