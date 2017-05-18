package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class MessageToAccount extends allone.json.AbstractJsonData {

	public static final String jsonId = "14";

	public static final String guid = "1";
	public static final String dealer = "2";
	public static final String time = "3";
	public static final String title = "4";
	public static final String context = "5";
	public static final String type = "6";
	public static final String target = "7";
	public static final String isRead = "8";

	public MessageToAccount(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getGuid() {
		try {
			String data=getEntryString(MessageToAccount.guid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuid(String guid) {
		setEntry(MessageToAccount.guid, guid);
	}

	public String getDealer() {
		try {
			String data=getEntryString(MessageToAccount.dealer);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDealer(String dealer) {
		setEntry(MessageToAccount.dealer, dealer);
	}

	public Date getTime() {
		try {
			Date data=getEntryDate(MessageToAccount.time);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTime(Date time) {
		setEntry(MessageToAccount.time, time);
	}

	public String getTitle() {
		try {
			String data=getEntryString(MessageToAccount.title);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTitle(String title) {
		setEntry(MessageToAccount.title, title);
	}

	public String getContext() {
		try {
			String data=getEntryString(MessageToAccount.context);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setContext(String context) {
		setEntry(MessageToAccount.context, context);
	}

	public int getType() {
		try {
			int data=getEntryInt(MessageToAccount.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(MessageToAccount.type, type);
	}

	public String getTarget() {
		try {
			String data=getEntryString(MessageToAccount.target);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTarget(String target) {
		setEntry(MessageToAccount.target, target);
	}

	public int getIsRead() {
		try {
			int data=getEntryInt(MessageToAccount.isRead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsRead(int isRead) {
		setEntry(MessageToAccount.isRead, isRead);
	}


}