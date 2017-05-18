package allone.register.server.trade.api;

import jedi.v7.bankserver.comm.type.BankCertTypeList;
import system.comm.CommDataInterface;
import allone.Log.simpleLog.log.LogProxy;
import allone.register.server.cadts.CADTSCaptain;
import allone.register.server.config.ConfigCaptain;
import allone.register.server.doc.DocCaptain;
import allone.register.server.trade.api.message.RegistResponse;
import ex.v01.exchange.comm.CommDataInterface4EX;
import ex.v01.exchange.comm.OPFather4EX;
import ex.v01.exchange.comm.ipop.IP_EX5901;
import ex.v01.exchange.comm.ipop.OP_EX5901;
import ex.v01.exchange.comm.struct.cloud.CloudRegistInformation;

public class ECRServerAPI {
	private static ECRServerAPI instance = new ECRServerAPI();

	public static ECRServerAPI getInstance(){
		return instance;
	}

	public RegistResponse register(String aeid, String password, int marketId, int ibAccount) {
		IP_EX5901 ip5901 = new IP_EX5901();
		OPFather4EX op = null;
		RegistResponse response = new RegistResponse();

		if (aeid == null || aeid.length() == 0) {
			response.setSuccess(false);
			response.setResponseCode("1000");
			response.setResponseMessage("Aeid is null");
			return response;
		}
		
		if (password == null || password.length() == 0) {
			response.setSuccess(false);
			response.setResponseCode("1001");
			response.setResponseMessage("Pwd is null");
			return response;
		}
		
		try {
			ip5901.setInformation(initInformation(aeid, password, marketId, ibAccount, CommDataInterface.USERINFOCONFIRM_COMMANDTYPE_ADD));
			op = CADTSCaptain.getInstance().doEXTrade(ip5901);
			if (op instanceof OP_EX5901) {
				OP_EX5901 op5901 = (OP_EX5901) op;
				// 返回结果
				response.setSuccess(op5901.isSucceed());
				response.setResponseCode(op5901.getErrCode());
				response.setResponseMessage(op5901.getErrMessage());
			}
		} catch (Exception e) {
			LogProxy.printException(e);
			response.setSuccess(false);
			response.setResponseMessage("Trade Exception");
		}
		if (op != null) {
			LogProxy.printTrade(ip5901.get_ID(), ip5901, op, op.isSucceed());
		}
		return response;
	}

	private CloudRegistInformation initInformation(String aeid, String password, int marketId, int ibAccount, int commandType) throws Exception {
		CloudRegistInformation information = new CloudRegistInformation();

		if (marketId == 0) {
			marketId = ConfigCaptain.getInstance().getMarketId();
		}

		String userGroup = ConfigCaptain.getInstance().getUserGroup();

		information.setMarketId(marketId);
		information.setMarketSysId(1);
		information.setCommandId(DocCaptain.getInstance().getNextStreamId());
		information.setCommandType(commandType);
		information.setPassword(password);	
		information.setUserType(CommDataInterface.USER_TYPE_NORMAL);
		information.setRealName(aeid);
		information.setEmail("");
		information.setPhoneNo("");
		information.setRegestDealer("System");
		information.setGroupName(marketId + "@" +userGroup);
		information.setAccType(CommDataInterface.AccountType_Normal);
		information.setIBAccount(ibAccount);
		information.setBasicCurrency("CNY");
		information.setCertificationType(BankCertTypeList.ID_CARD);	
		information.setCertificationId("0");	
		information.setAeid(aeid);
		information.setBankAcctName("0");
		information.setBankAcctNo("0");
		information.setAeidType(CommDataInterface4EX.AEIDTYPE_CLOUD);
		return information;
	}
}
