package comm;

import comm.codeTable.IErrorCodeTable;
import comm.split.SplitReq;
import comm.split.SplitRsp;

public class SplitOPTradeWaitObject {

	private long WAITGAP = 3 * 60 * 1000;
	private String _hashCode;
	private SplitReq ip;
	private SplitRsp op;

	public SplitOPTradeWaitObject(SplitReq ip, long waitGap) {
		if (waitGap > 0) {
			this.WAITGAP = waitGap;
		}
		this.ip = ip;
		this._hashCode = ip.get_HashID();
	}

	public synchronized SplitRsp waitTrade() {
		if (op != null) {
			return op;
		}
		try {
			this.wait(WAITGAP);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (op == null) {
			SplitRsp op = new SplitRsp(ip);
			op.setSucceed(false);
			op.setErrCode(IErrorCodeTable.errTimeout);
			op.setErrMessage("trade timedout!");
			return op;
		}
		return op;
	}

	public synchronized void tradeReturn(SplitRsp op) {
		this.op = op;
		this.notifyAll();
	}

	public synchronized void setErr() {
		if (op != null) {
			this.notifyAll();
		} else {
			op = new SplitRsp(ip);
			op.setSucceed(false);
			op.setErrCode(IErrorCodeTable.errNetError);
			op.setErrMessage("net err!");
			tradeReturn(op);
		}
	}

	public String get_hashCode() {
		return _hashCode;
	}

	public SplitReq getIp() {
		return ip;
	}
}
