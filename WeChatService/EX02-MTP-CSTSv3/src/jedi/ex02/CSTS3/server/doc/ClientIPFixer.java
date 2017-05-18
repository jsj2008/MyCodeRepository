package jedi.ex02.CSTS3.server.doc;

import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5026;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5027;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5028;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5061;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5062;

public class ClientIPFixer {

	public static boolean forcedToFixIP(IPFather ipfather,String aeid) {
		if (ipfather.get_ID().equals("TRADESERV5061")) {
			IP_TRADESERV5061 ip = (IP_TRADESERV5061) ipfather;
			ip.setAeid(aeid);
		}else if (ipfather.get_ID().equals("TRADESERV5026")) {
			IP_TRADESERV5026 ip = (IP_TRADESERV5026) ipfather;
			ip.setAeid(aeid);
		}else if (ipfather.get_ID().equals("TRADESERV5027")) {
			IP_TRADESERV5027 ip = (IP_TRADESERV5027) ipfather;
			ip.setAeid(aeid);
		}else if (ipfather.get_ID().equals("TRADESERV5028")) {
			IP_TRADESERV5028 ip = (IP_TRADESERV5028) ipfather;
			ip.setAeid(aeid);
		}else if (ipfather.get_ID().equals("TRADESERV5062")) {
			IP_TRADESERV5062 ip = (IP_TRADESERV5062) ipfather;
			ip.setAeid(aeid);
		}
		return true;
	}
	
}
