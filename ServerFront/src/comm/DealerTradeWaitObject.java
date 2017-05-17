package comm;

import comm.codeTable.IErrorCodeTable;
import comm.message.IPFather;
import comm.message.OPFather;

public class DealerTradeWaitObject {
	private long WAITGAP = 1 * 60 * 1000;
	private String _hashCode;
	private IPFather ip;
	private OPFather op;
	private SplitOPeventListener listener;

	public DealerTradeWaitObject(IPFather ip, long waitGap, SplitOPeventListener listener) {
		if (waitGap > 0) {
			this.WAITGAP = waitGap;
		}
		this.ip = ip;
		this._hashCode = ip.get_HashID();
		this.listener = listener;
	}

	public synchronized OPFather waitTrade() {
		if (op != null) {
			return op;
		}
		try {
			this.wait(WAITGAP);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (op == null) {
			OPFather op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IErrorCodeTable.errTimeout);
			op.setErrMessage("trade timedout!");
			return op;
		}
		return op;
	}

	public synchronized void tradeReturn(OPFather op) {
		this.op = op;
		this.notifyAll();
	}

	public synchronized void timeout() {
		OPFather op = new OPFather(ip);
		op.setSucceed(false);
		op.setErrCode(IErrorCodeTable.errTimeout);
		op.setErrMessage("trade timedout!");
		tradeReturn(op);
	}

	public synchronized void setErr() {
		if (op != null) {
			this.notifyAll();
		} else {
			op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IErrorCodeTable.errNetError);
			op.setErrMessage("net err!");
			tradeReturn(op);
		}
	}

	public String get_hashCode() {
		return _hashCode;
	}

	public IPFather getIp() {
		return ip;
	}

	public SplitOPeventListener getListener() {
		return listener;
	}
}
