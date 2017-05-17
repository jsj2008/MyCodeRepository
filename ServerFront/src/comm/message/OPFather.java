package comm.message;

import java.io.Serializable;

public class OPFather implements Serializable {
	private static final long serialVersionUID = 512893530011848824L;
	private String _HashID;
	private String _ID;
	private long _tradeUsedTime = -1;
	private boolean succeed;
	private String errCode = "";
	private String errMessage = "";
	private String _errPathTrace = "";

	public OPFather(IPFather ip) {
		this._HashID = ip.get_HashID();
		this._ID = ip.get_ID();
	}

	public boolean isSucceed() {
		return succeed;
	}

	public void setSucceed(boolean succeed) {
		this.succeed = succeed;
		if (!succeed) {
			StackTraceElement s[] = Thread.currentThread().getStackTrace();
			StringBuffer sb = new StringBuffer();
			sb.append("\r\n");
			for (int i = 0; i < s.length; i++) {
				sb.append("\t\t");
				sb.append(s[i].toString());
				sb.append("\r\n");
			}
			sb.append("\t");
			this._errPathTrace = sb.toString();
		}
	}

	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}

	public String getErrMessage() {
		return errMessage;
	}

	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}

	public String get_HashID() {
		return _HashID;
	}

	public String get_ID() {
		return _ID;
	}

	public String toXmlString() {
		return "";
	}

	public long get_tradeUsedTime() {
		return _tradeUsedTime;
	}

	public void set_tradeUsedTime(long usedTime) {
		_tradeUsedTime = usedTime;
	}

	public String get_errPathTrace() {
		return _errPathTrace;
	}

	public void set_errPathTrace(String pathTrace) {
		_errPathTrace = pathTrace;
	}
}
