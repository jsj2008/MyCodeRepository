package allone.MTP.VerBank01.Ctrl.ca.check;


public enum CertState {

	CERT_OK(0, CSHelper.desc("0")),
	CERT_READY_FOR_RETURN(10, CSHelper.desc("10")),
	CERT_APPLICATE_FAILED(11, CSHelper.desc("11")),
	CERT_READY_FOR_DOWNLOAD(12, CSHelper.desc("12")),
	CERT_WAIT_FOR_AUDIT(13, CSHelper.desc("13")),
	CERT_CANCEL(20, CSHelper.desc("20")),
	CERT_EXPIRED(30, CSHelper.desc("30")),
	CERT_TO_BE_EXPIRED(31, CSHelper.desc("31")),
	CERT_NOT_FOUND(40, CSHelper.desc("40")),
	CERT_SUSPEND(50, CSHelper.desc("50")),
	CERT_REGISTER_ONLINE(60, CSHelper.desc("60")),
	CERT_REGISTER_ON_COUNTER(61, CSHelper.desc("61")),
	CERT_REGISTER_CANCELED(62, CSHelper.desc("62")),
	CERT_REGISTER_EXPIRED(63, CSHelper.desc("63")),
	;
	
	private CertState(int code, String desc) {
		this.code = code;
		this.desc = desc;
	}
	
	private int code;
	private String desc;
	
	public int getCode() {
		return code;
	}
	public String getDesc() {
		return desc;
	}
	
	
}
