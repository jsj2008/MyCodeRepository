package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl1002;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl1002;
import allone.MTP.VerBank01.Ctrl.comm.ipop.dsts.IP_CtrlDSTS1002;
import allone.MTP.VerBank01.WSFacade.comm.ipop.IP_WSFacade2001;
import allone.MTP.VerBank01.WSFacade.comm.ipop.OP_WSFacade2001;
import allone.MTP.VerBank01.comm.IPOP.OPFather;
import allone.crypto.Crypt;

public class TradeCtrl1002 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl1002 ip = (IP_Ctrl1002) ipFather;
		OP_Ctrl1002 op = new OP_Ctrl1002(ip);
		
		if (StaticContext.getConfigCaptain().isDebug()) {
			String dn = ip.getDealerName();
			String roleName = "Admin";
			int idx = dn.indexOf("role_");
			if (idx != -1) {
				roleName = dn.substring(idx + 5);
			}

			op.setSucceed(true);
			op.setRoleName(new String[] { roleName });
		} else {
			IP_WSFacade2001 ip2001 = new IP_WSFacade2001();
			ip2001.setUserId(ip.getDealerName());
			String password=Crypt.decryptALLONE(ip.getPassword(), ip.getDealerName());
			ip2001.setPassword(password);
			
			OPFather opf = StaticContext.getTradeCaptain().callTrade(ip2001);
			if (opf.isSucceed()) {
				OP_WSFacade2001 op2001 = (OP_WSFacade2001) opf;
				op.setSucceed(true);
				op.setRoleName(op2001.getUserInfo().getRoleId());
			} else {
				op.setSucceed(false);
				op.setErrCode(opf.getErrCode());
				op.setErrMessage(opf.getErrMessage());
			}
		}
		
		if (op.isSucceed()) {
			runTask(new KickDealerTask(ip));
		}
		
		return op;
	}

}

class KickDealerTask implements Runnable {

	private IP_Ctrl1002 ip;
	public KickDealerTask(IP_Ctrl1002 ip) {
		this.ip = ip;
	}
	
	@Override
	public void run() {
		IP_CtrlDSTS1002 dip = new IP_CtrlDSTS1002();
		dip.setDealerName(ip.getDealerName());
		dip.setClientId(ip.getClientId());
		dip.setNewIPAddress(ip.getIpAddress());
		
		String[] dstsNames = StaticContext.getConfigCaptain().getDstsNames();
		for (String serv : dstsNames) {
			StaticContext.getTradeCaptain().callTrade(serv, dip);
		}
	}
	
}