package jedi.ex01.CSTS3.comm.ipop;

import java.security.SecureRandom;

import allone.json.AbstractJsonData;

public class IPFather extends AbstractJsonData {

	public static final String jsonId = "ipf";

	public static final String id = "-1";
	public static final String operateId = "-2";
	public static final String userName = "-3";
	public static final String createTime = "-4";

	public IPFather() {
		super();
		setEntry("jsonId", jsonId);

		SecureRandom sr = new SecureRandom();
		String operateId = (Long.toHexString(System.currentTimeMillis() % 10000000) + "_"
				+ Long.toHexString(hashCode()) + "_" + Integer.toHexString(sr.nextInt())).toUpperCase();
		setEntry(IPFather.operateId, operateId);

		long createTime = System.currentTimeMillis();
		setEntry(IPFather.createTime, createTime);

		String classname = getClass().getName();
		if (classname.indexOf("_") >= 0) {
			setEntry(IPFather.id, classname.substring(classname.lastIndexOf("_") + 1));
		} else {
			setEntry(IPFather.id, "IPFather");
		}
	}

	public String getID() {
		try {
			String data = getEntryString(IPFather.id);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public String getOperateId() {
		try {
			String data = getEntryString(IPFather.operateId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public String getUserName() {
		try {
			String data = getEntryString(IPFather.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(IPFather.userName, userName);
	}

	public long getCreateTime() {
		try {
			long data = getEntryLong(IPFather.createTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

}
