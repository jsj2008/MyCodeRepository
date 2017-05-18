package jedi.ex01.client.station.api.bankserver;

public class BCTradeResult_CanWithdraw extends BCTradeResult {
	public static final int RESULT_STATUS_OK = 0;
	public static final int RESULT_STATUS_ACCOUNT_NEED_TO_BALANCE = -1;
	private double value;
	private int resultStatus;

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	public int getResultStatus() {
		return resultStatus;
	}

	public void setResultStatus(int resultStatus) {
		this.resultStatus = resultStatus;
	}
}
