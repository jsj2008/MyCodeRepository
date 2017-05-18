package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.bankserver.comm.struct.UserBankProfileStream;

/**
 * 出入金相关14:07:17
 * 
 * @author ALLONE
 * 
 */
public class C3_UserBankProfileStream extends allone.json.AbstractJsonData {
	public static final String jsonId = "36";

	public C3_UserBankProfileStream() {
		super();
		setEntry("jsonId", jsonId);
	}

	/**
	 * @Fields STATE_FAIL : 操作失败
	 */
	public static final int STATE_FAIL = -1;
	/**
	 * @Fields STATE_NONE : 未操�?
	 */
	public static final int STATE_NONE = 0;
	/**
	 * @Fields STATE_WAITING : 等待审核
	 */
	public static final int STATE_WAITING = 1;
	/**
	 * @Fields STATE_CONFIRM : 审核确认
	 */
	public static final int STATE_CONFIRM = 2;
	/**
	 * @Fields STATE_SEND : 发�?银行
	 */
	public static final int STATE_SEND = 3;
	/**
	 * @Fields STATE_DONE : 完成
	 */
	public static final int STATE_DONE = 10;

	/**
	 * @Fields TYPE_UNKNOWN : 未知类型（之前没有操作过�?
	 */
	public static final int TYPE_UNKNOWN = 0;
	/**
	 * @Fields TYPE_SIGNUP : 签约
	 */
	public static final int TYPE_SIGNUP = 1;
	/**
	 * @Fields TYPE_SIGNOFF : 解约
	 */
	public static final int TYPE_SIGNOFF = 2;
	/**
	 * @Fields TYPE_MODIFY : 修改签约信息
	 */
	public static final int TYPE_MODIFY = 3;
	/**
	 * memberId,由ExServer提供
	 */
	private static final String memberId = "1";
	private static final String account = "2";
	private static final String streamID = "3";
	private static final String type = "4";
	private static final String state = "5";
	private static final String custSignInfo = "6";
	private static final String ipAddress = "7";
	private static final String streamTime = "8";
	private static final String message = "9";
	private static final String remark = "10";
	private static final String comment = "11";
	private static final String notified = "12";

	public void parseFromSysData(UserBankProfileStream data) throws Exception {
		setMemberId(data.getMemberId());
		setAccount(data.getAccount());
		setStreamID(data.getStreamID());
		setType(data.getType());
		setState(data.getState());
		setCustSignInfo(data.getCustSignInfo());
		setIpAddress(data.getIpAddress());
		setStreamTime(data.getStreamTime());
		setMessage(data.getMessage());
		setRemark(data.getRemark());
		setComment(data.getComment());
		setNotified(data.isNotified());

	}

	public UserBankProfileStream format() {
		UserBankProfileStream data = new UserBankProfileStream();
		data.setMemberId(getMemberId());
		data.setAccount(getAccount());
		data.setStreamID(getStreamID());
		data.setType(getType());
		data.setState(getState());
		data.setCustSignInfo(getCustSignInfo());
		data.setIpAddress(getIpAddress());
		data.setStreamTime(getStreamTime());
		data.setMessage(getMessage());
		data.setRemark(getRemark());
		data.setComment(getComment());
		data.setNotified(isNotified());

		return data;
	}

	// public int memberId;
	public int getMemberId() {
		try {
			int data = getEntryInt(C3_UserBankProfileStream.memberId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMemberId(int memberId) {
		setEntry(C3_UserBankProfileStream.memberId, memberId);
	}

	// private long account;
	public long getAccount() {
		try {
			long data = getEntryLong(C3_UserBankProfileStream.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_UserBankProfileStream.account, account);
	}

	// private long streamID;

	public long getStreamID() {
		try {
			long data = getEntryLong(C3_UserBankProfileStream.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long account) {
		setEntry(C3_UserBankProfileStream.streamID, streamID);
	}

	// private int type;

	public int getType() {
		try {
			int data = getEntryInt(C3_UserBankProfileStream.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_UserBankProfileStream.type, type);
	}

	// private int state;

	public int getState() {
		try {
			int data = getEntryInt(C3_UserBankProfileStream.state);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setState(int state) {
		setEntry(C3_UserBankProfileStream.state, state);
	}

	// private String custSignInfo;

	public String getCustSignInfo() {
		try {
			String data = getEntryString(C3_UserBankProfileStream.custSignInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCustSignInfo(String custSignInfo) {
		setEntry(C3_UserBankProfileStream.custSignInfo, custSignInfo);
	}

	// private String ipAddress;

	public String getIpAddress() {
		try {
			String data = getEntryString(C3_UserBankProfileStream.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(C3_UserBankProfileStream.ipAddress, ipAddress);
	}

	// private Date streamTime;

	// Date signOffTime
	public Date getStreamTime() {
		try {
			Date data = getEntryDate(C3_UserBankProfileStream.streamTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStreamTime(Date streamTime) {
		setEntry(C3_UserBankProfileStream.streamTime, streamTime);
	}

	// private String message;

	public String getMessage() {
		try {
			String data = getEntryString(C3_UserBankProfileStream.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(String message) {
		setEntry(C3_UserBankProfileStream.message, message);
	}

	// private String remark;

	public String getRemark() {
		try {
			String data = getEntryString(C3_UserBankProfileStream.remark);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRemark(String remark) {
		setEntry(C3_UserBankProfileStream.remark, remark);
	}

	// private String comment;

	public String getComment() {
		try {
			String data = getEntryString(C3_UserBankProfileStream.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String aeid) {
		setEntry(C3_UserBankProfileStream.comment, comment);
	}

	// private final boolean notified = false;

	public boolean isNotified() {
		try {
			boolean data = getEntryBoolean(C3_UserBankProfileStream.notified);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNotified(boolean notified) {
		setEntry(C3_UserBankProfileStream.notified, notified);
	}

}
