package jedi.ex02.CSTS3.comm.ipop;

import allone.json.AbstractJsonData;

public class C3_OPFather extends AbstractJsonData {

	public static final String jsonId = "opf";

	public static final String id = "-1";
	public static final String operateId = "-2";
	public static final String succeed = "-3";
	public static final String errCode = "-4";
	public static final String errMessage = "-5";

	public C3_OPFather(C3_IPFather ip) {
		super();
		setEntry(C3_OPFather.id, ip.getID());
		setEntry(C3_OPFather.operateId, ip.getOperateId());
	}

	public void parseFromSysData(jedi.v7.comm.datastruct.IPOP.OPFather op)throws Exception{
		setSucceed(op.isSucceed());
		setErrCode(op.getErrCode());
		setErrMessage(op.getErrMessage());
	}
	
	public String getID() {
		try {
			String data = getEntryString(C3_OPFather.id);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public String getOperateId() {
		try {
			String data = getEntryString(C3_OPFather.operateId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public String getErrCode() {
		try {
			String data = getEntryString(C3_OPFather.errCode);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setErrCode(String errCode) {
		setEntry(C3_OPFather.errCode, errCode);
	}

	public String getErrMessage() {
		try {
			String data = getEntryString(C3_OPFather.errMessage);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setErrMessage(String errMessage) {
		setEntry(C3_OPFather.errMessage, errMessage);
	}

	public boolean isSucceed() {
		try {
			boolean data = getEntryBoolean(C3_OPFather.succeed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setSucceed(boolean succeed) {
		setEntry(C3_OPFather.succeed, succeed);
	}

}
