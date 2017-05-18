package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl1001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl1001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.IP_CtrlCSTS1002;
import allone.MTP.VerBank01.Ctrl.util.CheckResult;
import allone.MTP.VerBank01.Ctrl.util.ControlUtil;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB3047;
import allone.MTP.VerBank01.TDB.comm.IPOP.OP_TDB3047;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;
import allone.MTP.VerBank01.comm.datastruct.CommDataInterface;
import allone.MTP.VerBank01.comm.datastruct.DB.UserLogin;
import allone.MTP.VerBank01.trade.comm.IPOP.IP_TRADESERV5018;
import allone.MTP.VerBank01.trade.comm.IPOP.IP_TRADESERV5048;
import allone.MTP.VerBank01.trade.comm.IPOP.OP_TRADESERV5018;
import allone.MTP.VerBank01.trade.comm.IPOP.OP_TRADESERV5048;

/**
 * 用户登陆
 * 
 * @author admin
 */
public class TradeCtrl1001 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl1001 ip = (IP_Ctrl1001) ipFather;
		OP_Ctrl1001 op = new OP_Ctrl1001(ip);
		CheckResult result = ControlUtil.checkVersion(ip.getVersion());
		if (!result.isSucceed()) {
			op.setResult(CommDataInterface.USERIDENTIFY_RESULT_ERR_VERSION);
			op.setSucceed(true);
			op.setErrMessage(result.getMessage());
			return op;
		}

		login(ip, op);
		op.setLoginTime(System.currentTimeMillis());

		if (op.isSucceed()) {
			runTask(new KickUserTask(ip));
		}

		return op;
	}

	private void login(IP_Ctrl1001 ip, OP_Ctrl1001 op) {
		IP_TRADESERV5018 tip5018 = new IP_TRADESERV5018();
		tip5018.setUserName(ip.getAeid());
		OPFather opf = StaticContext.getTradeCaptain().callTrade(tip5018);
		if (!opf.isSucceed()) {
			op.setSucceed(false);
			op.setErrCode(opf.getErrCode());
			op.setErrMessage(opf.getErrMessage());
			return;
		}

		// 得到userlogin
		UserLogin userLogin = ((OP_TRADESERV5018) opf).getUserLogin();

		// 如果UserLogin不存在，则不存在此用户
		if (userLogin == null) {
			op.setSucceed(true);
			op.setResult(CommDataInterface.USERIDENTIFY_RESULT_ERR_USER_NOT_FOUND);
			op.setErrCode(IPOPErrCodeTable.ERR_UserNotFound);
			op.setErrMessage("TradeCtrl1001: Login err,user not find!" + ip.getAeid());
			return;
			// 如果用户已经disable,则不让登陆
		} else if (userLogin.getDisabled() == CommDataInterface.TRUE) {
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_UserDisabled);
			op.setErrMessage("TradeCtrl1001: Login err,user disabled!" + ip.getAeid());
			return;
			// 用户名是否相同
		} else if (userLogin.getUserName() != null && !userLogin.getAeid().equals(ip.getAeid())) {
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_UserNameNotMatch);
			op.setErrMessage("TradeCtrl1001: Login err,user name err!User name = " + ip.getAeid());
			return;
		}
		// 检查登陆密码是否正确
		// 全部检查完毕后,认为此用户登陆验证工作完毕,开始填入数据
		// 先填入ip fix数据
		if (userLogin.getIpFixed() == CommDataInterface.TRUE) {
			op.setFixedIPVector(userLogin.getIpList().split(CommDataInterface.LIST_SEPERATOR));
		}
		// 设置最大在线用户数
		if (!checkPassword(ip, op)) {
			return;
		}

		// 查询该用户的所有账户信息
		queryAllAccount(ip, op);

		op.setSucceed(true);
	}

	/**
	 * 检查密码,如果正确,同时植入密码是否要修改信息. 如果错误,则直接将err写入op true则正确 false则错误
	 * 
	 * @param ip
	 * @param op
	 * @return
	 */
	private boolean checkPassword(IP_Ctrl1001 ip, OP_Ctrl1001 op) {
		IP_TDB3047 tip = new IP_TDB3047();
		tip.setAeid(ip.getAeid());
		tip.setPassword(ip.getPassword());
		tip.setUserName(ip.getUserName());
		OPFather opfather = StaticContext.getTradeCaptain().callTrade(tip);
		if (!opfather.isSucceed()) {
			op.setErrCode(opfather.getErrCode());
			op.setErrMessage("Check password failed!DB Err msg=" + opfather.getErrMessage());
			op.setSucceed(false);
			return false;
		}
		OP_TDB3047 top = (OP_TDB3047) opfather;
		op.setResult(top.getChecktype());
		op.setPasswordNeedChange(top.getLoginPassNeedChange() == CommDataInterface.TRUE);
		op.setUserNameNeedChange(top.getUserNameNeedChange() == CommDataInterface.TRUE);
		return true;
	}

	private void queryAllAccount(IP_Ctrl1001 ip, OP_Ctrl1001 op) {
		IP_TRADESERV5048 tip = new IP_TRADESERV5048();
		tip.setSearchType(IP_TRADESERV5048.TYPE_BY_AEID);
		tip.setAeid(ip.getAeid());
		OPFather opfather = StaticContext.getTradeCaptain().callTrade(tip);
		if (!opfather.isSucceed()) {
			op.setErrCode(opfather.getErrCode());
			op.setErrMessage("query account failed!Err msg=" + opfather.getErrMessage());
			op.setSucceed(false);
			return;
		}

		OP_TRADESERV5048 top = (OP_TRADESERV5048) opfather;
		op.setAccountList(top.getAccountBasicVec());
	}
}

class KickUserTask implements Runnable {

	private IP_Ctrl1001 ip;

	public KickUserTask(IP_Ctrl1001 ip) {
		this.ip = ip;
	}

	@Override
	public void run() {
		IP_CtrlCSTS1002 cip = new IP_CtrlCSTS1002();
		cip.setAeid(ip.getAeid());
		cip.setClientId(ip.getClientId());
		cip.setNewIPAddress(ip.getIpAddress());

		String[] cstsNames = StaticContext.getConfigCaptain().getCstsNames();
		for (String serv : cstsNames) {
			StaticContext.getTradeCaptain().callTrade(serv, cip);
		}
	}

}
