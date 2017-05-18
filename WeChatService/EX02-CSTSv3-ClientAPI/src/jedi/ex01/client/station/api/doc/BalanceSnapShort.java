package jedi.ex01.client.station.api.doc;

public class BalanceSnapShort {
	private String instrumentCurr;
	private String balanceCurr;
	private double rate;
	private double instrumentCurrMoney;
	private double balanceCurrMoney;

	public BalanceSnapShort(String instrumentCurr, String balanceCurr,
			double rate, double instrumentCurrMoney, double balanceCurrMoney) {
		this.instrumentCurr = instrumentCurr;
		this.balanceCurr = balanceCurr;
		this.rate = rate;
		this.instrumentCurrMoney = instrumentCurrMoney;
		this.balanceCurrMoney = balanceCurrMoney;
	}

	public String getInstrumentCurr() {
		return instrumentCurr;
	}

	public String getBalanceCurr() {
		return balanceCurr;
	}

	public double getRate() {
		return rate;
	}

	public double getInstrumentCurrMoney() {
		return instrumentCurrMoney;
	}

	public double getBalanceCurrMoney() {
		return balanceCurrMoney;
	}
}
