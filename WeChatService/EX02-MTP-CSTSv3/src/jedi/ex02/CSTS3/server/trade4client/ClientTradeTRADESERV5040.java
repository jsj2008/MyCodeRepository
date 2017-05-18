package jedi.ex02.CSTS3.server.trade4client;

import java.util.HashMap;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_TRADESERV5040;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5040;
import jedi.ex02.CSTS3.comm.struct.C3_AccountStrategy;
import jedi.ex02.CSTS3.comm.struct.C3_GroupConfig;
import jedi.ex02.CSTS3.comm.struct.C3_Instrument;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.DB.AccountStrategy;
import jedi.v7.comm.datastruct.DB.GroupConfig;
import jedi.v7.comm.datastruct.DB.Instrument;
import jedi.v7.comm.datastruct.DB.InstrumentsAccountCfg;
import jedi.v7.comm.datastruct.DB.InstrumentsGroupCfg;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5013;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5013;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5040;

public class ClientTradeTRADESERV5040 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid,
			String ipaddress) {
		C3_IP_TRADESERV5040 ip = (C3_IP_TRADESERV5040) _ip;
		C3_OP_TRADESERV5040 op = new C3_OP_TRADESERV5040(ip);
		HashMap<String, C3_Instrument> instMap=new HashMap<String, C3_Instrument>();
		IPFather fip = ip.formatIP();
		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip,
				aeid, ipaddress);
		try {
			if (fop.isSucceed()) {
				op.parseFromSysData((OP_TRADESERV5040) fop);
			} else {
				op.parseFromSysData(fop);
			}
			if (fop.isSucceed()) {
				OP_TRADESERV5040 op5040 = (OP_TRADESERV5040) fop;
				AccountStrategy[] accounts=op5040.getAccountStrategyVec();
				for (AccountStrategy accountStrategy : accounts) {
					if(accountStrategy.getAccount()==ip.getAccountID()){
						C3_AccountStrategy account=new C3_AccountStrategy();
						account.parseFromSysData(accountStrategy);
						op.setAccountStrategy(account);
					}
				}
				GroupConfig[] groups=op5040.getGroupConfigVec();
				for (GroupConfig groupConfig : groups) {
					if(groupConfig.getGroupName().equals(op.getAccountStrategy().getGroupName())){
						C3_GroupConfig group=new C3_GroupConfig();
						group.parseFromSysData(groupConfig);
						op.setGroupConfig(group);
					}
				}
				////////////////////
				IP_TRADESERV5013 ip5013 = new IP_TRADESERV5013();
				fop=StaticContext.getClientTradeCaptain().doSysTrade(ip5013, aeid, ipaddress);
				if(fop.isSucceed()){
					OP_TRADESERV5013 op5013 = (OP_TRADESERV5013) fop;
					for (Instrument	 data : op5013.getInstrumentVec()) {
						C3_Instrument inst=new C3_Instrument();
						inst.parseFromSysData(data);
						instMap.put(inst.getInstrument(), inst);
					}
					for (InstrumentsGroupCfg igc : op5040.getInstrumentGroupCfgVec()) {
						if(!igc.getGroupName().equalsIgnoreCase(op.getAccountStrategy().getGroupName())){
							continue;
						}
						C3_Instrument inst=instMap.get(igc.getInstrument());
						inst.parseFromSysData(igc);
					}
					for (InstrumentsAccountCfg iac : op5040.getInstrumentAccountCfgVec()) {
						if(iac.getAccount()!=ip.getAccountID()){
							continue;
						}
						C3_Instrument inst=instMap.get(iac.getInstrument());
						inst.parseFromSysData(iac);
					}
					op.setInstrumentVec(instMap.values().toArray(new C3_Instrument[0]));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		op.setSucceed(fop.isSucceed());
		op.setErrCode(fop.getErrCode());
		op.setErrMessage(fop.getErrMessage());
		return op;
	}

}
