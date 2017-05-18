package jedi.ex01.CSTS3.comm.struct;


public class Instrument extends allone.json.AbstractJsonData {

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

	public Instrument(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(Instrument.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(Instrument.instrument, instrument);
	}

	public String getInstrumentType() {
		try {
			String data=getEntryString(Instrument.instrumentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentType(String instrumentType) {
		setEntry(Instrument.instrumentType, instrumentType);
	}

	public String getSubType() {
		try {
			String data=getEntryString(Instrument.subType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSubType(String subType) {
		setEntry(Instrument.subType, subType);
	}

	public String getMerchandiseName() {
		try {
			String data=getEntryString(Instrument.merchandiseName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMerchandiseName(String merchandiseName) {
		setEntry(Instrument.merchandiseName, merchandiseName);
	}

	public String getCurrencyName() {
		try {
			String data=getEntryString(Instrument.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(Instrument.currencyName, currencyName);
	}

	public int getIsHot() {
		try {
			int data=getEntryInt(Instrument.isHot);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsHot(int isHot) {
		setEntry(Instrument.isHot, isHot);
	}

	public int getDigits() {
		try {
			int data=getEntryInt(Instrument.digits);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDigits(int digits) {
		setEntry(Instrument.digits, digits);
	}

	public double getMinLots() {
		try {
			double data=getEntryDouble(Instrument.minLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinLots(double minLots) {
		setEntry(Instrument.minLots, minLots);
	}

	public int getMaxLots() {
		try {
			int data=getEntryInt(Instrument.maxLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxLots(int maxLots) {
		setEntry(Instrument.maxLots, maxLots);
	}

	public int getAmountPerLot() {
		try {
			int data=getEntryInt(Instrument.amountPerLot);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmountPerLot(int amountPerLot) {
		setEntry(Instrument.amountPerLot, amountPerLot);
	}

	public int getSort() {
		try {
			int data=getEntryInt(Instrument.sort);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSort(int sort) {
		setEntry(Instrument.sort, sort);
	}

	public double getSpreads() {
		try {
			double data=getEntryDouble(Instrument.spreads);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSpreads(double spreads) {
		setEntry(Instrument.spreads, spreads);
	}

	public int getSpike() {
		try {
			int data=getEntryInt(Instrument.spike);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSpike(int spike) {
		setEntry(Instrument.spike, spike);
	}

	public int getShade() {
		try {
			int data=getEntryInt(Instrument.shade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setShade(int shade) {
		setEntry(Instrument.shade, shade);
	}

	public int getExtraDigit() {
		try {
			int data=getEntryInt(Instrument.extraDigit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setExtraDigit(int extraDigit) {
		setEntry(Instrument.extraDigit, extraDigit);
	}

	public int getValidPriceGap4StopOrder() {
		try {
			int data=getEntryInt(Instrument.validPriceGap4StopOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setValidPriceGap4StopOrder(int validPriceGap4StopOrder) {
		setEntry(Instrument.validPriceGap4StopOrder, validPriceGap4StopOrder);
	}

	public int getGap2ActiveOrder() {
		try {
			int data=getEntryInt(Instrument.gap2ActiveOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGap2ActiveOrder(int gap2ActiveOrder) {
		setEntry(Instrument.gap2ActiveOrder, gap2ActiveOrder);
	}

	public int getSafeGap4OpenOrder() {
		try {
			int data=getEntryInt(Instrument.safeGap4OpenOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSafeGap4OpenOrder(int safeGap4OpenOrder) {
		setEntry(Instrument.safeGap4OpenOrder, safeGap4OpenOrder);
	}

	public int getCanUseGuaranteeStop() {
		try {
			int data=getEntryInt(Instrument.canUseGuaranteeStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanUseGuaranteeStop(int canUseGuaranteeStop) {
		setEntry(Instrument.canUseGuaranteeStop, canUseGuaranteeStop);
	}

	public int getGuaranteeStopMinPriceGap() {
		try {
			int data=getEntryInt(Instrument.guaranteeStopMinPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopMinPriceGap(int guaranteeStopMinPriceGap) {
		setEntry(Instrument.guaranteeStopMinPriceGap, guaranteeStopMinPriceGap);
	}

	public int getGuaranteeStopChargePoint() {
		try {
			int data=getEntryInt(Instrument.guaranteeStopChargePoint);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopChargePoint(int guaranteeStopChargePoint) {
		setEntry(Instrument.guaranteeStopChargePoint, guaranteeStopChargePoint);
	}

	public int getMoveStopMinGap() {
		try {
			int data=getEntryInt(Instrument.moveStopMinGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMoveStopMinGap(int moveStopMinGap) {
		setEntry(Instrument.moveStopMinGap, moveStopMinGap);
	}

	public int getCommCaculateStyle() {
		try {
			int data=getEntryInt(Instrument.commCaculateStyle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommCaculateStyle(int commCaculateStyle) {
		setEntry(Instrument.commCaculateStyle, commCaculateStyle);
	}

	public int getCanPreSell() {
		try {
			int data=getEntryInt(Instrument.canPreSell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanPreSell(int canPreSell) {
		setEntry(Instrument.canPreSell, canPreSell);
	}

	public double getOpenCommision() {
		try {
			double data=getEntryDouble(Instrument.openCommision);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenCommision(double openCommision) {
		setEntry(Instrument.openCommision, openCommision);
	}

	public double getCloseCommision() {
		try {
			double data=getEntryDouble(Instrument.closeCommision);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseCommision(double closeCommision) {
		setEntry(Instrument.closeCommision, closeCommision);
	}

	public double getMinimumCommision4PerCalulate() {
		try {
			double data=getEntryDouble(Instrument.minimumCommision4PerCalulate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinimumCommision4PerCalulate(double minimumCommision4PerCalulate) {
		setEntry(Instrument.minimumCommision4PerCalulate, minimumCommision4PerCalulate);
	}

	public String getIBChargeTypeID() {
		try {
			String data=getEntryString(Instrument.IBChargeTypeID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIBChargeTypeID(String IBChargeTypeID) {
		setEntry(Instrument.IBChargeTypeID, IBChargeTypeID);
	}

	public double getOpenMarginPercentage() {
		try {
			double data=getEntryDouble(Instrument.openMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenMarginPercentage(double openMarginPercentage) {
		setEntry(Instrument.openMarginPercentage, openMarginPercentage);
	}

	public double getMarginCall1Percentage() {
		try {
			double data=getEntryDouble(Instrument.marginCall1Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCall1Percentage(double marginCall1Percentage) {
		setEntry(Instrument.marginCall1Percentage, marginCall1Percentage);
	}

	public double getMarginCall2Percentage() {
		try {
			double data=getEntryDouble(Instrument.marginCall2Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCall2Percentage(double marginCall2Percentage) {
		setEntry(Instrument.marginCall2Percentage, marginCall2Percentage);
	}

	public double getLiquidationMarginPercentage() {
		try {
			double data=getEntryDouble(Instrument.liquidationMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLiquidationMarginPercentage(double liquidationMarginPercentage) {
		setEntry(Instrument.liquidationMarginPercentage, liquidationMarginPercentage);
	}

	public int getAutoRates() {
		try {
			int data=getEntryInt(Instrument.autoRates);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoRates(int autoRates) {
		setEntry(Instrument.autoRates, autoRates);
	}

	public int getAutoMkt() {
		try {
			int data=getEntryInt(Instrument.autoMkt);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoMkt(int autoMkt) {
		setEntry(Instrument.autoMkt, autoMkt);
	}

	public int getAutoLim() {
		try {
			int data=getEntryInt(Instrument.autoLim);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoLim(int autoLim) {
		setEntry(Instrument.autoLim, autoLim);
	}

	public int getAutoStop() {
		try {
			int data=getEntryInt(Instrument.autoStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoStop(int autoStop) {
		setEntry(Instrument.autoStop, autoStop);
	}

	public int getMktTradeable() {
		try {
			int data=getEntryInt(Instrument.mktTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMktTradeable(int mktTradeable) {
		setEntry(Instrument.mktTradeable, mktTradeable);
	}

	public int getTradeable() {
		try {
			int data=getEntryInt(Instrument.tradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradeable(int tradeable) {
		setEntry(Instrument.tradeable, tradeable);
	}

	public int getOrderScanWay() {
		try {
			int data=getEntryInt(Instrument.orderScanWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderScanWay(int orderScanWay) {
		setEntry(Instrument.orderScanWay, orderScanWay);
	}

	public int getNotGuarantedStopOrderTradeStyle() {
		try {
			int data=getEntryInt(Instrument.notGuarantedStopOrderTradeStyle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setNotGuarantedStopOrderTradeStyle(int notGuarantedStopOrderTradeStyle) {
		setEntry(Instrument.notGuarantedStopOrderTradeStyle, notGuarantedStopOrderTradeStyle);
	}

	public int getPriceValidTimeGap() {
		try {
			int data=getEntryInt(Instrument.priceValidTimeGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceValidTimeGap(int priceValidTimeGap) {
		setEntry(Instrument.priceValidTimeGap, priceValidTimeGap);
	}

	public int getIsVisable() {
		try {
			int data=getEntryInt(Instrument.isVisable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsVisable(int isVisable) {
		setEntry(Instrument.isVisable, isVisable);
	}

	public double getIBChargedPoints() {
		try {
			double data=getEntryDouble(Instrument.IBChargedPoints);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBChargedPoints(double IBChargedPoints) {
		setEntry(Instrument.IBChargedPoints, IBChargedPoints);
	}

	public String getExpireDate() {
		try {
			String data=getEntryString(Instrument.expireDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireDate(String expireDate) {
		setEntry(Instrument.expireDate, expireDate);
	}

	public int getForeceToUptrade() {
		try {
			int data=getEntryInt(Instrument.foreceToUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setForeceToUptrade(int foreceToUptrade) {
		setEntry(Instrument.foreceToUptrade, foreceToUptrade);
	}

	public String getUptradeBank() {
		try {
			String data=getEntryString(Instrument.uptradeBank);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUptradeBank(String uptradeBank) {
		setEntry(Instrument.uptradeBank, uptradeBank);
	}

	public int getIsRolloverContainsHoliday() {
		try {
			int data=getEntryInt(Instrument.isRolloverContainsHoliday);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsRolloverContainsHoliday(int isRolloverContainsHoliday) {
		setEntry(Instrument.isRolloverContainsHoliday, isRolloverContainsHoliday);
	}

	public int getValueDayDelay() {
		try {
			int data=getEntryInt(Instrument.valueDayDelay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setValueDayDelay(int valueDayDelay) {
		setEntry(Instrument.valueDayDelay, valueDayDelay);
	}

	public String getSecType() {
		try {
			String data=getEntryString(Instrument.secType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSecType(String secType) {
		setEntry(Instrument.secType, secType);
	}

	public String getStrike() {
		try {
			String data=getEntryString(Instrument.strike);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStrike(String strike) {
		setEntry(Instrument.strike, strike);
	}

	public String getOptionRight() {
		try {
			String data=getEntryString(Instrument.optionRight);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOptionRight(String optionRight) {
		setEntry(Instrument.optionRight, optionRight);
	}

	public String getMarketOpenTimeInterval() {
		try {
			String data=getEntryString(Instrument.marketOpenTimeInterval);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMarketOpenTimeInterval(String marketOpenTimeInterval) {
		setEntry(Instrument.marketOpenTimeInterval, marketOpenTimeInterval);
	}

	public int getIsDead() {
		try {
			int data=getEntryInt(Instrument.isDead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsDead(int isDead) {
		setEntry(Instrument.isDead, isDead);
	}

	public int getSpreadType() {
		try {
			int data=getEntryInt(Instrument.spreadType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSpreadType(int spreadType) {
		setEntry(Instrument.spreadType, spreadType);
	}

	public String getTreeNodeName() {
		try {
			String data=getEntryString(Instrument.treeNodeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTreeNodeName(String treeNodeName) {
		setEntry(Instrument.treeNodeName, treeNodeName);
	}

	public String getDescription() {
		try {
			String data=getEntryString(Instrument.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(Instrument.description, description);
	}

	public String getMarketOpenTimeType() {
		try {
			String data=getEntryString(Instrument.marketOpenTimeType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMarketOpenTimeType(String marketOpenTimeType) {
		setEntry(Instrument.marketOpenTimeType, marketOpenTimeType);
	}

	public String getFirstNoticeDate() {
		try {
			String data=getEntryString(Instrument.firstNoticeDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstNoticeDate(String firstNoticeDate) {
		setEntry(Instrument.firstNoticeDate, firstNoticeDate);
	}

	public String getFirstPositionDate() {
		try {
			String data=getEntryString(Instrument.firstPositionDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstPositionDate(String firstPositionDate) {
		setEntry(Instrument.firstPositionDate, firstPositionDate);
	}

	public String getLastTradingDate() {
		try {
			String data=getEntryString(Instrument.lastTradingDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastTradingDate(String lastTradingDate) {
		setEntry(Instrument.lastTradingDate, lastTradingDate);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(Instrument.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(Instrument.groupName, groupName);
	}

	public double getGroup_minLots() {
		try {
			double data=getEntryDouble(Instrument.group_minLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_minLots(double group_minLots) {
		setEntry(Instrument.group_minLots, group_minLots);
	}

	public int getGroup_maxLots() {
		try {
			int data=getEntryInt(Instrument.group_maxLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_maxLots(int group_maxLots) {
		setEntry(Instrument.group_maxLots, group_maxLots);
	}

	public double getGroup_spread2Add() {
		try {
			double data=getEntryDouble(Instrument.group_spread2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_spread2Add(double group_spread2Add) {
		setEntry(Instrument.group_spread2Add, group_spread2Add);
	}

	public double getGroup_openCommision2Add() {
		try {
			double data=getEntryDouble(Instrument.group_openCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_openCommision2Add(double group_openCommision2Add) {
		setEntry(Instrument.group_openCommision2Add, group_openCommision2Add);
	}

	public double getGroup_closeCommision2Add() {
		try {
			double data=getEntryDouble(Instrument.group_closeCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_closeCommision2Add(double group_closeCommision2Add) {
		setEntry(Instrument.group_closeCommision2Add, group_closeCommision2Add);
	}

	public double getGroup_openMarginPercentage() {
		try {
			double data=getEntryDouble(Instrument.group_openMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_openMarginPercentage(double group_openMarginPercentage) {
		setEntry(Instrument.group_openMarginPercentage, group_openMarginPercentage);
	}

	public double getGroup_marginCall1Percentage() {
		try {
			double data=getEntryDouble(Instrument.group_marginCall1Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_marginCall1Percentage(double group_marginCall1Percentage) {
		setEntry(Instrument.group_marginCall1Percentage, group_marginCall1Percentage);
	}

	public double getGroup_marginCall2Percentage() {
		try {
			double data=getEntryDouble(Instrument.group_marginCall2Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_marginCall2Percentage(double group_marginCall2Percentage) {
		setEntry(Instrument.group_marginCall2Percentage, group_marginCall2Percentage);
	}

	public double getGroup_liquidationMarginPercentage() {
		try {
			double data=getEntryDouble(Instrument.group_liquidationMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_liquidationMarginPercentage(double group_liquidationMarginPercentage) {
		setEntry(Instrument.group_liquidationMarginPercentage, group_liquidationMarginPercentage);
	}

	public int getGroup_autoMkt() {
		try {
			int data=getEntryInt(Instrument.group_autoMkt);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_autoMkt(int group_autoMkt) {
		setEntry(Instrument.group_autoMkt, group_autoMkt);
	}

	public int getGroup_autoLim() {
		try {
			int data=getEntryInt(Instrument.group_autoLim);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_autoLim(int group_autoLim) {
		setEntry(Instrument.group_autoLim, group_autoLim);
	}

	public int getGroup_autoStop() {
		try {
			int data=getEntryInt(Instrument.group_autoStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_autoStop(int group_autoStop) {
		setEntry(Instrument.group_autoStop, group_autoStop);
	}

	public int getGroup_mktTradeable() {
		try {
			int data=getEntryInt(Instrument.group_mktTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_mktTradeable(int group_mktTradeable) {
		setEntry(Instrument.group_mktTradeable, group_mktTradeable);
	}

	public int getGroup_tradeable() {
		try {
			int data=getEntryInt(Instrument.group_tradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_tradeable(int group_tradeable) {
		setEntry(Instrument.group_tradeable, group_tradeable);
	}

	public int getGroup_isVisable() {
		try {
			int data=getEntryInt(Instrument.group_isVisable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_isVisable(int group_isVisable) {
		setEntry(Instrument.group_isVisable, group_isVisable);
	}

	public double getGroup_ibChargePoints() {
		try {
			double data=getEntryDouble(Instrument.group_ibChargePoints);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGroup_ibChargePoints(double group_ibChargePoints) {
		setEntry(Instrument.group_ibChargePoints, group_ibChargePoints);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(Instrument.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(Instrument.account, account);
	}

	public double getAccount_minLots() {
		try {
			double data=getEntryDouble(Instrument.account_minLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_minLots(double account_minLots) {
		setEntry(Instrument.account_minLots, account_minLots);
	}

	public int getAccount_maxLots() {
		try {
			int data=getEntryInt(Instrument.account_maxLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_maxLots(int account_maxLots) {
		setEntry(Instrument.account_maxLots, account_maxLots);
	}

	public double getAccount_spread2Add() {
		try {
			double data=getEntryDouble(Instrument.account_spread2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_spread2Add(double account_spread2Add) {
		setEntry(Instrument.account_spread2Add, account_spread2Add);
	}

	public double getAccount_openCommision2Add() {
		try {
			double data=getEntryDouble(Instrument.account_openCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_openCommision2Add(double account_openCommision2Add) {
		setEntry(Instrument.account_openCommision2Add, account_openCommision2Add);
	}

	public double getAccount_closeCommision2Add() {
		try {
			double data=getEntryDouble(Instrument.account_closeCommision2Add);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_closeCommision2Add(double account_closeCommision2Add) {
		setEntry(Instrument.account_closeCommision2Add, account_closeCommision2Add);
	}

	public double getAccount_openMarginPercentage() {
		try {
			double data=getEntryDouble(Instrument.account_openMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_openMarginPercentage(double account_openMarginPercentage) {
		setEntry(Instrument.account_openMarginPercentage, account_openMarginPercentage);
	}

	public double getAccount_marginCall1Percentage() {
		try {
			double data=getEntryDouble(Instrument.account_marginCall1Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_marginCall1Percentage(double account_marginCall1Percentage) {
		setEntry(Instrument.account_marginCall1Percentage, account_marginCall1Percentage);
	}

	public double getAccount_marginCall2Percentage() {
		try {
			double data=getEntryDouble(Instrument.account_marginCall2Percentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_marginCall2Percentage(double account_marginCall2Percentage) {
		setEntry(Instrument.account_marginCall2Percentage, account_marginCall2Percentage);
	}

	public double getAccount_liquidationMarginPercentage() {
		try {
			double data=getEntryDouble(Instrument.account_liquidationMarginPercentage);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_liquidationMarginPercentage(double account_liquidationMarginPercentage) {
		setEntry(Instrument.account_liquidationMarginPercentage, account_liquidationMarginPercentage);
	}

	public int getAccount_autoMkt() {
		try {
			int data=getEntryInt(Instrument.account_autoMkt);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_autoMkt(int account_autoMkt) {
		setEntry(Instrument.account_autoMkt, account_autoMkt);
	}

	public int getAccount_autoLim() {
		try {
			int data=getEntryInt(Instrument.account_autoLim);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_autoLim(int account_autoLim) {
		setEntry(Instrument.account_autoLim, account_autoLim);
	}

	public int getAccount_autoStop() {
		try {
			int data=getEntryInt(Instrument.account_autoStop);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_autoStop(int account_autoStop) {
		setEntry(Instrument.account_autoStop, account_autoStop);
	}

	public int getAccount_mktTradeable() {
		try {
			int data=getEntryInt(Instrument.account_mktTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_mktTradeable(int account_mktTradeable) {
		setEntry(Instrument.account_mktTradeable, account_mktTradeable);
	}

	public int getAccount_tradeable() {
		try {
			int data=getEntryInt(Instrument.account_tradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_tradeable(int account_tradeable) {
		setEntry(Instrument.account_tradeable, account_tradeable);
	}

	public int getAccount_isVisable() {
		try {
			int data=getEntryInt(Instrument.account_isVisable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_isVisable(int account_isVisable) {
		setEntry(Instrument.account_isVisable, account_isVisable);
	}

	public double getAccount_ibChargePoints() {
		try {
			double data=getEntryDouble(Instrument.account_ibChargePoints);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount_ibChargePoints(double account_ibChargePoints) {
		setEntry(Instrument.account_ibChargePoints, account_ibChargePoints);
	}

	public int getMarginType() {
		try {
			int data=getEntryInt(Instrument.marginType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginType(int marginType) {
		setEntry(Instrument.marginType, marginType);
	}


	
	///////
	
	public double getInterestAdjustBuy() {
		try {
			double data=getEntryDouble(Instrument.interestAdjustBuy);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestAdjustBuy(double interestAdjustBuy) {
		setEntry(Instrument.interestAdjustBuy, interestAdjustBuy);
	}
	
	public double getInterestAdjustSell() {
		try {
			double data=getEntryDouble(Instrument.interestAdjustSell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestAdjustSell(double interestAdjustSell) {
		setEntry(Instrument.interestAdjustSell, interestAdjustSell);
	}
	
	public double getMinUptradeLots() {
		try {
			double data=getEntryDouble(Instrument.minUptradeLots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMinUptradeLots(double minUptradeLots) {
		setEntry(Instrument.minUptradeLots, minUptradeLots);
	}

	public int getInterestType() {
		try {
			int data=getEntryInt(Instrument.interestType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestType(int interestType) {
		setEntry(Instrument.interestType, interestType);
	}
	
	public double getFixedInterestBuy() {
		try {
			double data=getEntryDouble(Instrument.fixedInterestBuy);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFixedInterestBuy(double fixedInterestBuy) {
		setEntry(Instrument.fixedInterestBuy, fixedInterestBuy);
	}
	
	public double getFixedInterestSell() {
		try {
			double data=getEntryDouble(Instrument.fixedInterestSell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFixedInterestSell(double fixedInterestSell) {
		setEntry(Instrument.fixedInterestSell, fixedInterestSell);
	}
	
	public String getFixInstrument() {
		try {
			String data=getEntryString(Instrument.fixInstrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixInstrument(String fixInstrument) {
		setEntry(Instrument.fixInstrument, fixInstrument);
	}
	
	public String getFixAmountExpression() {
		try {
			String data=getEntryString(Instrument.fixAmountExpression);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixAmountExpression(String fixAmountExpression) {
		setEntry(Instrument.fixAmountExpression, fixAmountExpression);
	}
	
	public String getFixAmountParams() {
		try {
			String data=getEntryString(Instrument.fixAmountParams);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixAmountParams(String fixAmountParams) {
		setEntry(Instrument.fixAmountParams, fixAmountParams);
	}
	
	public String getFixPriceExpression() {
		try {
			String data=getEntryString(Instrument.fixPriceExpression);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixPriceExpression(String fixPriceExpression) {
		setEntry(Instrument.fixPriceExpression, fixPriceExpression);
	}
	
	public String getFixPriceParams() {
		try {
			String data=getEntryString(Instrument.fixPriceParams);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixPriceParams(String fixPriceParams) {
		setEntry(Instrument.fixPriceParams, fixPriceParams);
	}
	
	public String getUnfixPriceExpression() {
		try {
			String data=getEntryString(Instrument.unfixPriceExpression);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUnfixPriceExpression(String unfixPriceExpression) {
		setEntry(Instrument.unfixPriceExpression, unfixPriceExpression);
	}
	
	public String getUnfixPriceParams() {
		try {
			String data=getEntryString(Instrument.unfixPriceParams);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUnfixPriceParams(String unfixPriceParams) {
		setEntry(Instrument.unfixPriceParams, unfixPriceParams);
	}

}