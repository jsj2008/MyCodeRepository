package jedi.ex01.CSTS3.comm.struct;


public class MoneyAccount extends allone.json.AbstractJsonData {

	public static final String jsonId = "15";

	public static final String account = "1";
	public static final String currencyName = "2";
	public static final String beginBalance = "3";
	public static final String deposit = "4";
	public static final String withdraw = "5";
	public static final String charge = "6";
	public static final String adjust = "7";
	public static final String commision = "8";
	public static final String tradePL = "9";
	public static final String rollover = "10";
	public static final String transfer = "11";
	public static final String margin2 = "12";
	public static final String beginMargin2 = "13";
	public static final String freeze = "14";
	public static final String other = "15";

	private transient boolean _hasBeenFixed = false;
	private transient double _floatPL;
	private transient double _rollover;
	private transient double _marginOccupied4OpenTrade;
	private transient double _marginOccupied4MarginCall1;
	private transient double _marginOccupied4MarginCall2;
	private transient double _marginOccupied4Liquidation;
	private transient double _marginOccupied4OpenTradeLocked;

	public MoneyAccount(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(MoneyAccount.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(MoneyAccount.account, account);
	}

	public String getCurrencyName() {
		try {
			String data=getEntryString(MoneyAccount.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(MoneyAccount.currencyName, currencyName);
	}

	public double getBeginBalance() {
		try {
			double data=getEntryDouble(MoneyAccount.beginBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBeginBalance(double beginBalance) {
		setEntry(MoneyAccount.beginBalance, beginBalance);
	}

	public double getDeposit() {
		try {
			double data=getEntryDouble(MoneyAccount.deposit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeposit(double deposit) {
		setEntry(MoneyAccount.deposit, deposit);
	}

	public double getWithdraw() {
		try {
			double data=getEntryDouble(MoneyAccount.withdraw);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setWithdraw(double withdraw) {
		setEntry(MoneyAccount.withdraw, withdraw);
	}

	public double getCharge() {
		try {
			double data=getEntryDouble(MoneyAccount.charge);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCharge(double charge) {
		setEntry(MoneyAccount.charge, charge);
	}

	public double getAdjust() {
		try {
			double data=getEntryDouble(MoneyAccount.adjust);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAdjust(double adjust) {
		setEntry(MoneyAccount.adjust, adjust);
	}

	public double getCommision() {
		try {
			double data=getEntryDouble(MoneyAccount.commision);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision(double commision) {
		setEntry(MoneyAccount.commision, commision);
	}

	public double getTradePL() {
		try {
			double data=getEntryDouble(MoneyAccount.tradePL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradePL(double tradePL) {
		setEntry(MoneyAccount.tradePL, tradePL);
	}

	public double getRollover() {
		try {
			double data=getEntryDouble(MoneyAccount.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(MoneyAccount.rollover, rollover);
	}

	public double getTransfer() {
		try {
			double data=getEntryDouble(MoneyAccount.transfer);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTransfer(double transfer) {
		setEntry(MoneyAccount.transfer, transfer);
	}

	public double getMargin2() {
		try {
			double data=getEntryDouble(MoneyAccount.margin2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMargin2(double margin2) {
		setEntry(MoneyAccount.margin2, margin2);
	}

	public double getBeginMargin2() {
		try {
			double data=getEntryDouble(MoneyAccount.beginMargin2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBeginMargin2(double beginMargin2) {
		setEntry(MoneyAccount.beginMargin2, beginMargin2);
	}

	public double getFreeze() {
		try {
			double data=getEntryDouble(MoneyAccount.freeze);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFreeze(double freeze) {
		setEntry(MoneyAccount.freeze, freeze);
	}

	public double getOther() {
		try {
			double data=getEntryDouble(MoneyAccount.other);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOther(double other) {
		setEntry(MoneyAccount.other, other);
	}

	public boolean is_hasBeenFixed() {
		return _hasBeenFixed;
	}

	public void set_hasBeenFixed(boolean beenFixed) {
		_hasBeenFixed = beenFixed;
	}

	public double get_floatPL() {
		return _floatPL;
	}

	public void set_floatPL(double _floatpl) {
		_floatPL = _floatpl;
	}

	public double get_rollover() {
		return _rollover;
	}

	public void set_rollover(double _rollover) {
		this._rollover = _rollover;
	}

	public double get_marginOccupied4OpenTrade() {
		return _marginOccupied4OpenTrade;
	}

	public void set_marginOccupied4OpenTrade(double occupied4OpenTrade) {
		_marginOccupied4OpenTrade = occupied4OpenTrade;
	}

	public double get_marginOccupied4MarginCall1() {
		return _marginOccupied4MarginCall1;
	}

	public void set_marginOccupied4MarginCall1(double occupied4MarginCall1) {
		_marginOccupied4MarginCall1 = occupied4MarginCall1;
	}

	public double get_marginOccupied4MarginCall2() {
		return _marginOccupied4MarginCall2;
	}

	public void set_marginOccupied4MarginCall2(double occupied4MarginCall2) {
		_marginOccupied4MarginCall2 = occupied4MarginCall2;
	}

	public double get_marginOccupied4Liquidation() {
		return _marginOccupied4Liquidation;
	}

	public void set_marginOccupied4Liquidation(double occupied4Liquidation) {
		_marginOccupied4Liquidation = occupied4Liquidation;
	}

	public double get_marginOccupied4OpenTradeLocked() {
		return _marginOccupied4OpenTradeLocked;
	}

	public void set_marginOccupied4OpenTradeLocked(double _marginOccupied4OpenTradeLocked) {
		this._marginOccupied4OpenTradeLocked = _marginOccupied4OpenTradeLocked;
	}

}