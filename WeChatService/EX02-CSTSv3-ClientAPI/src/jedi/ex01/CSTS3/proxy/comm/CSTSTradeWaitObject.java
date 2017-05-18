package jedi.ex01.CSTS3.proxy.comm;

import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;

public class CSTSTradeWaitObject {
	private final static long WAITGAP = 3 * 60 * 1000;
	private String _hashCode;
	private IPFather ip;
	private OPFather op;

	public CSTSTradeWaitObject(IPFather ip) {
		this.ip = ip;
		this._hashCode = ip.getOperateId();
	}

	public synchronized OPFather waitTrade(long waitTime) {
		if (op != null) {
			return op;
		}
		try {
			this.wait(waitTime);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (op == null) {
			OPFather op = new OPFather(ip);
			op.setSucceed(false);
			op
					.setErrCode(IPOPErrCodeTable.ERR_Timeout);
			op.setErrMessage("CSTS trade timedout!");
			return op;
		}
		return op;
	}

	public synchronized OPFather waitTrade() {
		return waitTrade(WAITGAP);
	}

	public synchronized void tradeReturn(OPFather op) {
		this.op = op;
		this.notifyAll();
	}

	public synchronized void setErr() {
		if (op != null) {
			this.notifyAll();
		} else {
			op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_NetErr);
			op.setErrMessage("CSTS net err!");
			tradeReturn(op);
		}
	}

	public String get_hashCode() {
		return _hashCode;
	}

}
