package comm.split;

import java.io.Serializable;

public class SplitRsp implements Serializable {
	private static final long serialVersionUID = -7978659182871422824L;

	private String _HashID;
	private boolean succeed;
	private String errCode;
	private String errMessage;
	private byte[] buffer;

	public SplitRsp(SplitReq ip) {
		errCode = "";
		errMessage = "";
		_HashID = ip.get_HashID();
	}

	public String toString() {
		return "OPID=SplitRsp,Succeed=" + this.isSucceed() + ",ErrCode=" + this.getErrCode() + ",ErrMessage=" + this.getErrMessage();
	}

	public boolean isSucceed() {
		return succeed;
	}

	public void setSucceed(boolean succeed) {
		this.succeed = succeed;
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

	public byte[] getBuffer() {
		return buffer;
	}

	public void setBuffer(byte[] buffer) {
		this.buffer = buffer;
	}

}
