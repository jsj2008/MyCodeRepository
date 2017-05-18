package jedi.ex01.client.station.api.bankserver;

public class BCTradeResult_Deposit extends BCTradeResult {

	private boolean existUrl = false;
	private String depositUrl;

	public boolean isExistUrl() {
		return existUrl;
	}

	public void setExistUrl(boolean existUrl) {
		this.existUrl = existUrl;
	}

	public String getDepositUrl() {
		return depositUrl;
	}

	public void setDepositUrl(String depositUrl) {
		this.depositUrl = depositUrl;
		this.existUrl = true;
	}

}
