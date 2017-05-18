package jedi.ex01.CSTS3.comm.struct;

import java.io.Serializable;
import java.util.Date;

/**
 * ���г����ʹ�õ���2016��8��2��14:07:17
 * 
 * @author ALLONE
 * 
 */
public class UserBankProfileStream extends allone.json.AbstractJsonData {
	public static final String jsonId = "36";

	public UserBankProfileStream() {
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

	// public int memberId;
	public int getMemberId() {
		try {
			int data = getEntryInt(UserBankProfileStream.memberId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMemberId(int memberId) {
		setEntry(UserBankProfileStream.memberId, memberId);
	}

	// private long account;
	public long getAccount() {
		try {
			long data = getEntryLong(UserBankProfileStream.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(UserBankProfileStream.account, account);
	}

	// private long streamID;

	public long getStreamID() {
		try {
			long data = getEntryLong(UserBankProfileStream.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long account) {
		setEntry(UserBankProfileStream.streamID, streamID);
	}

	// private int type;

	public int getType() {
		try {
			int data = getEntryInt(UserBankProfileStream.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(UserBankProfileStream.type, type);
	}

	// private int state;

	public int getState() {
		try {
			int data = getEntryInt(UserBankProfileStream.state);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setState(int state) {
		setEntry(UserBankProfileStream.state, state);
	}

	// private String custSignInfo;

	public String getCustSignInfo() {
		try {
			String data = getEntryString(UserBankProfileStream.custSignInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCustSignInfo(String custSignInfo) {
		setEntry(UserBankProfileStream.custSignInfo, custSignInfo);
	}

	// private String ipAddress;

	public String getIpAddress() {
		try {
			String data = getEntryString(UserBankProfileStream.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(UserBankProfileStream.ipAddress, ipAddress);
	}

	// private Date streamTime;

	// Date signOffTime
	public Date getStreamTime() {
		try {
			Date data = getEntryDate(UserBankProfileStream.streamTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStreamTime(Date streamTime) {
		setEntry(UserBankProfileStream.streamTime, streamTime);
	}

	// private String message;

	public String getMessage() {
		try {
			String data = getEntryString(UserBankProfileStream.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(String message) {
		setEntry(UserBankProfileStream.message, message);
	}

	// private String remark;

	public String getRemark() {
		try {
			String data = getEntryString(UserBankProfileStream.remark);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRemark(String remark) {
		setEntry(UserBankProfileStream.remark, remark);
	}

	// private String comment;

	public String getComment() {
		try {
			String data = getEntryString(UserBankProfileStream.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String aeid) {
		setEntry(UserBankProfileStream.comment, comment);
	}

	// private final boolean notified = false;

	public boolean isNotified() {
		try {
			boolean data = getEntryBoolean(UserBankProfileStream.notified);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNotified(boolean notified) {
		setEntry(UserBankProfileStream.notified, notified);
	}

}
