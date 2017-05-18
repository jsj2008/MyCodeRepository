package allone.MTP.VerBank01.Ctrl.comm.ipop.csts;

/**
 * 系统踢出用户
 * @author admin
 *
 */
public class IP_CtrlCSTS1001 extends CtrlCSTSIPFather {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1256228864657966664L;
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
