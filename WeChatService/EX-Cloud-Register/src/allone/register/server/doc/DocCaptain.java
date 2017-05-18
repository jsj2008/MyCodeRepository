package allone.register.server.doc;

import allone.register.server.cadts.CADTSCaptain;
import ex.v01.exchange.comm.OPFather4EX;
import ex.v01.exchange.comm.ipop.IP_EX5902;
import ex.v01.exchange.comm.ipop.OP_EX5902;

public class DocCaptain {
	private final static DocCaptain instance = new DocCaptain();

	// commandID生成相关，去交易所取
	private long maxStreamId;
	private Object streamIdLock = new Object();
	private long currentStreamId;

	public static DocCaptain getInstance() {
		return instance;
	}

	public void destroy() {

	}

	public boolean init() {
		return true;
	}

	public long getNextStreamId() throws Exception {
		synchronized (streamIdLock) {
			long id = currentStreamId + 1;
			if (maxStreamId == 0 || id > maxStreamId) {
				IP_EX5902 ip = new IP_EX5902();
				OPFather4EX opf = CADTSCaptain.getInstance().doEXTrade(ip);
				if (!opf.isSucceed()) {
					throw new Exception(opf.getErrMessage());
				}
				OP_EX5902 op = (OP_EX5902) opf;
				this.currentStreamId = op.getBeginId();
				this.maxStreamId = op.getEndId();
			}
			currentStreamId++;
			return currentStreamId;
		}
	}
}
