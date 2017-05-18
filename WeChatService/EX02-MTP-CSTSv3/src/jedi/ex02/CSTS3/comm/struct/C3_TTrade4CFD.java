package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.TTrade4CFD;

public class C3_TTrade4CFD extends allone.json.AbstractJsonData {

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
	// public static final String isDelivery = "21";

	public static final String oriOpenPrice = "22";
	public static final String realizedPL = "23";
	public static final String realizedRollover = "24";
	public static final String _totalMargin = "32";
	public static final String _note = "33";

	public static final String _hasBeenFixed = "25";
	public static final String _floatPL = "26";
	public static final String _marginOccupied4OpenTrade = "27";
	public static final String _marginOccupied4MarginCall1 = "28";
	public static final String _marginOccupied4MarginCall2 = "29";
	public static final String _marginOccupied4Liquidation = "30";
	public static final String _closeCommissionInAccountCurrency = "31";

	public static final String amount = "34";

	public C3_TTrade4CFD() {
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(TTrade4CFD data) throws Exception {
		setTicket(data.getTicket());
		setSplitNo(data.getSplitNo());
		setInstrument(data.getInstrument());
		setAccount(data.getAccount());
		setOrderID(data.getOrderID());
		setOsplitNo(data.getOsplitNo());
		setBuySell(data.getBuySell());
		setLots(data.getLots());
		setOpenPrice(data.getOpenPrice());
		setCommision_4Open(data.getCommision_4Open());
		setSubCommision_system_4Open(data.getSubCommision_system_4Open());
		setSubCommision_group_4Open(data.getSubCommision_group_4Open());
		setSubCommision_account_4Open(data.getSubCommision_account_4Open());
		setCommision_currency(data.getCommision_currency());
		setRollover(data.getRollover());
		setOpenTradeDay(data.getOpenTradeDay());
		setOpenTime(data.getOpenTime());
		setCorOrderID(data.getCorOrderID());
		setMarginRate(data.getMarginRate());
		setOpenGroup(data.getOpenGroup());
		// setIsDelivery(data.getIsDelivery());

		setOriOpenPrice(data.getOriOpenPrice());
		setRealizedPL(data.getRealizedPL());
		setRealizedRollover(data.getRealizedRollover());
		set_hasBeenFixed(data.is_hasBeenFixed());
		set_floatPL(data.get_floatPL());
		set_marginOccupied4OpenTrade(data.get_marginOccupied4OpenTrade());
		set_marginOccupied4MarginCall1(data.get_marginOccupied4MarginCall1());
		set_marginOccupied4MarginCall2(data.get_marginOccupied4MarginCall2());
		set_marginOccupied4Liquidation(data.get_marginOccupied4Liquidation());
		set_closeCommissionInAccountCurrencyCall2(data
				.get_closeCommissionInAccountCurrency());
		set_totalMargin(data.get_totalMargin());
		set_note(data.get_note());
		setAmount(data.getAmount());
	}

	public TTrade4CFD format() {
		TTrade4CFD data = new TTrade4CFD();
		data.setTicket(getTicket());
		data.setSplitNo(getSplitNo());
		data.setInstrument(getInstrument());
		data.setAccount(getAccount());
		data.setOrderID(getOrderID());
		data.setOsplitNo(getOsplitNo());
		data.setBuySell(getBuySell());
		data.setLots(getLots());
		data.setOpenPrice(getOpenPrice());
		data.setCommision_4Open(getCommision_4Open());
		data.setSubCommision_system_4Open(getSubCommision_system_4Open());
		data.setSubCommision_group_4Open(getSubCommision_group_4Open());
		data.setSubCommision_account_4Open(getSubCommision_account_4Open());
		data.setCommision_currency(getCommision_currency());
		data.setRollover(getRollover());
		data.setOpenTradeDay(getOpenTradeDay());
		data.setOpenTime(getOpenTime());
		data.setCorOrderID(getCorOrderID());
		data.setMarginRate(getMarginRate());
		data.setOpenGroup(getOpenGroup());
		data.setAmount(getAmount());
		// data.setIsDelivery(getIsDelivery());
		return data;
	}

	public long getTicket() {
		try {
			long data = getEntryLong(C3_TTrade4CFD.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(C3_TTrade4CFD.ticket, ticket);
	}

	public int getSplitNo() {
		try {
			int data = getEntryInt(C3_TTrade4CFD.splitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitNo(int splitNo) {
		setEntry(C3_TTrade4CFD.splitNo, splitNo);
	}

	public String getInstrument() {
		try {
			String data = getEntryString(C3_TTrade4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_TTrade4CFD.instrument, instrument);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_TTrade4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_TTrade4CFD.account, account);
	}

	public long getOrderID() {
		try {
			long data = getEntryLong(C3_TTrade4CFD.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_TTrade4CFD.orderID, orderID);
	}

	public int getOsplitNo() {
		try {
			int data = getEntryInt(C3_TTrade4CFD.osplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOsplitNo(int osplitNo) {
		setEntry(C3_TTrade4CFD.osplitNo, osplitNo);
	}

	public int getBuySell() {
		try {
			int data = getEntryInt(C3_TTrade4CFD.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		setEntry(C3_TTrade4CFD.buySell, buySell);
	}

	public double getLots() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_TTrade4CFD.lots, lots);
	}

	public double getOpenPrice() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(C3_TTrade4CFD.openPrice, openPrice);
	}

	public double getCommision_4Open() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.commision_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4Open(double commision_4Open) {
		setEntry(C3_TTrade4CFD.commision_4Open, commision_4Open);
	}

	public double getSubCommision_system_4Open() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.subCommision_system_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_system_4Open(double subCommision_system_4Open) {
		setEntry(C3_TTrade4CFD.subCommision_system_4Open,
				subCommision_system_4Open);
	}

	public double getSubCommision_group_4Open() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.subCommision_group_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_group_4Open(double subCommision_group_4Open) {
		setEntry(C3_TTrade4CFD.subCommision_group_4Open,
				subCommision_group_4Open);
	}

	public double getSubCommision_account_4Open() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.subCommision_account_4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_account_4Open(double subCommision_account_4Open) {
		setEntry(C3_TTrade4CFD.subCommision_account_4Open,
				subCommision_account_4Open);
	}

	public String getCommision_currency() {
		try {
			String data = getEntryString(C3_TTrade4CFD.commision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCommision_currency(String commision_currency) {
		setEntry(C3_TTrade4CFD.commision_currency, commision_currency);
	}

	public double getRollover() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(C3_TTrade4CFD.rollover, rollover);
	}

	public String getOpenTradeDay() {
		try {
			String data = getEntryString(C3_TTrade4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(C3_TTrade4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data = getEntryDate(C3_TTrade4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(C3_TTrade4CFD.openTime, openTime);
	}

	public long getCorOrderID() {
		try {
			long data = getEntryLong(C3_TTrade4CFD.corOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCorOrderID(long corOrderID) {
		setEntry(C3_TTrade4CFD.corOrderID, corOrderID);
	}

	public double getMarginRate() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.marginRate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginRate(double marginRate) {
		setEntry(C3_TTrade4CFD.marginRate, marginRate);
	}

	public String getOpenGroup() {
		try {
			String data = getEntryString(C3_TTrade4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(C3_TTrade4CFD.openGroup, openGroup);
	}

	// public int getIsDelivery() {
	// try {
	// int data=getEntryInt(C3_TTrade4CFD.isDelivery);
	// return data;
	// } catch (RuntimeException e) {
	// return 0;
	// }
	// }
	//
	// public void setIsDelivery(int isDelivery) {
	// setEntry(C3_TTrade4CFD.isDelivery, isDelivery);
	// }

	public boolean get_hasBeenFixed() {
		try {
			boolean data = getEntryBoolean(C3_TTrade4CFD._hasBeenFixed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void set_hasBeenFixed(Boolean _hasBeenFixed) {
		setEntry(C3_TTrade4CFD._hasBeenFixed, _hasBeenFixed);
	}

	public double get_floatPL() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._floatPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_floatPL(double _floatPL) {
		setEntry(C3_TTrade4CFD._floatPL, _floatPL);
	}

	public double get_marginOccupied4OpenTrade() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._marginOccupied4OpenTrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4OpenTrade(double _marginOccupied4OpenTrade) {
		setEntry(C3_TTrade4CFD._marginOccupied4OpenTrade,
				_marginOccupied4OpenTrade);
	}

	public double get_marginOccupied4MarginCall1() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._marginOccupied4MarginCall1);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4MarginCall1(
			double _marginOccupied4MarginCall1) {
		setEntry(C3_TTrade4CFD._marginOccupied4MarginCall1,
				_marginOccupied4MarginCall1);
	}

	public double get_marginOccupied4MarginCall2() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._marginOccupied4MarginCall2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4MarginCall2(
			double _marginOccupied4MarginCall2) {
		setEntry(C3_TTrade4CFD._marginOccupied4MarginCall2,
				_marginOccupied4MarginCall2);
	}

	public double get_marginOccupied4Liquidation() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._marginOccupied4Liquidation);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_marginOccupied4Liquidation(
			double _marginOccupied4Liquidation) {
		setEntry(C3_TTrade4CFD._marginOccupied4MarginCall2,
				_marginOccupied4MarginCall2);
	}

	public double get_closeCommissionInAccountCurrency() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._closeCommissionInAccountCurrency);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_closeCommissionInAccountCurrencyCall2(
			double _closeCommissionInAccountCurrency) {
		setEntry(C3_TTrade4CFD._closeCommissionInAccountCurrency,
				_closeCommissionInAccountCurrency);
	}

	public double get_totalMargin() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._totalMargin);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_totalMargin(double _totalMargin) {
		setEntry(C3_TTrade4CFD._totalMargin, _totalMargin);
	}

	public double get_note() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD._note);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void set_note(String _note) {
		setEntry(C3_TTrade4CFD._note, _note);
	}

	public String getOriOpenPrice() {
		try {
			String data = getEntryString(C3_TTrade4CFD.oriOpenPrice);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOriOpenPrice(double oriOpenPrice) {
		setEntry(C3_TTrade4CFD.oriOpenPrice, oriOpenPrice);
	}

	public double getRealizedPL() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.realizedPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedPL(double realizedPL) {
		setEntry(C3_TTrade4CFD.realizedPL, realizedPL);
	}

	public double getRealizedRollover() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.realizedRollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedRollover(double realizedRollover) {
		setEntry(C3_TTrade4CFD.realizedRollover, realizedRollover);
	}

	public double getAmount() {
		try {
			double data = getEntryDouble(C3_TTrade4CFD.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_TTrade4CFD.amount, amount);
	}

}