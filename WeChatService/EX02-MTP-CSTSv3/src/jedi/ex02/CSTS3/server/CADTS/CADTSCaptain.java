package jedi.ex02.CSTS3.server.CADTS;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.config.CSConfigCaptain;
import jedi.v7.comm.ServCallNameTable;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.information.InforFather;
import jedi.v7.quote.common.QuoteData;
import allone.Log.simpleLog.log.LogProxy;

public class CADTSCaptain extends allone.CADTS.proxy.SimpleCADTSProxy {

	public boolean init() {
		CSConfigCaptain cfg = StaticContext.getCSConfigCaptain();
		this.init(cfg.getCADTSIp(), cfg.getCADTSCmdPort(), cfg.getCADTSDataPort(), cfg.getCADTSServName(), cfg.getCstsName());
		System.out.println(cfg.getCADTSIp() + cfg.getCADTSCmdPort() + cfg.getCADTSDataPort() + cfg.getCADTSServName() + cfg.getCstsName());
		this.getPingCaptain().initCmd(2 * 1000, 3, 10 * 1000);
		return true;
	}

	//receiveTrade
	public Object receiveCMD(String fromServ, String funName, String dataName, Object data) throws Exception {

		return StaticContext.getTradeCaptain().doCADTSTrade(fromServ, (IPFather) data);
	}

	//receiveInfo QuoteData
	public void receiveData(String fromServ, String funName, String dataName, Object data) {
		try {
//			QuoteData[] quoteDatas = QuoteSourceCaptain.getInstance().getQuoteVec();
//			for (int i = 0; i<quoteDatas.length; i++) {
//				QuoteData data2 = quoteDatas[i];
//				StaticContext.getCSTSDoc().sendQuote(data2);
//				System.out.println(data2.getInstrument());
//			}
//			StaticContext.getCSTSDoc().sendQuote(quoteDatas);
			
			if (data instanceof QuoteData[]) {
				if (fromServ.equals(ServCallNameTable.SERV_MTP4_QG)) {
					StaticContext.getCSTSDoc().sendQuote(data);
				}
			} else if (funName.equals(ServCallNameTable.FUN_MTP4_INFO)) {
				InforFather info = (InforFather) data;
				C3_InfoFather cstsInfo = StaticContext.getInforCaptain().formatInfor(info);
				if (cstsInfo == null) {
					return;
				}
				
//				if (cstsInfo.getID().equals("TRADESERV1016")) {
//					return;
//				}
				
				switch (info.getReceiverType()) {
					case InforFather.RECEIVER_TYPE_SERVER:
						break;
					case InforFather.RECEIVER_TYPE_ALLUSER:
						StaticContext.getCSTSDoc().sendInfoToAll(cstsInfo);
						break;
					case InforFather.RECEIVER_TYPE_GROUP:
						StaticContext.getCSTSDoc().sendInfor(info.getGroups(), cstsInfo);
						break;
					case InforFather.RECEIVER_TYPE_USER:
						StaticContext.getCSTSDoc().sendInfor(info.getAeid(), cstsInfo);
						break;
					case InforFather.RECEIVER_TYPE_USER_LIST:
						StaticContext.getCSTSDoc().sendInforToUserList(info.getReceiveUsers(), cstsInfo);
						break;
				}
				if (!cstsInfo.getID().equals("TRADESERV1016")) {
					LogProxy.printTrade(cstsInfo.getID(), cstsInfo, null, true);
				}
			}
		} catch (Exception e) {
			LogProxy.printException(e);
		}
	}

}
