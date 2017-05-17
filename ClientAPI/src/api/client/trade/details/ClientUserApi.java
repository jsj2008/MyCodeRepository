package api.client.trade.details;

import api.base.message.ITradeResult;
import api.base.message.result.TradeResult;
import api.client.network.ClientNetCaptain;
import api.client.trade.base.TradeApiBase;

import comm.db.User;
import comm.message.IP_Client1001;
import comm.message.OPFather;
import comm.message.OP_Client1001;

public class ClientUserApi extends TradeApiBase {

	// private int fundId;
	private String userName;
	private String password;
	// private boolean isFirstLogin = true;
	private boolean isLogined = false;

	// private HashMap<String, Integer> functionMap = new HashMap<String,
	// Integer>();

	public ClientUserApi() {
	}

	public void setIsLogined(boolean value) {
		this.isLogined = value;
	}

	public boolean getIsLogined() {
		return this.isLogined;
	}

	public String getUserName() {
		return userName;
	}

	// public int getFundId() {
	// return this.fundId;
	// }

	public ITradeResult login(String userName, String password) {
		this.userName = userName;
		this.password = password;
		// this.cryptPassword = Crypt.encryptALLONE(password, dealerName);
		return this.doLogin(this.userName, this.password);
	}

	// public ITradeResult relogin() {
	// return this.doLogin(this.fundId, this.dealerName, this.cryptPassword);
	// }

	private ITradeResult doLogin(String userName, String password) {
		ITradeResult tradeResult = new TradeResult();
		IP_Client1001 ip = new IP_Client1001();
		User user = new User();
		user.setUserName(userName);
		user.setPassword(password);
		ip.setUser(user);

		OPFather opFather = ClientNetCaptain.getInstance().doTrade(ip);
		if (!(opFather instanceof OP_Client1001)) {
			tradeResult.setState(-1);
			tradeResult.setMessage("TradeError: " + opFather.toString());
			return tradeResult;
		}
		return tradeResult;
	}
	//
	// OP_Dealer5001 op = (OP_Dealer5001) opFather;
	// if (op.isSucceed() == false) {
	// tradeResult.setState(op.getResult());
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// Dealer dealer = op.getDealer();
	// DealerRole dealerRole = op.getDealerRole();
	// this.getDealerCache().setDealer(dealer);
	// this.getDealerCache().setDealerRole(dealerRole);
	// this.resetFunctionMap();
	//
	// this.isFirstLogin = (op.getResult() ==
	// FundDataTypeDefine.LOGIN_RESULT_SUCCEED);
	// this.isLogined = (op.getResult() ==
	// FundDataTypeDefine.LOGIN_RESULT_SUCCEED);
	//
	// tradeResult.setState(op.getResult());
	// tradeResult.setErrorCode(op.getErrCode());
	// tradeResult.setMessage(op.getErrMessage());
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.LOGIN_RESULT_ERR_EXCEPTION);
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryPartenerInfo() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer6002 ip = new IP_Dealer6002();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer6002)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer6002 op = (OP_Dealer6002) opFather;
	// if (op.isSucceed() == false) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// if (!this.getFundSystemCache()._updatePartners(op.getPartners())) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_CACHE_ERROR);
	// tradeResult.setMessage("set partners to cache failed.");
	// return tradeResult;
	// }
	//
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryPartenerDealingInfo() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer6004 ip = new IP_Dealer6004();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer6004)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer6004 op = (OP_Dealer6004) opFather;
	// if (op.isSucceed() == false) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// if
	// (!this.getFundSystemCache()._updatePartnerDealing(op.getFundPartners()))
	// {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_CACHE_ERROR);
	// tradeResult.setMessage("set partnerDealing to cache failed.");
	// return tradeResult;
	// }
	//
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult commitNewPartner(FundPartner fundPartner) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer6001 ip = new IP_Dealer6001();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	// ip.setFundPartner(fundPartner);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer6001)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer6001 op = (OP_Dealer6001) opFather;
	// if (op.isSucceed() == false) {
	// tradeResult.setState(op.getResult());
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// // 新建的Partnre未经过审核 应该不需要 加入本地缓存 注释 //By ZL
	// // if (!this.getFundSystemCache().addPartner(fundPartner)) {
	// // tradeResult.setState(FundDataTypeDefine.FUND_TRADE_CACHE_ERROR);
	// // tradeResult.setMessage("set partner to cache failed.");
	// // return tradeResult;
	// // }
	//
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult commitModifyPartner(FundPartner fundPartner) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer6003 ip = new IP_Dealer6003();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	// ip.setFundPartner(fundPartner);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer6003)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer6003 op = (OP_Dealer6003) opFather;
	// if (op.isSucceed() == false) {
	// tradeResult.setState(op.getResult());
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// //修改的Partner 未经过审核 应该不需要 加入本地缓存 注释 //By ZL
	// // if (!this.getFundSystemCache().addPartner(fundPartner)) {
	// // tradeResult.setState(FundDataTypeDefine.FUND_TRADE_CACHE_ERROR);
	// // tradeResult.setMessage("set partner to cache failed.");
	// // return tradeResult;
	// // }
	//
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryFundProfile() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4400 ip = new IP_Dealer4400();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4400)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4400 op = (OP_Dealer4400) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// getFundSystemCache()._setFundProfile(op.getFundProfile());
	// getFundSystemCache().setVipFundMiniInfor(op.getVipFundMiniInfors());
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryFundBank() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4401 ip = new IP_Dealer4401();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4401)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4401 op = (OP_Dealer4401) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	// getFundSystemCache()._updateFundBank(op.getFundBankList().toArray(new
	// FundBank[0]));
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryFundAccount() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4402 ip = new IP_Dealer4402();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4402)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4402 op = (OP_Dealer4402) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	// getFundSystemCache()._updateFundAccount(op.getFundAccountList().toArray(new
	// FundVirtualAccount[0]));
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult setFundVirtualAccount(FundVirtualAccount[]
	// virAccounts) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4410 ip = new IP_Dealer4410();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	// ip.setVirtualAccounts(virAccounts);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4410)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4410 op = (OP_Dealer4410) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	//
	// this.getFundSystemCache()._updateFundAccount(virAccounts);
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryProfitPercent() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4501 ip = new IP_Dealer4501();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4501)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4501 op = (OP_Dealer4501) opFather;
	// if (!op.isSucceed()) {
	// // tradeResult.setState(op.getResult());
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	// getFundSystemCache()._updateFundProfitPercent(op.getFundProfitPercents());
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult commitProfitPercent(FundProfitPercent[] datas) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4502 ip = new IP_Dealer4502();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	// ip.setFundProfitPercents(datas);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4502)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4502 op = (OP_Dealer4502) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryFundDealer() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4503 ip = new IP_Dealer4503();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4503)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4503 op = (OP_Dealer4503) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	// getFundSystemCache()._updateFundDealer(op.getDealers());
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult queryFundDealerRole() {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4504 ip = new IP_Dealer4504();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4504)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// OP_Dealer4504 op = (OP_Dealer4504) opFather;
	// if (!op.isSucceed()) {
	// tradeResult.setMessage(op.getErrMessage());
	// tradeResult.setErrorCode(op.getErrCode());
	// return tradeResult;
	// }
	// getFundSystemCache()._updateFundDealerRole(op.getDealerRoles());
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult modifyOrCreateFundDealer(int commitType, Dealer
	// dealer, String password) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4505 ip = new IP_Dealer4505();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// ip.setCommitType(commitType);
	// ip.setDealer(dealer);
	// ip.setPassword(Crypt.encryptALLONE(password, dealer.getDealerName()));
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4505)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// if (!opFather.isSucceed()) {
	// tradeResult.setMessage(opFather.getErrMessage());
	// tradeResult.setErrorCode(opFather.getErrCode());
	// return tradeResult;
	// }
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult modifyOrCreateFundDealerRole(int commitType,
	// DealerRole dealerRole) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4507 ip = new IP_Dealer4507();
	// ip.setFundId(this.fundId);
	// dealerRole.setFundId(this.fundId);
	// ip.setDealerRole(dealerRole);
	// ip.setCommitType(commitType);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4507)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// if (!opFather.isSucceed()) {
	// tradeResult.setMessage(opFather.getErrMessage());
	// tradeResult.setErrorCode(opFather.getErrCode());
	// return tradeResult;
	// }
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult deleteFundDealerRole(String deleteRoleName, String
	// replaceRoleName) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4508 ip = new IP_Dealer4508();
	// ip.setFundId(this.fundId);
	// ip.setDeleteDealerRoleName(deleteRoleName);
	// ip.setReplaceDealerRoleName(replaceRoleName);
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4508)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// if (!opFather.isSucceed()) {
	// tradeResult.setMessage(opFather.getErrMessage());
	// tradeResult.setErrorCode(opFather.getErrCode());
	// return tradeResult;
	// }
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public ITradeResult modifyFundDealerPassword(String dealerName, String
	// password) {
	// ITradeResult tradeResult = new TradeResult();
	// try {
	// IP_Dealer4506 ip = new IP_Dealer4506();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	// ip.setFundDealerName(dealerName);
	// ip.setPassword(Crypt.encryptALLONE(password, dealerName));
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4506)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// if (!opFather.isSucceed()) {
	// tradeResult.setMessage(opFather.getErrMessage());
	// tradeResult.setErrorCode(opFather.getErrCode());
	// return tradeResult;
	// }
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// public TR_QueryFundIDByVIPFund queryFundIDByVipFundID() {
	// TR_QueryFundIDByVIPFund tradeResult = new TR_QueryFundIDByVIPFund();
	// try {
	// IP_Dealer4606 ip = new IP_Dealer4606();
	// ip.setFundId(this.fundId);
	// ip.setDealerName(this.dealerName);
	//
	// OPFundFather opFather = FundNetCaptain.getInstance().doTrade(ip);
	// if (!(opFather instanceof OP_Dealer4606)) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_INVALID_OP);
	// tradeResult.setMessage("TradeError: " + opFather.toString());
	// return tradeResult;
	// }
	//
	// if (!opFather.isSucceed()) {
	// tradeResult.setMessage(opFather.getErrMessage());
	// tradeResult.setErrorCode(opFather.getErrCode());
	// return tradeResult;
	// }
	// OP_Dealer4606 op = (OP_Dealer4606) opFather;
	// tradeResult.setFundIDs(op.getFundIds());
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_SUCCESS);
	// return tradeResult;
	// } catch (Exception ex) {
	// tradeResult.setState(FundDataTypeDefine.FUND_TRADE_ERROR);
	// tradeResult.setMessage(ex.getMessage());
	// tradeResult.setException(ex);
	// return tradeResult;
	// }
	// }
	//
	// private void resetFunctionMap() {
	// String function = this.getDealerCache().getDealerRole().getFunctions();
	// if (function != null) {
	// function = function.trim();
	// if (!function.equals("")) {
	// String[] permission = function.split(";");
	// if (permission.length > 0) {
	// for (String item : permission) {
	// String[] key = item.split("\\(");
	// functionMap.put(key[0], 0);
	// }
	// }
	// }
	// }
	// }
	//
	// public boolean checkFunctionLevel(String permission) {
	// // is Super
	// if (this.getDealerCache().getDealerRole().getRoleType() == 0) {
	// return true;
	// }
	// if (functionMap.containsKey(permission)) {
	// return true;
	// }
	// return false;
	// }
}
