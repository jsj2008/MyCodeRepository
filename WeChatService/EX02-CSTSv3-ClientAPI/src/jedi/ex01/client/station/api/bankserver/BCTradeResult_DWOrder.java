package jedi.ex01.client.station.api.bankserver;

import jedi.v7.bankserver.comm.struct.ClientBankOrder;

public class BCTradeResult_DWOrder extends BCTradeResult {

	private ClientBankOrder[] orders;

	public ClientBankOrder[] getOrders() {
		return orders;
	}

	public void setOrders(ClientBankOrder[] orders) {
		this.orders = orders;
	}

}
