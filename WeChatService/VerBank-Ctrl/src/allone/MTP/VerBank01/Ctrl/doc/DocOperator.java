package allone.MTP.VerBank01.Ctrl.doc;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB1076;
import allone.MTP.VerBank01.TDB.comm.IPOP.OP_TDB1076;
import allone.MTP.VerBank01.comm.ServCallNameTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;
import allone.MTP.VerBank01.comm.datastruct.DB.OtherClientConfig;

class DocOperator {
	
	public OtherClientConfig[] loadOtherConfig() {
		IP_TDB1076 ip = new IP_TDB1076();
		OPFather opfather = StaticContext.getCadtsCaptain().trade(
				ServCallNameTable.SERV_VERBANK_TDB, ip);
		if (opfather.isSucceed()) {
			OP_TDB1076 op = (OP_TDB1076) opfather;
			return op.getList();
		}
		return null;
	}
}
