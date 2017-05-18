package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.MoneyAccount;


public class C3_MoneyAccount extends allone.json.AbstractJsonData {

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
	
	public static final String _hasBeenFixed = "16";
	public static final String _floatPL = "17";
	public static final String _rollover = "18";
	public static final String _marginOccupied4OpenTrade = "19";
	public static final String _marginOccupied4MarginCall1 = "20";
	public static final String _marginOccupied4MarginCall2 = "21";
	public static final String _marginOccupied4Liquidation = "22";
	public static final String _marginOccupied4OpenTradeLocked = "23";

	public C3_MoneyAccount(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(MoneyAccount data) throws Exception {
		setAccount(data.getAccount());
		setCurrencyName(data.getCurrencyName());
		setBeginBalance(data.getBeginBalance());
		setDeposit(data.getDeposit());
		setWithdraw(data.getWithdraw());
		setCharge(data.getCharge());
		setAdjust(data.getAdjust());
		setCommision(data.getCommision());
		setTradePL(data.getTradePL());
		setRollover(data.getRollover());
		setTransfer(data.getTransfer());
		setMargin2(data.getMargin2());
		setBeginMargin2(data.getBeginMargin2());
		setFreeze(data.getFreeze());
		setOther(data.getOther());
		
		set_hasBeenFixed(data.is_hasBeenFixed());
		set_floatPL(data.get_floatPL());
		set_rollover(data.get_rollover());
		set_marginOccupied4OpenTrade(data.get_marginOccupied4OpenTrade());
		set_marginOccupied4MarginCall1(data.get_marginOccupied4MarginCall1());
		set_marginOccupied4MarginCall2(data.get_marginOccupied4MarginCall2());
		set_marginOccupied4Liquidation(data.get_marginOccupied4Liquidation());
		set_marginOccupied4OpenTradeLocked(data.get_marginOccupied4OpenTradeLocked());
	}

	public MoneyAccount format(){
		MoneyAccount data=new MoneyAccount();
		data.setAccount(getAccount());
		data.setCurrencyName(getCurrencyName());
		data.setBeginBalance(getBeginBalance());
		data.setDeposit(getDeposit());
		data.setWithdraw(getWithdraw());
		data.setCharge(getCharge());
		data.setAdjust(getAdjust());
		data.setCommision(getCommision());
		data.setTradePL(getTradePL());
		data.setRollover(getRollover());
		data.setTransfer(getTransfer());
		data.setMargin2(getMargin2());
		data.setBeginMargin2(getBeginMargin2());
		data.setFreeze(getFreeze());
		data.setOther(getOther());
		return data;
	}


	public long getAccount() {
		try {
			long data=getEntryLong(C3_MoneyAccount.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_MoneyAccount.account, account);
	}

	public String getCurrencyName() {
		try {
			String data=getEntryString(C3_MoneyAccount.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(C3_MoneyAccount.currencyName, currencyName);
	}

	public double getBeginBalance() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.beginBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBeginBalance(double beginBalance) {
		setEntry(C3_MoneyAccount.beginBalance, beginBalance);
	}

	public double getDeposit() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.deposit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeposit(double deposit) {
		setEntry(C3_MoneyAccount.deposit, deposit);
	}

	public double getWithdraw() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.withdraw);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setWithdraw(double withdraw) {
		setEntry(C3_MoneyAccount.withdraw, withdraw);
	}

	public double getCharge() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.charge);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCharge(double charge) {
		setEntry(C3_MoneyAccount.charge, charge);
	}

	public double getAdjust() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.adjust);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAdjust(double adjust) {
		setEntry(C3_MoneyAccount.adjust, adjust);
	}

	public double getCommision() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.commision);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision(double commision) {
		setEntry(C3_MoneyAccount.commision, commision);
	}

	public double getTradePL() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.tradePL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradePL(double tradePL) {
		setEntry(C3_MoneyAccount.tradePL, tradePL);
	}

	public double getRollover() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(C3_MoneyAccount.rollover, rollover);
	}

	public double getTransfer() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.transfer);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTransfer(double transfer) {
		setEntry(C3_MoneyAccount.transfer, transfer);
	}

	public double getMargin2() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.margin2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMargin2(double margin2) {
		setEntry(C3_MoneyAccount.margin2, margin2);
	}

	public double getBeginMargin2() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.beginMargin2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBeginMargin2(double beginMargin2) {
		setEntry(C3_MoneyAccount.beginMargin2, beginMargin2);
	}

	public double getFreeze() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.freeze);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFreeze(double freeze) {
		setEntry(C3_MoneyAccount.freeze, freeze);
	}

	
	
	
	///////////
	public boolean get_hasBeenFixed() {
		try {
			boolean data=getEntryBoolean(C3_MoneyAccount._hasBeenFixed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void set_hasBeenFixed(Boolean _hasBeenFixed) {
		setEntry(C3_MoneyAccount._hasBeenFixed, _hasBeenFixed);
	}
	
	public double get_floatPL() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._floatPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_floatPL(double _floatPL) {
		setEntry(C3_MoneyAccount._floatPL, _floatPL);
	}
	
	public double get_rollover() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_rollover(double _rollover) {
		setEntry(C3_MoneyAccount._rollover, _rollover);
	}
	
	public double get_marginOccupied4OpenTrade() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._marginOccupied4OpenTrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4OpenTrade(double _marginOccupied4OpenTrade) {
		setEntry(C3_MoneyAccount._marginOccupied4OpenTrade, _marginOccupied4OpenTrade);
	}
	
	public double get_marginOccupied4MarginCall1() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._marginOccupied4MarginCall1);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4MarginCall1(double _marginOccupied4MarginCall1) {
		setEntry(C3_MoneyAccount._marginOccupied4MarginCall1, _marginOccupied4MarginCall1);
	}
	
	public double get_marginOccupied4MarginCall2() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._marginOccupied4MarginCall2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4MarginCall2(double _marginOccupied4MarginCall2) {
		setEntry(C3_MoneyAccount._marginOccupied4MarginCall2, _marginOccupied4MarginCall2);
	}
	
	public double get_marginOccupied4Liquidation() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._marginOccupied4Liquidation);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4Liquidation(double _marginOccupied4Liquidation) {
		setEntry(C3_MoneyAccount._marginOccupied4Liquidation, _marginOccupied4Liquidation);
	}
	
	public double get_marginOccupied4OpenTradeLocked() {
		try {
			double data=getEntryDouble(C3_MoneyAccount._marginOccupied4OpenTradeLocked);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4OpenTradeLocked(double _marginOccupied4OpenTradeLocked) {
		setEntry(C3_MoneyAccount._marginOccupied4OpenTradeLocked, _marginOccupied4OpenTradeLocked);
	}
	
	public double getOther() {
		try {
			double data=getEntryDouble(C3_MoneyAccount.other);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOther(double other) {
		setEntry(C3_MoneyAccount.other, other);
	}


}