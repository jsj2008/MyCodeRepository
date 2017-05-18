package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.Instrument;
import jedi.v7.comm.datastruct.DB.InstrumentsAccountCfg;
import jedi.v7.comm.datastruct.DB.InstrumentsGroupCfg;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;

public class C3_Instrument extends allone.json.AbstractJsonData {

	public static final String jsonId = "7";

	public static final String instrument = "1";
	public static final String instrumentType = "2";
	public static final String subType = "3";
	public static final String merchandiseName = "4";
	public static final String currencyName = "5";
	public static final String isHot = "6";
	public static final String digits = "7";
	public static final String minLots = "8";
	public static final String maxLots = "9";
	public static final String amountPerLot = "10";
	public static final String sort = "11";
	public static final String spreads = "12";
	public static final String spike = "13";
	public static final String shade = "14";
	public static final String extraDigit = "15";
	public static final String validPriceGap4StopOrder = "16";
	public static final String gap2ActiveOrder = "17";
	public static final String safeGap4OpenOrder = "18";
	public static final String canUseGuaranteeStop = "19";
	public static final String guaranteeStopMinPriceGap = "20";
	public static final String guaranteeStopChargePoint = "21";
	public static final String moveStopMinGap = "22";
	public static final String commCaculateStyle = "23";
	public static final String canPreSell = "24";
	public static final String openCommision = "25";
	public static final String closeCommision = "26";
	public static final String minimumCommision4PerCalulate = "27";
	public static final String IBChargeTypeID = "28";
	public static final String openMarginPercentage = "29";
	public static final String marginCall1Percentage = "30";
	public static final String marginCall2Percentage = "31";
	public static final String liquidationMarginPercentage = "32";
	public static final String autoRates = "33";
	public static final String autoMkt = "34";
	public static final String autoLim = "35";
	public static final String autoStop = "36";
	public static final String mktTradeable = "37";
	public static final String tradeable = "38";
	public static final String orderScanWay = "39";
	public static final String notGuarantedStopOrderTradeStyle = "40";
	public static final String priceValidTimeGap = "41";
	public static final String isVisable = "42";
	public static final String IBChargedPoints = "43";
	public static final String expireDate = "44";
	public static final String foreceToUptrade = "45";
	public static final String uptradeBank = "46";
	public static final String isRolloverContainsHoliday = "48";
	public static final String valueDayDelay = "49";
	public static final String secType = "50";
	public static final String strike = "51";
	public static final String optionRight = "52";
	public static final String marketOpenTimeInterval = "53";
	public static final String isDead = "54";
	public static final String spreadType = "55";
	public static final String treeNodeName = "56";
	public static final String description = "57";
	public static final String marketOpenTimeType = "58";
	public static final String firstNoticeDate = "59";
	public static final String firstPositionDate = "60";
	public static final String lastTradingDate = "61";
	public static final String groupName = "62";
	public static final String group_minLots = "63";
	public static final String group_maxLots = "64";
	public static final String group_spread2Add = "65";
	public static final String group_openCommision2Add = "66";
	public static final String group_closeCommision2Add = "67";
	public static final String group_openMarginPercentage = "68";
	public static final String group_marginCall1Percentage = "69";
	public static final String group_marginCall2Percentage = "70";
	public static final String group_liquidationMarginPercentage = "71";
	public static final String group_autoMkt = "72";
	public static final String group_autoLim = "73";
	public static final String group_autoStop = "74";
	public static final String group_mktTradeable = "75";
	public static final String group_tradeable = "76";
	public static final String group_isVisable = "77";
	public static final String group_ibChargePoints = "78";
	public static final String account = "79";
	public static final String account_minLots = "80";
	public static final String account_maxLots = "81";
	public static final String account_spread2Add = "82";
	public static final String account_openCommision2Add = "83";
	public static final String account_closeCommision2Add = "84";
	public static final String account_openMarginPercentage = "85";
	public static final String account_marginCall1Percentage = "86";
	public static final String account_marginCall2Percentage = "87";
	public static final String account_liquidationMarginPercentage = "88";
	public static final String account_autoMkt = "89";
	public static final String account_autoLim = "90";
	public static final String account_autoStop = "91";
	public static final String account_mktTradeable = "92";
	public static final String account_tradeable = "93";
	public static final String account_isVisable = "94";
	public static final String account_ibChargePoints = "95";
	public static final String marginType = "96";

	public static final String interestAdjustBuy = "97";
	public static final String interestAdjustSell = "98";
	public static final String minUptradeLots = "99";
	public static final String interestType = "100";
	public static final String fixedInterestBuy = "101";
	public static final String fixedInterestSell = "102";
	public static final String fixInstrument = "103";
	public static final String fixAmountExpression = "104";
	public static final String fixAmountParams = "105";
	public static final String fixPriceExpression = "106";
	public static final String fixPriceParams = "107";
	public static final String unfixPriceExpression = "108";
	public static final String unfixPriceParams = "109";

	public static final String type = "110";

	public C3_Instrument() {
		super();
		setEntry("jsonId", jsonId);
		setGroup_minLots(MTP4CommDataInterface.DEFAULT);
		setGroup_maxLots(MTP4CommDataInterface.DEFAULT);
		setGroup_openMarginPercentage(MTP4CommDataInterface.DEFAULT);
		setGroup_marginCall1Percentage(MTP4CommDataInterface.DEFAULT);
		setGroup_marginCall2Percentage(MTP4CommDataInterface.DEFAULT);
		setGroup_liquidationMarginPercentage(MTP4CommDataInterface.DEFAULT);
		setGroup_autoMkt(MTP4CommDataInterface.TRUE);
		setGroup_autoLim(MTP4CommDataInterface.TRUE);
		setGroup_autoStop(MTP4CommDataInterface.TRUE);
		setGroup_mktTradeable(MTP4CommDataInterface.TRUE);
		setGroup_tradeable(MTP4CommDataInterface.TRUE);
		setGroup_isVisable(MTP4CommDataInterface.TRUE);
		setAccount_minLots(MTP4CommDataInterface.DEFAULT);
		setAccount_maxLots(MTP4CommDataInterface.DEFAULT);
		setAccount_openMarginPercentage(MTP4CommDataInterface.DEFAULT);
		setAccount_marginCall1Percentage(MTP4CommDataInterface.DEFAULT);
		setAccount_marginCall2Percentage(MTP4CommDataInterface.DEFAULT);
		setAccount_liquidationMarginPercentage(MTP4CommDataInterface.DEFAULT);
		setAccount_autoMkt(MTP4CommDataInterface.TRUE);
		setAccount_autoLim(MTP4CommDataInterface.TRUE);
		setAccount_autoStop(MTP4CommDataInterface.TRUE);
		setAccount_mktTradeable(MTP4CommDataInterface.TRUE);
		setAccount_tradeable(MTP4CommDataInterface.TRUE);
		setAccount_isVisable(MTP4CommDataInterface.TRUE);
	}

	public void parseFromSysData(InstrumentsGroupCfg data) throws Exception {
		setInstrument(data.getInstrument());
		setGroupName(data.getGroupName());
		setGroup_minLots(data.getMinLots());
		setGroup_maxLots(data.getMaxLots());
		setGroup_spread2Add(data.getSpread2Add());
		setGroup_openCommision2Add(data.getOpenCommision2Add());
		setGroup_closeCommision2Add(data.getCloseCommision2Add());
		setGroup_openMarginPercentage(data.getOpenMarginPercentage());
		setGroup_marginCall1Percentage(data.getMarginCall1Percentage());
		setGroup_marginCall2Percentage(data.getMarginCall2Percentage());
		setGroup_liquidationMarginPercentage(data
				.getLiquidationMarginPercentage());
		setGroup_autoMkt(data.getAutoMkt());
		setGroup_autoLim(data.getAutoLim());
		setGroup_autoStop(data.getAutoStop());
		setGroup_mktTradeable(data.getMktTradeable());
		setGroup_tradeable(data.getTradeable());
		setGroup_isVisable(data.getIsVisable());
		setGroup_ibChargePoints(data.getIbChargePoints());
	}

	public InstrumentsGroupCfg formatInstrumentsGroupCfg() {
		InstrumentsGroupCfg data = new InstrumentsGroupCfg();
		data.setGroupName(getGroupName());
		data.setMinLots(getGroup_minLots());
		data.setMaxLots(getGroup_maxLots());
		data.setSpread2Add(getGroup_spread2Add());
		data.setOpenCommision2Add(getGroup_openCommision2Add());
		data.setCloseCommision2Add(getGroup_closeCommision2Add());
		data.setOpenMarginPercentage(getGroup_openMarginPercentage());
		data.setMarginCall1Percentage(getGroup_marginCall1Percentage());
		data.setMarginCall2Percentage(getGroup_marginCall2Percentage());
		data.setLiquidationMarginPercentage(getGroup_liquidationMarginPercentage());
		data.setAutoMkt(getGroup_autoMkt());
		data.setAutoLim(getGroup_autoLim());
		data.setAutoStop(getGroup_autoStop());
		data.setMktTradeable(getGroup_mktTradeable());
		data.setTradeable(getGroup_tradeable());
		data.setIsVisable(getGroup_isVisable());
		data.setIbChargePoints(getGroup_ibChargePoints());
		return data;
	}

	public void parseFromSysData(InstrumentsAccountCfg data) throws Exception {
		setAccount(data.getAccount());
		setAccount_minLots(data.getMinLots());
		setAccount_maxLots(data.getMaxLots());
		setAccount_spread2Add(data.getSpread2Add());
		setAccount_openCommision2Add(data.getOpenCommision2Add());
		setAccount_closeCommision2Add(data.getCloseCommision2Add());
		setAccount_openMarginPercentage(data.getOpenMarginPercentage());
		setAccount_marginCall1Percentage(data.getMarginCall1Percentage());
		setAccount_marginCall2Percentage(data.getMarginCall2Percentage());
		setAccount_liquidationMarginPercentage(data
				.getLiquidationMarginPercentage());
		setAccount_autoMkt(data.getAutoMkt());
		setAccount_autoLim(data.getAutoLim());
		setAccount_autoStop(data.getAutoStop());
		setAccount_mktTradeable(data.getMktTradeable());
		setAccount_tradeable(data.getTradeable());
		setAccount_isVisable(data.getIsVisable());
		setAccount_ibChargePoints(data.getIbChargePoints());
	}

	public InstrumentsAccountCfg formatInstrumentsAccountCfg() {
		InstrumentsAccountCfg data = new InstrumentsAccountCfg();
		data.setAccount(getAccount());
		data.setMinLots(getAccount_minLots());
		data.setMaxLots(getAccount_maxLots());
		data.setSpread2Add(getAccount_spread2Add());
		data.setOpenCommision2Add(getAccount_openCommision2Add());
		data.setCloseCommision2Add(getAccount_closeCommision2Add());
		data.setOpenMarginPercentage(getAccount_openMarginPercentage());
		data.setMarginCall1Percentage(getAccount_marginCall1Percentage());
		data.setMarginCall2Percentage(getAccount_marginCall2Percentage());
		data.setLiquidationMarginPercentage(getAccount_liquidationMarginPercentage());
		data.setAutoMkt(getAccount_autoMkt());
		data.setAutoLim(getAccount_autoLim());
		data.setAutoStop(getAccount_autoStop());
		data.setMktTradeable(getAccount_mktTradeable());
		data.setTradeable(getAccount_tradeable());
		data.setIsVisable(getAccount_isVisable());
		data.setIbChargePoints(getAccount_ibChargePoints());
		return data;
	}

	public void parseFromSysData(Instrument data) throws Exception {
		setInstrument(data.getInstrument());
		setInstrumentType(data.getInstrumentType());
		setSubType(data.getSubType());
		setMerchandiseName(data.getMerchandiseName());
		setCurrencyName(data.getCurrencyName());
		setIsHot(data.getIsHot());
		setDigits(data.getDigits());
		setMinLots(data.getMinLots());
		setMaxLots(data.getMaxLots());
		setAmountPerLot(data.getAmountPerLot());
		setSort(data.getSort());
		setSpreads(data.getSpreads());

		setSort(data.getSort());
		setSpreads(data.getSpreads());

		setSpike(data.getSpike());
		setShade(data.getShade());
		setExtraDigit(data.getExtraDigit());
		setValidPriceGap4StopOrder(data.getValidPriceGap4StopOrder());
		setGap2ActiveOrder(data.getGap2ActiveOrder());
		setSafeGap4OpenOrder(data.getSafeGap4OpenOrder());
		setCanUseGuaranteeStop(data.getCanUseGuaranteeStop());
		setGuaranteeStopMinPriceGap(data.getGuaranteeStopMinPriceGap());
		setGuaranteeStopChargePoint(data.getGuaranteeStopChargePoint());
		setMoveStopMinGap(data.getMoveStopMinGap());
		setCommCaculateStyle(data.getCommCaculateStyle());
		setCanPreSell(data.getCanPreSell());
		setOpenCommision(data.getOpenCommision());
		setCloseCommision(data.getCloseCommision());
		setMinimumCommision4PerCalulate(data.getMinimumCommision4PerCalulate());
		setIBChargeTypeID(data.getIBChargeTypeID());
		setOpenMarginPercentage(data.getOpenMarginPercentage());
		setMarginCall1Percentage(data.getMarginCall1Percentage());
		setMarginCall2Percentage(data.getMarginCall2Percentage());
		setLiquidationMarginPercentage(data.getLiquidationMarginPercentage());
		setAutoRates(data.getAutoRates());
		setAutoMkt(data.getAutoMkt());
		setAutoLim(data.getAutoLim());
		setAutoStop(data.getAutoStop());
		setMktTradeable(data.getMktTradeable());
		setTradeable(data.getTradeable());
		setOrderScanWay(data.getOrderScanWay());
		setNotGuarantedStopOrderTradeStyle(data
				.getNotGuarantedStopOrderTradeStyle());
		setPriceValidTimeGap(data.getPriceValidTimeGap());
		setIsVisable(data.getIsVisable());
		setIBChargedPoints(data.getIBChargedPoints());
		setExpireDate(data.getExpireDate());
		setForeceToUptrade(data.getForeceToUptrade());
		setUptradeBank(data.getUptradeBank());
		setIsRolloverContainsHoliday(data.getIsRolloverContainsHoliday());
		setValueDayDelay(data.getValueDayDelay());
		setSecType(data.getSecType());
		setStrike(data.getStrike());
		setOptionRight(data.getOptionRight());
		setMarketOpenTimeInterval(data.getMarketOpenTimeInterval());
		setIsDead(data.getIsDead());
		setSpreadType(data.getSpreadType());
		setTreeNodeName(data.getTreeNodeName());
		setDescription(data.getDescription());
		setMarketOpenTimeType(data.getMarketOpenTimeType());
		setFirstNoticeDate(data.getFirstNoticeDate());
		setFirstPositionDate(data.getFirstPositionDate());
		setLastTradingDate(data.getLastTradingDate());
		setMarginType(data.getMarginType());

		setInterestAdjustBuy(data.getInterestAdjustBuy());
		setInterestAdjustSell(data.getInterestAdjustSell());
		setMinUptradeLots(data.getMinUptradeLots());
		setInterestType(data.getInterestType());
		setFixedInterestBuy(data.getFixedInterestBuy());
		setFixedInterestSell(data.getFixedInterestSell());
		setFixInstrument(data.getFixInstrument());
		setFixAmountExpression(data.getFixAmountExpression());
		setFixAmountParams(data.getFixAmountParams());
		setFixPriceExpression(data.getFixPriceExpression());
		setFixPriceParams(data.getFixPriceParams());
		setUnfixPriceExpression(data.getUnfixPriceExpression());
		setUnfixPriceParams(data.getUnfixPriceParams());

		setType(data.getType());

	}

	public Instrument format() {
		Instrument data = new Instrument();
		data.setInstrument(getInstrument());
		data.setInstrumentType(getInstrumentType());
		data.setSubType(getSubType());
		data.setMerchandiseName(getMerchandiseName());
		data.setCurrencyName(getCurrencyName());
		data.setIsHot(getIsHot());
		data.setDigits(getDigits());
		data.setMinLots(getMinLots());
		data.setMaxLots(getMaxLots());
		data.setAmountPerLot(getAmountPerLot());
		data.setSort(getSort());
		data.setSpreads(getSpreads());
		data.setSpike(getSpike());
		data.setShade(getShade());
		data.setExtraDigit(getExtraDigit());
		data.setValidPriceGap4StopOrder(getValidPriceGap4StopOrder());
		data.setGap2ActiveOrder(getGap2ActiveOrder());
		data.setSafeGap4OpenOrder(getSafeGap4OpenOrder());
		data.setCanUseGuaranteeStop(getCanUseGuaranteeStop());
		data.setGuaranteeStopMinPriceGap(getGuaranteeStopMinPriceGap());
		data.setGuaranteeStopChargePoint(getGuaranteeStopChargePoint());
		data.setMoveStopMinGap(getMoveStopMinGap());
		data.setCommCaculateStyle(getCommCaculateStyle());
		data.setCanPreSell(getCanPreSell());
		data.setOpenCommision(getOpenCommision());
		data.setCloseCommision(getCloseCommision());
		data.setMinimumCommision4PerCalulate(getMinimumCommision4PerCalulate());
		data.setIBChargeTypeID(getIBChargeTypeID());
		data.setOpenMarginPercentage(getOpenMarginPercentage());
		data.setMarginCall1Percentage(getMarginCall1Percentage());
		data.setMarginCall2Percentage(getMarginCall2Percentage());
		data.setLiquidationMarginPercentage(getLiquidationMarginPercentage());
		data.setAutoRates(getAutoRates());
		data.setAutoMkt(getAutoMkt());
		data.setAutoLim(getAutoLim());
		data.setAutoStop(getAutoStop());
		data.setMktTradeable(getMktTradeable());
		data.setTradeable(getTradeable());
		data.setOrderScanWay(getOrderScanWay());
		data.setNotGuarantedStopOrderTradeStyle(getNotGuarantedStopOrderTradeStyle());
		data.setPriceValidTimeGap(getPriceValidTimeGap());
		data.setIsVisable(getIsVisable());
		data.setIBChargedPoints(getIBChargedPoints());
		data.setExpireDate(getExpireDate());
		data.setForeceToUptrade(getForeceToUptrade());
		data.setUptradeBank(getUptradeBank());
		data.setIsRolloverContainsHoliday(getIsRolloverContainsHoliday());
		data.setValueDayDelay(getValueDayDelay());
		data.setSecType(getSecType());
		data.setStrike(getStrike());
		data.setOptionRight(getOptionRight());
		data.setMarketOpenTimeInterval(getMarketOpenTimeInterval());
		data.setIsDead(getIsDead());
		data.setSpreadType(getSpreadType());
		data.setTreeNodeName(getTreeNodeName());
		data.setDescription(getDescription());
		data.setMarketOpenTimeType(getMarketOpenTimeType());
		data.setFirstNoticeDate(getFirstNoticeDate());
		data.setFirstPositionDate(getFirstPositionDate());
		data.setLastTradingDate(getLastTradingDate());
		data.setMarginType(getMarginType());

		data.setType(getType());
		return data;
	}

	public String getInstrument() {
		try {
			String data = getEntryString(C3_Instrument.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_Instrument.instrument, instrument);
	}

	public String getInstrumentType() {
		try {
			String data = getEntryString(C3_Instrument.instrumentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentType(String instrumentType) {
		setEntry(C3_Instrument.instrumentType, instrumentType);
	}

	public String getSubType() {
		try {
			String data = getEntryString(C3_Instrument.subType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSubType(String subType) {
		setEntry(C3_Instrument.subType, subType);
	}

	public String getMerchandiseName() {
		try {
			String data = getEntryString(C3_Instrument.merchandiseName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMerchandiseName(String merchandiseName) {
		setEntry(C3_Instrument.merchandiseName, merchandiseName);
	}

	public String getCurrencyName() {
		try {
			String data = getEntryString(C3_Instrument.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(C3_Instrument.currencyName, currencyName);
	}

	public int getIsHot() {
		try {
			int data = getEntryInt(C3_Instrument.isHot);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsHot(int isHot) {
		setEntry(C3_Instrument.isHot, isHot);
	}

	public int getDigits() {
		try {
			int data = getEntryInt(C3_Instrument.digits);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDigits(int digits) {
		setEntry(C3_Instrument.digits, digits);
	}

	public double getMinLots() {
		try {
			double data = getEntryDouble(C3_Instrument.minLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinLots(double minLots) {
		setEntry(C3_Instrument.minLots, minLots);
	}

	public int getMaxLots() {
		try {
			int data = getEntryInt(C3_Instrument.maxLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxLots(int maxLots) {
		setEntry(C3_Instrument.maxLots, maxLots);
	}

	public int getAmountPerLot() {
		try {
			int data = getEntryInt(C3_Instrument.amountPerLot);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmountPerLot(int amountPerLot) {
		setEntry(C3_Instrument.amountPerLot, amountPerLot);
	}

	public int getSort() {
		try {
			int data = getEntryInt(C3_Instrument.sort);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSort(int sort) {
		setEntry(C3_Instrument.sort, sort);
	}

	public double getSpreads() {
		try {
			double data = getEntryDouble(C3_Instrument.spreads);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSpreads(double spreads) {
		setEntry(C3_Instrument.spreads, spreads);
	}

	public int getSpike() {
		try {
			int data = getEntryInt(C3_Instrument.spike);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSpike(int spike) {
		setEntry(C3_Instrument.spike, spike);
	}

	public int getShade() {
		try {
			int data = getEntryInt(C3_Instrument.shade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setShade(int shade) {
		setEntry(C3_Instrument.shade, shade);
	}

	public int getExtraDigit() {
		try {
			int data = getEntryInt(C3_Instrument.extraDigit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setExtraDigit(int extraDigit) {
		setEntry(C3_Instrument.extraDigit, extraDigit);
	}

	public int getValidPriceGap4StopOrder() {
		try {
			int data = getEntryInt(C3_Instrument.validPriceGap4StopOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setValidPriceGap4StopOrder(int validPriceGap4StopOrder) {
		setEntry(C3_Instrument.validPriceGap4StopOrder, validPriceGap4StopOrder);
	}

	public int getGap2ActiveOrder() {
		try {
			int data = getEntryInt(C3_Instrument.gap2ActiveOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGap2ActiveOrder(int gap2ActiveOrder) {
		setEntry(C3_Instrument.gap2ActiveOrder, gap2ActiveOrder);
	}

	public int getSafeGap4OpenOrder() {
		try {
			int data = getEntryInt(C3_Instrument.safeGap4OpenOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSafeGap4OpenOrder(int safeGap4OpenOrder) {
		setEntry(C3_Instrument.safeGap4OpenOrder, safeGap4OpenOrder);
	}

	public int getCanUseGuaranteeStop() {
		try {
			int data = getEntryInt(C3_Instrument.canUseGuaranteeStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanUseGuaranteeStop(int canUseGuaranteeStop) {
		setEntry(C3_Instrument.canUseGuaranteeStop, canUseGuaranteeStop);
	}

	public int getGuaranteeStopMinPriceGap() {
		try {
			int data = getEntryInt(C3_Instrument.guaranteeStopMinPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopMinPriceGap(int guaranteeStopMinPriceGap) {
		setEntry(C3_Instrument.guaranteeStopMinPriceGap,
				guaranteeStopMinPriceGap);
	}

	public int getGuaranteeStopChargePoint() {
		try {
			int data = getEntryInt(C3_Instrument.guaranteeStopChargePoint);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopChargePoint(int guaranteeStopChargePoint) {
		setEntry(C3_Instrument.guaranteeStopChargePoint,
				guaranteeStopChargePoint);
	}

	public int getMoveStopMinGap() {
		try {
			int data = getEntryInt(C3_Instrument.moveStopMinGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMoveStopMinGap(int moveStopMinGap) {
		setEntry(C3_Instrument.moveStopMinGap, moveStopMinGap);
	}

	public int getCommCaculateStyle() {
		try {
			int data = getEntryInt(C3_Instrument.commCaculateStyle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommCaculateStyle(int commCaculateStyle) {
		setEntry(C3_Instrument.commCaculateStyle, commCaculateStyle);
	}

	public int getCanPreSell() {
		try {
			int data = getEntryInt(C3_Instrument.canPreSell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanPreSell(int canPreSell) {
		setEntry(C3_Instrument.canPreSell, canPreSell);
	}

	public double getOpenCommision() {
		try {
			double data = getEntryDouble(C3_Instrument.openCommision);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenCommision(double openCommision) {
		setEntry(C3_Instrument.openCommision, openCommision);
	}

	public double getCloseCommision() {
		try {
			double data = getEntryDouble(C3_Instrument.closeCommision);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseCommision(double closeCommision) {
		setEntry(C3_Instrument.closeCommision, closeCommision);
	}

	public double getMinimumCommision4PerCalulate() {
		try {
			double data = getEntryDouble(C3_Instrument.minimumCommision4PerCalulate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinimumCommision4PerCalulate(
			double minimumCommision4PerCalulate) {
		setEntry(C3_Instrument.minimumCommision4PerCalulate,
				minimumCommision4PerCalulate);
	}

	public String getIBChargeTypeID() {
		try {
			String data = getEntryString(C3_Instrument.IBChargeTypeID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIBChargeTypeID(String IBChargeTypeID) {
		setEntry(C3_Instrument.IBChargeTypeID, IBChargeTypeID);
	}

	public double getOpenMarginPercentage() {
		try {
			double data = getEntryDouble(C3_Instrument.openMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenMarginPercentage(double openMarginPercentage) {
		setEntry(C3_Instrument.openMarginPercentage, openMarginPercentage);
	}

	public double getMarginCall1Percentage() {
		try {
			double data = getEntryDouble(C3_Instrument.marginCall1Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCall1Percentage(double marginCall1Percentage) {
		setEntry(C3_Instrument.marginCall1Percentage, marginCall1Percentage);
	}

	public double getMarginCall2Percentage() {
		try {
			double data = getEntryDouble(C3_Instrument.marginCall2Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCall2Percentage(double marginCall2Percentage) {
		setEntry(C3_Instrument.marginCall2Percentage, marginCall2Percentage);
	}

	public double getLiquidationMarginPercentage() {
		try {
			double data = getEntryDouble(C3_Instrument.liquidationMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLiquidationMarginPercentage(
			double liquidationMarginPercentage) {
		setEntry(C3_Instrument.liquidationMarginPercentage,
				liquidationMarginPercentage);
	}

	public int getAutoRates() {
		try {
			int data = getEntryInt(C3_Instrument.autoRates);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoRates(int autoRates) {
		setEntry(C3_Instrument.autoRates, autoRates);
	}

	public int getAutoMkt() {
		try {
			int data = getEntryInt(C3_Instrument.autoMkt);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoMkt(int autoMkt) {
		setEntry(C3_Instrument.autoMkt, autoMkt);
	}

	public int getAutoLim() {
		try {
			int data = getEntryInt(C3_Instrument.autoLim);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoLim(int autoLim) {
		setEntry(C3_Instrument.autoLim, autoLim);
	}

	public int getAutoStop() {
		try {
			int data = getEntryInt(C3_Instrument.autoStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoStop(int autoStop) {
		setEntry(C3_Instrument.autoStop, autoStop);
	}

	public int getMktTradeable() {
		try {
			int data = getEntryInt(C3_Instrument.mktTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMktTradeable(int mktTradeable) {
		setEntry(C3_Instrument.mktTradeable, mktTradeable);
	}

	public int getTradeable() {
		try {
			int data = getEntryInt(C3_Instrument.tradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradeable(int tradeable) {
		setEntry(C3_Instrument.tradeable, tradeable);
	}

	public int getOrderScanWay() {
		try {
			int data = getEntryInt(C3_Instrument.orderScanWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderScanWay(int orderScanWay) {
		setEntry(C3_Instrument.orderScanWay, orderScanWay);
	}

	public int getNotGuarantedStopOrderTradeStyle() {
		try {
			int data = getEntryInt(C3_Instrument.notGuarantedStopOrderTradeStyle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setNotGuarantedStopOrderTradeStyle(
			int notGuarantedStopOrderTradeStyle) {
		setEntry(C3_Instrument.notGuarantedStopOrderTradeStyle,
				notGuarantedStopOrderTradeStyle);
	}

	public int getPriceValidTimeGap() {
		try {
			int data = getEntryInt(C3_Instrument.priceValidTimeGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceValidTimeGap(int priceValidTimeGap) {
		setEntry(C3_Instrument.priceValidTimeGap, priceValidTimeGap);
	}

	public int getIsVisable() {
		try {
			int data = getEntryInt(C3_Instrument.isVisable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsVisable(int isVisable) {
		setEntry(C3_Instrument.isVisable, isVisable);
	}

	public double getIBChargedPoints() {
		try {
			double data = getEntryDouble(C3_Instrument.IBChargedPoints);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBChargedPoints(double IBChargedPoints) {
		setEntry(C3_Instrument.IBChargedPoints, IBChargedPoints);
	}

	public String getExpireDate() {
		try {
			String data = getEntryString(C3_Instrument.expireDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireDate(String expireDate) {
		setEntry(C3_Instrument.expireDate, expireDate);
	}

	public int getForeceToUptrade() {
		try {
			int data = getEntryInt(C3_Instrument.foreceToUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setForeceToUptrade(int foreceToUptrade) {
		setEntry(C3_Instrument.foreceToUptrade, foreceToUptrade);
	}

	public String getUptradeBank() {
		try {
			String data = getEntryString(C3_Instrument.uptradeBank);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUptradeBank(String uptradeBank) {
		setEntry(C3_Instrument.uptradeBank, uptradeBank);
	}

	public int getIsRolloverContainsHoliday() {
		try {
			int data = getEntryInt(C3_Instrument.isRolloverContainsHoliday);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsRolloverContainsHoliday(int isRolloverContainsHoliday) {
		setEntry(C3_Instrument.isRolloverContainsHoliday,
				isRolloverContainsHoliday);
	}

	public int getValueDayDelay() {
		try {
			int data = getEntryInt(C3_Instrument.valueDayDelay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setValueDayDelay(int valueDayDelay) {
		setEntry(C3_Instrument.valueDayDelay, valueDayDelay);
	}

	public String getSecType() {
		try {
			String data = getEntryString(C3_Instrument.secType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSecType(String secType) {
		setEntry(C3_Instrument.secType, secType);
	}

	public String getStrike() {
		try {
			String data = getEntryString(C3_Instrument.strike);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStrike(String strike) {
		setEntry(C3_Instrument.strike, strike);
	}

	public String getOptionRight() {
		try {
			String data = getEntryString(C3_Instrument.optionRight);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOptionRight(String optionRight) {
		setEntry(C3_Instrument.optionRight, optionRight);
	}

	public String getMarketOpenTimeInterval() {
		try {
			String data = getEntryString(C3_Instrument.marketOpenTimeInterval);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMarketOpenTimeInterval(String marketOpenTimeInterval) {
		setEntry(C3_Instrument.marketOpenTimeInterval, marketOpenTimeInterval);
	}

	public int getIsDead() {
		try {
			int data = getEntryInt(C3_Instrument.isDead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsDead(int isDead) {
		setEntry(C3_Instrument.isDead, isDead);
	}

	public int getSpreadType() {
		try {
			int data = getEntryInt(C3_Instrument.spreadType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSpreadType(int spreadType) {
		setEntry(C3_Instrument.spreadType, spreadType);
	}

	public String getTreeNodeName() {
		try {
			String data = getEntryString(C3_Instrument.treeNodeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTreeNodeName(String treeNodeName) {
		setEntry(C3_Instrument.treeNodeName, treeNodeName);
	}

	public String getDescription() {
		try {
			String data = getEntryString(C3_Instrument.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_Instrument.description, description);
	}

	public String getMarketOpenTimeType() {
		try {
			String data = getEntryString(C3_Instrument.marketOpenTimeType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMarketOpenTimeType(String marketOpenTimeType) {
		setEntry(C3_Instrument.marketOpenTimeType, marketOpenTimeType);
	}

	public String getFirstNoticeDate() {
		try {
			String data = getEntryString(C3_Instrument.firstNoticeDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstNoticeDate(String firstNoticeDate) {
		setEntry(C3_Instrument.firstNoticeDate, firstNoticeDate);
	}

	public String getFirstPositionDate() {
		try {
			String data = getEntryString(C3_Instrument.firstPositionDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstPositionDate(String firstPositionDate) {
		setEntry(C3_Instrument.firstPositionDate, firstPositionDate);
	}

	public String getLastTradingDate() {
		try {
			String data = getEntryString(C3_Instrument.lastTradingDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastTradingDate(String lastTradingDate) {
		setEntry(C3_Instrument.lastTradingDate, lastTradingDate);
	}

	public String getGroupName() {
		try {
			String data = getEntryString(C3_Instrument.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_Instrument.groupName, groupName);
	}

	public double getGroup_minLots() {
		try {
			double data = getEntryDouble(C3_Instrument.group_minLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_minLots(double group_minLots) {
		setEntry(C3_Instrument.group_minLots, group_minLots);
	}

	public int getGroup_maxLots() {
		try {
			int data = getEntryInt(C3_Instrument.group_maxLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_maxLots(int group_maxLots) {
		setEntry(C3_Instrument.group_maxLots, group_maxLots);
	}

	public double getGroup_spread2Add() {
		try {
			double data = getEntryDouble(C3_Instrument.group_spread2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_spread2Add(double group_spread2Add) {
		setEntry(C3_Instrument.group_spread2Add, group_spread2Add);
	}

	public double getGroup_openCommision2Add() {
		try {
			double data = getEntryDouble(C3_Instrument.group_openCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_openCommision2Add(double group_openCommision2Add) {
		setEntry(C3_Instrument.group_openCommision2Add, group_openCommision2Add);
	}

	public double getGroup_closeCommision2Add() {
		try {
			double data = getEntryDouble(C3_Instrument.group_closeCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_closeCommision2Add(double group_closeCommision2Add) {
		setEntry(C3_Instrument.group_closeCommision2Add,
				group_closeCommision2Add);
	}

	public double getGroup_openMarginPercentage() {
		try {
			double data = getEntryDouble(C3_Instrument.group_openMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_openMarginPercentage(double group_openMarginPercentage) {
		setEntry(C3_Instrument.group_openMarginPercentage,
				group_openMarginPercentage);
	}

	public double getGroup_marginCall1Percentage() {
		try {
			double data = getEntryDouble(C3_Instrument.group_marginCall1Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_marginCall1Percentage(
			double group_marginCall1Percentage) {
		setEntry(C3_Instrument.group_marginCall1Percentage,
				group_marginCall1Percentage);
	}

	public double getGroup_marginCall2Percentage() {
		try {
			double data = getEntryDouble(C3_Instrument.group_marginCall2Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_marginCall2Percentage(
			double group_marginCall2Percentage) {
		setEntry(C3_Instrument.group_marginCall2Percentage,
				group_marginCall2Percentage);
	}

	public double getGroup_liquidationMarginPercentage() {
		try {
			double data = getEntryDouble(C3_Instrument.group_liquidationMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_liquidationMarginPercentage(
			double group_liquidationMarginPercentage) {
		setEntry(C3_Instrument.group_liquidationMarginPercentage,
				group_liquidationMarginPercentage);
	}

	public int getGroup_autoMkt() {
		try {
			int data = getEntryInt(C3_Instrument.group_autoMkt);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_autoMkt(int group_autoMkt) {
		setEntry(C3_Instrument.group_autoMkt, group_autoMkt);
	}

	public int getGroup_autoLim() {
		try {
			int data = getEntryInt(C3_Instrument.group_autoLim);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_autoLim(int group_autoLim) {
		setEntry(C3_Instrument.group_autoLim, group_autoLim);
	}

	public int getGroup_autoStop() {
		try {
			int data = getEntryInt(C3_Instrument.group_autoStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_autoStop(int group_autoStop) {
		setEntry(C3_Instrument.group_autoStop, group_autoStop);
	}

	public int getGroup_mktTradeable() {
		try {
			int data = getEntryInt(C3_Instrument.group_mktTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_mktTradeable(int group_mktTradeable) {
		setEntry(C3_Instrument.group_mktTradeable, group_mktTradeable);
	}

	public int getGroup_tradeable() {
		try {
			int data = getEntryInt(C3_Instrument.group_tradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_tradeable(int group_tradeable) {
		setEntry(C3_Instrument.group_tradeable, group_tradeable);
	}

	public int getGroup_isVisable() {
		try {
			int data = getEntryInt(C3_Instrument.group_isVisable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_isVisable(int group_isVisable) {
		setEntry(C3_Instrument.group_isVisable, group_isVisable);
	}

	public double getGroup_ibChargePoints() {
		try {
			double data = getEntryDouble(C3_Instrument.group_ibChargePoints);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_ibChargePoints(double group_ibChargePoints) {
		setEntry(C3_Instrument.group_ibChargePoints, group_ibChargePoints);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_Instrument.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_Instrument.account, account);
	}

	public double getAccount_minLots() {
		try {
			double data = getEntryDouble(C3_Instrument.account_minLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_minLots(double account_minLots) {
		setEntry(C3_Instrument.account_minLots, account_minLots);
	}

	public int getAccount_maxLots() {
		try {
			int data = getEntryInt(C3_Instrument.account_maxLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_maxLots(int account_maxLots) {
		setEntry(C3_Instrument.account_maxLots, account_maxLots);
	}

	public double getAccount_spread2Add() {
		try {
			double data = getEntryDouble(C3_Instrument.account_spread2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_spread2Add(double account_spread2Add) {
		setEntry(C3_Instrument.account_spread2Add, account_spread2Add);
	}

	public double getAccount_openCommision2Add() {
		try {
			double data = getEntryDouble(C3_Instrument.account_openCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_openCommision2Add(double account_openCommision2Add) {
		setEntry(C3_Instrument.account_openCommision2Add,
				account_openCommision2Add);
	}

	public double getAccount_closeCommision2Add() {
		try {
			double data = getEntryDouble(C3_Instrument.account_closeCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_closeCommision2Add(double account_closeCommision2Add) {
		setEntry(C3_Instrument.account_closeCommision2Add,
				account_closeCommision2Add);
	}

	public double getAccount_openMarginPercentage() {
		try {
			double data = getEntryDouble(C3_Instrument.account_openMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_openMarginPercentage(
			double account_openMarginPercentage) {
		setEntry(C3_Instrument.account_openMarginPercentage,
				account_openMarginPercentage);
	}

	public double getAccount_marginCall1Percentage() {
		try {
			double data = getEntryDouble(C3_Instrument.account_marginCall1Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_marginCall1Percentage(
			double account_marginCall1Percentage) {
		setEntry(C3_Instrument.account_marginCall1Percentage,
				account_marginCall1Percentage);
	}

	public double getAccount_marginCall2Percentage() {
		try {
			double data = getEntryDouble(C3_Instrument.account_marginCall2Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_marginCall2Percentage(
			double account_marginCall2Percentage) {
		setEntry(C3_Instrument.account_marginCall2Percentage,
				account_marginCall2Percentage);
	}

	public double getAccount_liquidationMarginPercentage() {
		try {
			double data = getEntryDouble(C3_Instrument.account_liquidationMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_liquidationMarginPercentage(
			double account_liquidationMarginPercentage) {
		setEntry(C3_Instrument.account_liquidationMarginPercentage,
				account_liquidationMarginPercentage);
	}

	public int getAccount_autoMkt() {
		try {
			int data = getEntryInt(C3_Instrument.account_autoMkt);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_autoMkt(int account_autoMkt) {
		setEntry(C3_Instrument.account_autoMkt, account_autoMkt);
	}

	public int getAccount_autoLim() {
		try {
			int data = getEntryInt(C3_Instrument.account_autoLim);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_autoLim(int account_autoLim) {
		setEntry(C3_Instrument.account_autoLim, account_autoLim);
	}

	public int getAccount_autoStop() {
		try {
			int data = getEntryInt(C3_Instrument.account_autoStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_autoStop(int account_autoStop) {
		setEntry(C3_Instrument.account_autoStop, account_autoStop);
	}

	public int getAccount_mktTradeable() {
		try {
			int data = getEntryInt(C3_Instrument.account_mktTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_mktTradeable(int account_mktTradeable) {
		setEntry(C3_Instrument.account_mktTradeable, account_mktTradeable);
	}

	public int getAccount_tradeable() {
		try {
			int data = getEntryInt(C3_Instrument.account_tradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_tradeable(int account_tradeable) {
		setEntry(C3_Instrument.account_tradeable, account_tradeable);
	}

	public int getAccount_isVisable() {
		try {
			int data = getEntryInt(C3_Instrument.account_isVisable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_isVisable(int account_isVisable) {
		setEntry(C3_Instrument.account_isVisable, account_isVisable);
	}

	public double getAccount_ibChargePoints() {
		try {
			double data = getEntryDouble(C3_Instrument.account_ibChargePoints);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_ibChargePoints(double account_ibChargePoints) {
		setEntry(C3_Instrument.account_ibChargePoints, account_ibChargePoints);
	}

	public int getMarginType() {
		try {
			int data = getEntryInt(C3_Instrument.marginType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginType(int marginType) {
		setEntry(C3_Instrument.marginType, marginType);
	}

	public double getInterestAdjustBuy() {
		try {
			double data = getEntryDouble(C3_Instrument.interestAdjustBuy);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestAdjustBuy(double interestAdjustBuy) {
		setEntry(C3_Instrument.interestAdjustBuy, interestAdjustBuy);
	}

	public double getInterestAdjustSell() {
		try {
			double data = getEntryDouble(C3_Instrument.interestAdjustSell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestAdjustSell(double interestAdjustSell) {
		setEntry(C3_Instrument.interestAdjustSell, interestAdjustSell);
	}

	public double getMinUptradeLots() {
		try {
			double data = getEntryDouble(C3_Instrument.minUptradeLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinUptradeLots(double minUptradeLots) {
		setEntry(C3_Instrument.minUptradeLots, minUptradeLots);
	}

	public int getInterestType() {
		try {
			int data = getEntryInt(C3_Instrument.interestType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestType(int interestType) {
		setEntry(C3_Instrument.interestType, interestType);
	}

	public double getFixedInterestBuy() {
		try {
			double data = getEntryDouble(C3_Instrument.fixedInterestBuy);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFixedInterestBuy(double fixedInterestBuy) {
		setEntry(C3_Instrument.fixedInterestBuy, fixedInterestBuy);
	}

	public double getFixedInterestSell() {
		try {
			double data = getEntryDouble(C3_Instrument.fixedInterestSell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFixedInterestSell(double fixedInterestSell) {
		setEntry(C3_Instrument.fixedInterestSell, fixedInterestSell);
	}

	public String getFixInstrument() {
		try {
			String data = getEntryString(C3_Instrument.fixInstrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixInstrument(String fixInstrument) {
		setEntry(C3_Instrument.fixInstrument, fixInstrument);
	}

	public String getFixAmountExpression() {
		try {
			String data = getEntryString(C3_Instrument.fixAmountExpression);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixAmountExpression(String fixAmountExpression) {
		setEntry(C3_Instrument.fixAmountExpression, fixAmountExpression);
	}

	public String getFixAmountParams() {
		try {
			String data = getEntryString(C3_Instrument.fixAmountParams);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixAmountParams(String fixAmountParams) {
		setEntry(C3_Instrument.fixAmountParams, fixAmountParams);
	}

	public String getFixPriceExpression() {
		try {
			String data = getEntryString(C3_Instrument.fixPriceExpression);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixPriceExpression(String fixPriceExpression) {
		setEntry(C3_Instrument.fixPriceExpression, fixPriceExpression);
	}

	public String getFixPriceParams() {
		try {
			String data = getEntryString(C3_Instrument.fixPriceParams);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixPriceParams(String fixPriceParams) {
		setEntry(C3_Instrument.fixPriceParams, fixPriceParams);
	}

	public String getUnfixPriceExpression() {
		try {
			String data = getEntryString(C3_Instrument.unfixPriceExpression);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUnfixPriceExpression(String unfixPriceExpression) {
		setEntry(C3_Instrument.unfixPriceExpression, unfixPriceExpression);
	}

	public String getUnfixPriceParams() {
		try {
			String data = getEntryString(C3_Instrument.unfixPriceParams);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUnfixPriceParams(String unfixPriceParams) {
		setEntry(C3_Instrument.unfixPriceParams, unfixPriceParams);
	}

	public int getType() {
		try {
			return getEntryInt(C3_Instrument.type);
		} catch (Exception e) {
			return 0;
		}
	}

	public void setType(int type) {
		this.setEntry(C3_Instrument.type, type);
	}

}