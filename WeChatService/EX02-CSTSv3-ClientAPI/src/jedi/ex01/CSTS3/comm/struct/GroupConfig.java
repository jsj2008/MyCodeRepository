package jedi.ex01.CSTS3.comm.struct;


public class GroupConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "6";

	public static final String groupName = "1";
	public static final String isTradeable = "2";
	public static final String description = "3";
	public static final String domainName = "4";
	public static final String tradeCtrlStrategyId = "5";
	public static final String margin2Partion = "6";
//	public static final String isFloatMargin2 = "7";
//	public static final String margin2Times = "8";
//	public static final String isOpenTradeable = "9";
//	public static final String isCloseTradeable = "10";
//	public static final String isCanOrder = "11";
//	public static final String OrderMarginType = "12";
	
	public static final String isFloatMargin2 = "7";
	public static final String margin2Times = "8";

	public GroupConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(GroupConfig.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(GroupConfig.groupName, groupName);
	}

	public int getIsTradeable() {
		try {
			int data=getEntryInt(GroupConfig.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(GroupConfig.isTradeable, isTradeable);
	}

	public String getDescription() {
		try {
			String data=getEntryString(GroupConfig.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(GroupConfig.description, description);
	}

	public String getDomainName() {
		try {
			String data=getEntryString(GroupConfig.domainName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDomainName(String domainName) {
		setEntry(GroupConfig.domainName, domainName);
	}

	public String getTradeCtrlStrategyId() {
		try {
			String data=getEntryString(GroupConfig.tradeCtrlStrategyId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeCtrlStrategyId(String tradeCtrlStrategyId) {
		setEntry(GroupConfig.tradeCtrlStrategyId, tradeCtrlStrategyId);
	}

	public double getMargin2Partion() {
		try {
			double data=getEntryDouble(GroupConfig.margin2Partion);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMargin2Partion(double margin2Partion) {
		setEntry(GroupConfig.margin2Partion, margin2Partion);
	}

	public int getIsFloatMargin2() {
		try {
			int data=getEntryInt(GroupConfig.isFloatMargin2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsFloatMargin2(int isFloatMargin2) {
		setEntry(GroupConfig.isFloatMargin2, isFloatMargin2);
	}

	public double getMargin2Times() {
		try {
			double data=getEntryDouble(GroupConfig.margin2Times);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMargin2Times(double margin2Times) {
		setEntry(GroupConfig.margin2Times, margin2Times);
	}

//	public int getIsOpenTradeable() {
//		try {
//			int data=getEntryInt(GroupConfig.isOpenTradeable);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsOpenTradeable(int isOpenTradeable) {
//		setEntry(GroupConfig.isOpenTradeable, isOpenTradeable);
//	}
//
//	public int getIsCloseTradeable() {
//		try {
//			int data=getEntryInt(GroupConfig.isCloseTradeable);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCloseTradeable(int isCloseTradeable) {
//		setEntry(GroupConfig.isCloseTradeable, isCloseTradeable);
//	}
//
//	public int getIsCanOrder() {
//		try {
//			int data=getEntryInt(GroupConfig.isCanOrder);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanOrder(int isCanOrder) {
//		setEntry(GroupConfig.isCanOrder, isCanOrder);
//	}
//
//	public int getOrderMarginType() {
//		try {
//			int data=getEntryInt(GroupConfig.OrderMarginType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setOrderMarginType(int OrderMarginType) {
//		setEntry(GroupConfig.OrderMarginType, OrderMarginType);
//	}


}