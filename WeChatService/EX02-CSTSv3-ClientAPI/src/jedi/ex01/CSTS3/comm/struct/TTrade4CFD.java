package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class TTrade4CFD extends allone.json.AbstractJsonData {

	public static final String jsonId = "25";

	public static final String ticket = "1";
	public static final String splitNo = "2";
	public static final String instrument = "3";
	public static final String account = "4";
	public static final String orderID = "5";
	public static final String osplitNo = "6";
	public static final String buySell = "7";
	public static final String lots = "8";
	public static final String openPrice = "9";
	public static final String commision_4Open = "10";
	public static final String subCommision_system_4Open = "11";
	public static final String subCommision_group_4Open = "12";
	public static final String subCommision_account_4Open = "13";
	public static final String commision_currency = "14";
	public static final String rollover = "15";
	public static final String openTradeDay = "16";
	public static final String openTime = "17";
	public static final String corOrderID = "18";
	public static final String marginRate = "19";
	public static final String openGroup = "20";
	public static final String isDelivery = "21";

	private transient boolean _hasBeenFixed=false;
	private transient double _floatPL;
	private transient double _marginOccupied4OpenTrade;
	private transient double _marginOccupied4MarginCall1;
	private transient double _marginOccupied4MarginCall2;
	private transient double _marginOccupied4Liquidation;
	private transient double _closeCommissionInAccountCurrency;
	
	public static final String oriOpenPrice = "22";
	public static final String realizedPL = "23";
	public static final String realizedRollover = "24";
	public static final String _totalMargin = "32";
	public static final String _note = "33";

	public TTrade4CFD(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getTicket() {
		try {
			long data=getEntryLong(TTrade4CFD.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(TTrade4CFD.ticket, ticket);
	}

	public int getSplitNo() {
		try {
			int data=getEntryInt(TTrade4CFD.splitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitNo(int splitNo) {
		setEntry(TTrade4CFD.splitNo, splitNo);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(TTrade4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(TTrade4CFD.instrument, instrument);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(TTrade4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(TTrade4CFD.account, account);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(TTrade4CFD.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(TTrade4CFD.orderID, orderID);
	}

	public int getOsplitNo() {
		try {
			int data=getEntryInt(TTrade4CFD.osplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOsplitNo(int osplitNo) {
		setEntry(TTrade4CFD.osplitNo, osplitNo);
	}

	public int getBuySell() {
		try {
			int data=getEntryInt(TTrade4CFD.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		setEntry(TTrade4CFD.buySell, buySell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(TTrade4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(TTrade4CFD.lots, lots);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(TTrade4CFD.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(TTrade4CFD.openPrice, openPrice);
	}

	public double getCommision_4Open() {
		try {
			double data=getEntryDouble(TTrade4CFD.commision_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4Open(double commision_4Open) {
		setEntry(TTrade4CFD.commision_4Open, commision_4Open);
	}

	public double getSubCommision_system_4Open() {
		try {
			double data=getEntryDouble(TTrade4CFD.subCommision_system_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_system_4Open(double subCommision_system_4Open) {
		setEntry(TTrade4CFD.subCommision_system_4Open, subCommision_system_4Open);
	}

	public double getSubCommision_group_4Open() {
		try {
			double data=getEntryDouble(TTrade4CFD.subCommision_group_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_group_4Open(double subCommision_group_4Open) {
		setEntry(TTrade4CFD.subCommision_group_4Open, subCommision_group_4Open);
	}

	public double getSubCommision_account_4Open() {
		try {
			double data=getEntryDouble(TTrade4CFD.subCommision_account_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_account_4Open(double subCommision_account_4Open) {
		setEntry(TTrade4CFD.subCommision_account_4Open, subCommision_account_4Open);
	}

	public String getCommision_currency() {
		try {
			String data=getEntryString(TTrade4CFD.commision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCommision_currency(String commision_currency) {
		setEntry(TTrade4CFD.commision_currency, commision_currency);
	}

	public double getRollover() {
		try {
			double data=getEntryDouble(TTrade4CFD.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(TTrade4CFD.rollover, rollover);
	}

	public String getOpenTradeDay() {
		try {
			String data=getEntryString(TTrade4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(TTrade4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(TTrade4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(TTrade4CFD.openTime, openTime);
	}

	public long getCorOrderID() {
		try {
			long data=getEntryLong(TTrade4CFD.corOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCorOrderID(long corOrderID) {
		setEntry(TTrade4CFD.corOrderID, corOrderID);
	}

	public double getMarginRate() {
		try {
			double data=getEntryDouble(TTrade4CFD.marginRate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginRate(double marginRate) {
		setEntry(TTrade4CFD.marginRate, marginRate);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(TTrade4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(TTrade4CFD.openGroup, openGroup);
	}

	public int getIsDelivery() {
		try {
			int data=getEntryInt(TTrade4CFD.isDelivery);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsDelivery(int isDelivery) {
		setEntry(TTrade4CFD.isDelivery, isDelivery);
	}

	public boolean is_hasBeenFixed() {
		return _hasBeenFixed;
	}

	public void set_hasBeenFixed(boolean _hasBeenFixed) {
		this._hasBeenFixed = _hasBeenFixed;
	}

	public double get_floatPL() {
		return _floatPL;
	}

	public void set_floatPL(double _floatPL) {
		this._floatPL = _floatPL;
	}

	public double get_marginOccupied4OpenTrade() {
		return _marginOccupied4OpenTrade;
	}

	public void set_marginOccupied4OpenTrade(double _marginOccupied4OpenTrade) {
		this._marginOccupied4OpenTrade = _marginOccupied4OpenTrade;
	}

	public double get_marginOccupied4MarginCall1() {
		return _marginOccupied4MarginCall1;
	}

	public void set_marginOccupied4MarginCall1(double _marginOccupied4MarginCall1) {
		this._marginOccupied4MarginCall1 = _marginOccupied4MarginCall1;
	}

	public double get_marginOccupied4MarginCall2() {
		return _marginOccupied4MarginCall2;
	}

	public void set_marginOccupied4MarginCall2(double _marginOccupied4MarginCall2) {
		this._marginOccupied4MarginCall2 = _marginOccupied4MarginCall2;
	}

	public double get_marginOccupied4Liquidation() {
		return _marginOccupied4Liquidation;
	}

	public void set_marginOccupied4Liquidation(double _marginOccupied4Liquidation) {
		this._marginOccupied4Liquidation = _marginOccupied4Liquidation;
	}

	public double get_closeCommissionInAccountCurrency() {
		return _closeCommissionInAccountCurrency;
	}

	public void set_closeCommissionInAccountCurrency(double _closeCommissionInAccountCurrency) {
		this._closeCommissionInAccountCurrency = _closeCommissionInAccountCurrency;
	}
	
	public double get_totalMargin() {
		try {
			double data=getEntryDouble(TTrade4CFD._totalMargin);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_totalMargin(double _totalMargin) {
		setEntry(TTrade4CFD._totalMargin, _totalMargin);
	}
	
	public double get_note() {
		try {
			double data=getEntryDouble(TTrade4CFD._note);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_note(String _note) {
		setEntry(TTrade4CFD._note, _note);
	}
	
	public String getOriOpenPrice() {
		try {
			String data=getEntryString(TTrade4CFD.oriOpenPrice);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOriOpenPrice(double oriOpenPrice) {
		setEntry(TTrade4CFD.oriOpenPrice, oriOpenPrice);
	}
	
	public double getRealizedPL() {
		try {
			double data=getEntryDouble(TTrade4CFD.realizedPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedPL(double realizedPL) {
		setEntry(TTrade4CFD.realizedPL, realizedPL);
	}
	
	public double getRealizedRollover() {
		try {
			double data=getEntryDouble(TTrade4CFD.realizedRollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedRollover(double realizedRollover) {
		setEntry(TTrade4CFD.realizedRollover, realizedRollover);
	}
	
}