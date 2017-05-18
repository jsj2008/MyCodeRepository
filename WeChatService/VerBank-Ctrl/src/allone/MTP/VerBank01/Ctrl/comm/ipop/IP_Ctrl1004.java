package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * dealer kick client
 * @author admin
 *
 */
public class IP_Ctrl1004 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5200808659236496230L;
	private String aeid;
	private long forbiddenGapInMs;
	public String getAeid() {
		return aeid;
	}
	public void setAeid(String userName) {
		this.aeid = userName;
	}
	public long getForbiddenGapInMs() {
		return forbiddenGapInMs;
	}
	public void setForbiddenGapInMs(long forbiddenGapInMs) {
		this.forbiddenGapInMs = forbiddenGapInMs;
	}
	
	
}
