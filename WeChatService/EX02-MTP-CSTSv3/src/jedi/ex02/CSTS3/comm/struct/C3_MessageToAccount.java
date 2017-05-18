package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.MessageToAccount;

public class C3_MessageToAccount extends allone.json.AbstractJsonData {

	public static final String jsonId = "14";

	public static final String guid = "1";
	public static final String dealer = "2";
	public static final String time = "3";
	public static final String title = "4";
	public static final String context = "5";
	public static final String type = "6";
	public static final String target = "7";
	public static final String isRead = "8";

	public C3_MessageToAccount(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(MessageToAccount data) throws Exception {
		setGuid(data.getGuid());
		setDealer(data.getDealer());
		setTime(data.getTime());
		setTitle(data.getTitle());
		setContext(data.queryContext());
		setType(data.getType());
		setTarget(data.getTarget());
		setIsRead(data.getIsRead());
	}

	public MessageToAccount format(){
		MessageToAccount data=new MessageToAccount();
		data.setGuid(getGuid());
		data.setDealer(getDealer());
		data.setTime(getTime());
		data.setTitle(getTitle());
		data.setContext(getContext());
		data.setType(getType());
		data.setTarget(getTarget());
		data.setIsRead(getIsRead());
		return data;
	}


	public String getGuid() {
		try {
			String data=getEntryString(C3_MessageToAccount.guid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuid(String guid) {
		setEntry(C3_MessageToAccount.guid, guid);
	}

	public String getDealer() {
		try {
			String data=getEntryString(C3_MessageToAccount.dealer);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDealer(String dealer) {
		setEntry(C3_MessageToAccount.dealer, dealer);
	}

	public Date getTime() {
		try {
			Date data=getEntryDate(C3_MessageToAccount.time);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTime(Date time) {
		setEntry(C3_MessageToAccount.time, time);
	}

	public String getTitle() {
		try {
			String data=getEntryString(C3_MessageToAccount.title);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTitle(String title) {
		setEntry(C3_MessageToAccount.title, title);
	}

	public String getContext() {
		try {
			String data=getEntryString(C3_MessageToAccount.context);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setContext(String context) {
		setEntry(C3_MessageToAccount.context, context);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_MessageToAccount.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_MessageToAccount.type, type);
	}

	public String getTarget() {
		try {
			String data=getEntryString(C3_MessageToAccount.target);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTarget(String target) {
		setEntry(C3_MessageToAccount.target, target);
	}

	public int getIsRead() {
		try {
			int data=getEntryInt(C3_MessageToAccount.isRead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsRead(int isRead) {
		setEntry(C3_MessageToAccount.isRead, isRead);
	}


}