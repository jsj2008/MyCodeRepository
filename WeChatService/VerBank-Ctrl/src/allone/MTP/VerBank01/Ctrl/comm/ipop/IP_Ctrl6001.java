package allone.MTP.VerBank01.Ctrl.comm.ipop;

import allone.MTP.VerBank01.comm.datastruct.DB.GlDetails;

public class IP_Ctrl6001 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4026682779717617728L;
	private GlDetails[] obuDetails;
	private GlDetails[] dbuDetails;
	public GlDetails[] getObuDetails() {
		return obuDetails;
	}
	public void setObuDetails(GlDetails[] obuDetails) {
		this.obuDetails = obuDetails;
	}
	public GlDetails[] getDbuDetails() {
		return dbuDetails;
	}
	public void setDbuDetails(GlDetails[] dbuDetails) {
		this.dbuDetails = dbuDetails;
	}
	
}
