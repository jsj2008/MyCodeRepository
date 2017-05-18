package jedi.ex01.CSTS3.comm.ipop;

import allone.json.AbstractJsonData;

public class OPFather extends AbstractJsonData {

	public static final String jsonId = "opf";

	public static final String id = "-1";
	public static final String operateId = "-2";
	public static final String succeed = "-3";
	public static final String errCode = "-4";
	public static final String errMessage = "-5";
	public static final String usedTime = "-6";

	public OPFather() {
		super();
	}

	public OPFather(IPFather ip) {
		super();
		setEntry(OPFather.id, ip.getID());
		setEntry(OPFather.operateId, ip.getOperateId());
	}

	public String getID() {
		try {
			String data = getEntryString(OPFather.id);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public String getOperateId() {
		try {
			String data = getEntryString(OPFather.operateId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public String getErrCode() {
		try {
			String data = getEntryString(OPFather.errCode);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setErrCode(String errCode) {
		setEntry(OPFather.errCode, errCode);
	}

	public String getErrMessage() {
		try {
			String data = getEntryString(OPFather.errMessage);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setErrMessage(String errMessage) {
		setEntry(OPFather.errMessage, errMessage);
	}

	public boolean isSucceed() {
		try {
			boolean data = getEntryBoolean(OPFather.succeed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setSucceed(boolean succeed) {
		setEntry(OPFather.succeed, succeed);
	}

	public long getUsedTime() {
		try {
			long data = getEntryLong(OPFather.usedTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUsedTime(long usedTime) {
		setEntry(OPFather.usedTime, usedTime);
	}

}
