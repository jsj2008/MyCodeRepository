package allone.MTP.VerBank01.Ctrl.info.opt;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.push.send.SendCaptain;
import allone.MTP.VerBank01.comm.information.InforFather;
import allone.MTP.VerBank01.trade.comm.infor.Info_TRADESERV3001;

public class InfoOperator_TRADESERV3001 extends InfoOperatorFather {

	@Override
	public void dealWithInfo(InforFather infoFather) {
		Info_TRADESERV3001 info = (Info_TRADESERV3001) infoFather;

		switch (info.getPushType()) {
		case Info_TRADESERV3001.PUSH_TYPE_UNKNOW:
			break;
		case Info_TRADESERV3001.PUSH_TYPE_ALLUSER:
			sendToAllUser(info.getInfoContent());
			break;
		case Info_TRADESERV3001.PUSH_TYPE_GROUP:
			sendToGroups(info.getGroups(), info.getInfoContent());
			break;
		case Info_TRADESERV3001.PUSH_TYPE_USER:
			// 这个Aeid下的所有account
			String[] aeidArray = new String[] { info.getAeid() };
			sendToAeid(aeidArray, info.getInfoContent());
			break;
		case Info_TRADESERV3001.PUSH_TYPE_USER_LIST:
			// 这些Aeid下的所有account
			sendToAeid(info.getReceiveUsers(), info.getInfoContent());
			break;
		case Info_TRADESERV3001.PUSH_TYPE_ACCOUNT:
			String[] accountArray = new String[] { info.getAccountID() };
			sendToAccounts(accountArray, info.getInfoContent());
			break;
		case Info_TRADESERV3001.PUSH_TYPE_ACCOUNT_LIST:
			// 暂时不支持多用户发送
			break;

		}
	}

	private void sendToAllUser(String contentMessage) {
		SendCaptain.getInstance().sendToAllUser(contentMessage);
	}

	private void sendToGroups(String[] groups, String contentMessage) {
		SendCaptain.getInstance().sendToGroups(groups, contentMessage);
	}

	private void sendToAeid(String[] aeids, String contentMessage) {
		SendCaptain.getInstance().sendToAeids(aeids, contentMessage);
	}

	private void sendToAccounts(String[] accounts, String contentMessage) {
		SendCaptain.getInstance().sendToAccounts(accounts, contentMessage);
	}

}
