package allone.register.server.cadts;

import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import allone.CADTS.proxy.SimpleCADTSProxy;
import allone.Log.simpleLog.log.LogProxy;
import allone.register.server.config.ConfigCaptain;
import ex.v01.exchange.comm.IPFather4EX;
import ex.v01.exchange.comm.OPFather4EX;
import ex.v01.exchange.comm.ServCallNameTable4EX;

/**
 * @author zhang.lei
 *
 */
public class CADTSCaptain extends SimpleCADTSProxy {
	private static CADTSCaptain instance = new CADTSCaptain();

	public static CADTSCaptain getInstance() {
		return instance;
	}

	public boolean init() {
		ConfigCaptain cfg = ConfigCaptain.getInstance();
		this.init(cfg.getCADTSIp(), cfg.getCADTSCmdPort(), cfg.getCADTSDataPort(), cfg.getCADTSServName(), cfg.getServerName());
		return true;
	}

	public OPFather4EX doEXTrade(IPFather4EX ip) {
		ip.set_fromServer(ConfigCaptain.getInstance().getServerName());
		String toServerName = ServCallNameTable4EX.SERV_EX02_EXSERVER;
		OPFather4EX op = null;
		try {
			ip.set_toServer(toServerName);
			op = (OPFather4EX) CADTSCaptain.getInstance().trade(toServerName, null, ip.get_ID(), ip);
			if (op == null) {
				op = new OPFather4EX(ip);
				op.setSucceed(false);
				op.setErrCode(IPOPErrCodeTable.ERR_CADTS_NETERR);
				op.setErrMessage("Unkown CADTS");
				return op;
			} 

			return op;
		} catch (Exception e) {
			LogProxy.printException(e);
			op = new OPFather4EX(ip);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_CADTS_NETERR);
			op.setErrMessage(e.getMessage());
			return op;
		} finally {
			LogProxy.printTrade(ip.get_ID(), ip, op, op.isSucceed());
		}
	}

	@Override
	public Object receiveCMD(String arg0, String arg1, String arg2, Object obj) throws Exception {
		// regist server 不需要接收什么交易
		return null;
	}

	@Override
	public void receiveData(String arg0, String arg1, String arg2, Object arg3) {

	}
}
