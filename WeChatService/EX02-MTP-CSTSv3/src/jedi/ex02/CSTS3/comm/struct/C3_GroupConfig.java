package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.GroupConfig;


public class C3_GroupConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "6";

	public static final String groupName = "1";
	public static final String isTradeable = "2";
	public static final String description = "3";
	public static final String domainName = "4";
	public static final String tradeCtrlStrategyId = "5";
	public static final String margin2Partion = "6";
	
	public static final String isFloatMargin2 = "7";
	public static final String margin2Times = "8";

	public C3_GroupConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(GroupConfig data) throws Exception {
		setGroupName(data.getGroupName());
		setIsTradeable(data.getIsTradeable());
		setDescription(data.getDescription());
		setDomainName(data.getDomainName());
		setTradeCtrlStrategyId(data.getTradeCtrlStrategyId());
		setMargin2Partion(data.getMargin2Partion());
		
		setIsFloatMargin2(data.getIsFloatMargin2());
		setMargin2Times(data.getMargin2Times());
	}

	public GroupConfig format(){
		GroupConfig data=new GroupConfig();
		data.setGroupName(getGroupName());
		data.setIsTradeable(getIsTradeable());
		data.setDescription(getDescription());
		data.setDomainName(getDomainName());
		data.setTradeCtrlStrategyId(getTradeCtrlStrategyId());
		data.setMargin2Partion(getMargin2Partion());
		return data;
	}


	public String getGroupName() {
		try {
			String data=getEntryString(C3_GroupConfig.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_GroupConfig.groupName, groupName);
	}

	public int getIsTradeable() {
		try {
			int data=getEntryInt(C3_GroupConfig.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(C3_GroupConfig.isTradeable, isTradeable);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_GroupConfig.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_GroupConfig.description, description);
	}

	public String getDomainName() {
		try {
			String data=getEntryString(C3_GroupConfig.domainName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDomainName(String domainName) {
		setEntry(C3_GroupConfig.domainName, domainName);
	}

	public String getTradeCtrlStrategyId() {
		try {
			String data=getEntryString(C3_GroupConfig.tradeCtrlStrategyId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeCtrlStrategyId(String tradeCtrlStrategyId) {
		setEntry(C3_GroupConfig.tradeCtrlStrategyId, tradeCtrlStrategyId);
	}

	public double getMargin2Partion() {
		try {
			double data=getEntryDouble(C3_GroupConfig.margin2Partion);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsFloatMargin2(int isFloatMargin2) {
		setEntry(C3_GroupConfig.isFloatMargin2, isFloatMargin2);
	}
	
	public int getIsFloatMargin2() {
		try {
			int data=getEntryInt(C3_GroupConfig.isFloatMargin2);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMargin2Times(double margin2Times) {
		setEntry(C3_GroupConfig.margin2Times, margin2Times);
	}
	
	public double getMargin2Times() {
		try {
			double data=getEntryDouble(C3_GroupConfig.margin2Times);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMargin2Partion(double margin2Partion) {
		setEntry(C3_GroupConfig.margin2Partion, margin2Partion);
	}


}