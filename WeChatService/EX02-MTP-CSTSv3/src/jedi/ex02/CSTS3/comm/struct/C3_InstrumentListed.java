package jedi.ex02.CSTS3.comm.struct;

import ex.v01.exchange.comm.db.EX_InstrumentListed;

public class C3_InstrumentListed extends allone.json.AbstractJsonData {

	public static final String jsonId = "35";

	public static final String instrument = "1";
	public static final String benchmarkInstrument = "2";
	public static final String fundId = "3";
	public static final String listedType = "4";
	public static final String buySell = "5";
	public static final String listedVolume = "6";
	public static final String deliveryDays = "7";

	// 交收
	public static final String minDeliveryLot = "8"; // 最小交收单位
	public static final String sumDailyDeliveryLots = "9";// 每日交收总数量
	public static final String deliveryCommType = "10";// 交收佣金类型
	public static final String deliveryCommission = "11";// 交收佣金
	public static final String deliveryMarginType = "12";// 交收保证金类型
	public static final String deliveryMargin = "13";// 交收占用保证金
	public static final String deliveryWarehouseName = "14";// 仓库名称
	public static final String address = "15";// 地址
	public static final String linkman = "16";// 联系人
	public static final String phone = "17";// 电话

	public C3_InstrumentListed() {
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(EX_InstrumentListed data) throws Exception {
		setInstrument(data.getInstrument());
		setBenchmarkInstrument(data.getBenchmarkInstrument());
		setFundID(data.getFundId());
		setListedType(data.getListedType());
		setBuySell(data.getBuySell());
		setListedVolume(data.getListedVolume());
		setDeliveryDays(data.getDeliveryDays());
		setMinDeliveryLot(data.getMinDeliveryLot());
		setSumDailyDeliveryLots(data.getSumDailyDeliveryLots());
		setDeliveryCommType(data.getDeliveryCommType());
		setDeliveryCommission(data.getDeliveryCommission());
		setDeliveryMarginType(data.getDeliveryMarginType());
		setDeliveryMargin(data.getDeliveryMargin());
		setDeliveryWarehouseName(data.getDeliveryWarehouseName());
		setAddress(data.getAddress());
		setLinkman(data.getLinkman());
		setPhone(data.getPhone());
	}

	public EX_InstrumentListed format() {
		EX_InstrumentListed data = new EX_InstrumentListed();
		data.setInstrument(getInstrument());
		data.setBenchmarkInstrument(data.getBenchmarkInstrument());
		data.setFundId(getFundID());
		data.setListedType(getListedType());
		data.setBuySell(getBuySell());
		data.setListedVolume(getListedVolume());
		data.setDeliveryDays(getDeliveryDays());
		data.setMinDeliveryLot(getMinDeliveryLot());
		data.setSumDailyDeliveryLots(getSumDailyDeliveryLots());
		data.setDeliveryCommType(getDeliveryCommType());
		data.setDeliveryCommission(getDeliveryCommission());
		data.setDeliveryMarginType(getDeliveryMarginType());
		data.setDeliveryMargin(getDeliveryMargin());
		data.setDeliveryWarehouseName(getDeliveryWarehouseName());
		data.setAddress(getAddress());
		data.setLinkman(getLinkman());
		data.setPhone(getPhone());
		return data;
	}

	public String getInstrument() {
		try {
			String data = getEntryString(C3_InstrumentListed.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		this.setEntry(C3_InstrumentListed.instrument, instrument);
	}

	public String getBenchmarkInstrument() {
		try {
			String data = getEntryString(C3_InstrumentListed.benchmarkInstrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBenchmarkInstrument(String benchmarkInstrument) {
		this.setEntry(C3_InstrumentListed.benchmarkInstrument,
				benchmarkInstrument);
	}

	public int getFundID() {
		try {
			int data = getEntryInt(C3_InstrumentListed.fundId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundID(int fundID) {
		this.setEntry(C3_InstrumentListed.fundId, fundID);
	}

	public int getListedType() {
		try {
			int data = getEntryInt(C3_InstrumentListed.listedType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setListedType(int listedType) {
		this.setEntry(C3_InstrumentListed.listedType, listedType);
	}

	public int getBuySell() {
		try {
			int data = getEntryInt(C3_InstrumentListed.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		this.setEntry(C3_InstrumentListed.buySell, buySell);
	}

	public long getListedVolume() {
		try {
			return getEntryLong(C3_InstrumentListed.listedVolume);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setListedVolume(long listedVolume) {
		this.setEntry(C3_InstrumentListed.listedVolume, listedVolume);
	}

	public int getDeliveryDays() {
		try {
			int data = getEntryInt(C3_InstrumentListed.deliveryDays);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryDays(int deliveryDays) {
		this.setEntry(C3_InstrumentListed.deliveryDays, deliveryDays);
	}

	public double getMinDeliveryLot() {
		try {
			return getEntryDouble(C3_InstrumentListed.minDeliveryLot);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinDeliveryLot(double minDeliveryLot) {
		this.setEntry(C3_InstrumentListed.minDeliveryLot, minDeliveryLot);
	}

	public double getSumDailyDeliveryLots() {
		try {
			return getEntryDouble(C3_InstrumentListed.sumDailyDeliveryLots);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSumDailyDeliveryLots(double sumDailyDeliveryLots) {
		this.setEntry(C3_InstrumentListed.sumDailyDeliveryLots,
				sumDailyDeliveryLots);
	}

	public int getDeliveryCommType() {
		try {
			int data = getEntryInt(C3_InstrumentListed.deliveryCommType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryCommType(int deliveryCommType) {
		this.setEntry(C3_InstrumentListed.deliveryCommType, deliveryCommType);
	}

	public int getDeliveryMarginType() {
		try {
			int data = getEntryInt(C3_InstrumentListed.deliveryMarginType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryMarginType(int deliveryMarginType) {
		this.setEntry(C3_InstrumentListed.deliveryMarginType,
				deliveryMarginType);
	}

	public double getDeliveryCommission() {
		try {
			return getEntryDouble(C3_InstrumentListed.deliveryCommission);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryCommission(double deliveryCommission) {
		this.setEntry(C3_InstrumentListed.deliveryCommission,
				deliveryCommission);
	}

	public double getDeliveryMargin() {
		try {
			return getEntryDouble(C3_InstrumentListed.deliveryMargin);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDeliveryMargin(double deliveryMargin) {
		this.setEntry(C3_InstrumentListed.deliveryMargin, deliveryMargin);
	}

	public String getDeliveryWarehouseName() {
		try {
			return getEntryString(C3_InstrumentListed.deliveryWarehouseName);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDeliveryWarehouseName(String deliveryWarehouseName) {
		this.setEntry(C3_InstrumentListed.deliveryWarehouseName,
				deliveryWarehouseName);
	}

	public String getAddress() {
		try {
			return getEntryString(C3_InstrumentListed.address);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAddress(String address) {
		this.setEntry(C3_InstrumentListed.address, address);
	}

	public String getLinkman() {
		try {
			return getEntryString(C3_InstrumentListed.linkman);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLinkman(String linkman) {
		this.setEntry(C3_InstrumentListed.linkman, linkman);
	}

	public String getPhone() {
		try {
			return getEntryString(C3_InstrumentListed.phone);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPhone(String phone) {
		this.setEntry(C3_InstrumentListed.phone, phone);
	}
}