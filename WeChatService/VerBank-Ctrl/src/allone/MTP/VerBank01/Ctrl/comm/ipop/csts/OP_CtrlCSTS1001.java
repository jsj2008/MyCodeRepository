package allone.MTP.VerBank01.Ctrl.comm.ipop.csts;

import java.util.ArrayList;

public class OP_CtrlCSTS1001 extends CtrlCSTSOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7643512250102075810L;
	private ArrayList<String> ipList = new ArrayList<String>();
	
	public OP_CtrlCSTS1001(CtrlCSTSIPFather ip) {
		super(ip);
	}

	public String[] getIpList() {
		return ipList.toArray(new String[0]);
	}

	public void addKickedIP(String ip) {
		ipList.add(ip);
	}
}
