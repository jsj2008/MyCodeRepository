package allone.MTP.VerBank01.Ctrl.ca;

public class CASignException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = -332318105496320877L;
	private int retCode;
	private String reason;
	
	public CASignException(String reason) {
		this.reason = reason;
	}
	
	public CASignException(int retCode, String reason) {
		this.retCode = retCode;
		this.reason = reason;
	}
	
	public int getRetCode() {
		return retCode;
	}

	public String getReason() {
		return reason;
	}
	
}
