package jedi.ex01.CSTS3.comm.struct;

import ex.v01.exchange.comm.db.EX_InstrumentListed;

public class InstrumentListed extends allone.json.AbstractJsonData {

	public static final String jsonId = "35";

	public static final String instrument = "1";
	public static final String benchmarkInstrument = "2";
	public static final String fundId = "3";
	public static final String listedType = "4";
	public static final String buySell = "5";
	public static final String listedVolume = "6";
	public static final String deliveryDays = "7";

	// 交收
	public static final String minDeliveryLot = "8"; // �?��交收单位
	public static final String sumDailyDeliveryLots = "9";// 每日交收总数�?
	public static final String deliveryCommType = "10";// 交收佣金类型
	public static final String deliveryCommission = "11";// 交收佣金
	public static final String deliveryMarginType = "12";// 交收保证金类�?
	public static final String deliveryMargin = "13";// 交收占用保证�?
	public static final String deliveryWarehouseName = "14";// 仓库名称
	public static final String address = "15";// 地址
	public static final String linkman = "16";// 联系�?
	public static final String phone = "17";// 电话

	public InstrumentListed() {
		super();
		setEntry("jsonId", jsonId);
	}
 
	public String getInstrument() {
		try {
			String data = getEntryString(InstrumentListed.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		this.setEntry(InstrumentListed.instrument, instrument);
	}

	public String getBenchmarkInstrument() {
		try {
			String data = getEntryString(InstrumentListed.benchmarkInstrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBenchmarkInstrument(String benchmarkInstrument) {
		this.setEntry(InstrumentListed.benchmarkInstrument,
				benchmarkInstrument);
	}

	public int getFundID() {
		try {
			int data = getEntryInt(InstrumentListed.fundId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundID(int fundID) {
		this.setEntry(InstrumentListed.fundId, fundID);
	}

	public int getListedType() {
		try {
			int data = getEntryInt(InstrumentListed.listedType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setListedType(int listedType) {
		this.setEntry(InstrumentListed.listedType, listedType);
	}

	public int getBuySell() {
		try {
			int data = getEntryInt(InstrumentListed.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		this.setEntry(InstrumentListed.buySell, buySell);
	}

	public long getListedVolume() {
		try {
			return getEntryLong(InstrumentListed.listedVolume);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setListedVolume(long listedVolume) {
		this.setEntry(InstrumentListed.listedVolume, listedVolume);
	}

	public int getDeliveryDays() {
		try {
			int data = getEntryInt(InstrumentListed.deliveryDays);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryDays(int deliveryDays) {
		this.setEntry(InstrumentListed.deliveryDays, deliveryDays);
	}

	public double getMinDeliveryLot() {
		try {
			return getEntryDouble(InstrumentListed.minDeliveryLot);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinDeliveryLot(double minDeliveryLot) {
		this.setEntry(InstrumentListed.minDeliveryLot, minDeliveryLot);
	}

	public double getSumDailyDeliveryLots() {
		try {
			return getEntryDouble(InstrumentListed.sumDailyDeliveryLots);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSumDailyDeliveryLots(double sumDailyDeliveryLots) {
		this.setEntry(InstrumentListed.sumDailyDeliveryLots,
				sumDailyDeliveryLots);
	}

	public int getDeliveryCommType() {
		try {
			int data = getEntryInt(InstrumentListed.deliveryCommType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryCommType(int deliveryCommType) {
		this.setEntry(InstrumentListed.deliveryCommType, deliveryCommType);
	}

	public int getDeliveryMarginType() {
		try {
			int data = getEntryInt(InstrumentListed.deliveryMarginType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryMarginType(int deliveryMarginType) {
		this.setEntry(InstrumentListed.deliveryMarginType,
				deliveryMarginType);
	}

	public double getDeliveryCommission() {
		try {
			return getEntryDouble(InstrumentListed.deliveryCommission);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryCommission(double deliveryCommission) {
		this.setEntry(InstrumentListed.deliveryCommission,
				deliveryCommission);
	}

	public double getDeliveryMargin() {
		try {
			return getEntryDouble(InstrumentListed.deliveryMargin);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryMargin(double deliveryMargin) {
		this.setEntry(InstrumentListed.deliveryMargin, deliveryMargin);
	}

	public String getDeliveryWarehouseName() {
		try {
			return getEntryString(InstrumentListed.deliveryWarehouseName);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDeliveryWarehouseName(String deliveryWarehouseName) {
		this.setEntry(InstrumentListed.deliveryWarehouseName,
				deliveryWarehouseName);
	}

	public String getAddress() {
		try {
			return getEntryString(InstrumentListed.address);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAddress(String address) {
		this.setEntry(InstrumentListed.address, address);
	}

	public String getLinkman() {
		try {
			return getEntryString(InstrumentListed.linkman);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLinkman(String linkman) {
		this.setEntry(InstrumentListed.linkman, linkman);
	}

	public String getPhone() {
		try {
			return getEntryString(InstrumentListed.phone);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPhone(String phone) {
		this.setEntry(InstrumentListed.phone, phone);
	}
}