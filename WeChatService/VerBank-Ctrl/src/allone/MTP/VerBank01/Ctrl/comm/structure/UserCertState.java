package allone.MTP.VerBank01.Ctrl.comm.structure;

import java.io.Serializable;

public class UserCertState implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7514611424948960812L;
	private String applyId;
	private int certState;
	private String certStateDesc;
	private String serial;
	private String commonName;
	private String notBefore;
	private String notAfter;
	
	public String getApplyId() {
		return applyId;
	}
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}
	public int getCertState() {
		return certState;
	}
	public void setCertState(int certState) {
		this.certState = certState;
	}
	public String getCertStateDesc() {
		return certStateDesc;
	}
	public void setCertStateDesc(String certStateDesc) {
		this.certStateDesc = certStateDesc;
	}
	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	public String getCommonName() {
		return commonName;
	}
	public void setCommonName(String commonName) {
		this.commonName = commonName;
	}
	public String getNotBefore() {
		return notBefore;
	}
	public void setNotBefore(String notBefore) {
		this.notBefore = notBefore;
	}
	public String getNotAfter() {
		return notAfter;
	}
	public void setNotAfter(String notAfter) {
		this.notAfter = notAfter;
	}
	
	
}
