package allone.MTP.VerBank01.Ctrl.comm.ipop.dsts;

import java.util.ArrayList;

public class OP_CtrlDSTS1001 extends CtrlDSTSOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6555700064549703419L;
	private ArrayList<String> ipList = new ArrayList<String>();
	public OP_CtrlDSTS1001(CtrlDSTSIPFather ip) {
		super(ip);
	}

	public String[] getIpList() {
		return ipList.toArray(new String[0]);
	}

	public void addKickedIP(String ip) {
		ipList.add(ip);
	}
}
