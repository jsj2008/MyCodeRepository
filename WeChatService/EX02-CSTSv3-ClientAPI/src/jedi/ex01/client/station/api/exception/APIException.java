package jedi.ex01.client.station.api.exception;

public class APIException extends Exception {
	
	private static final long serialVersionUID = 6803021127765807899L;
	
	private String errCode;
	private String errMessage;
	public APIException(String errCode,String errMessage){
		super();
		this.errCode=errCode;
		this.errMessage=errMessage;
	}
	public String getErrCode() {
		return errCode;
	}
	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}
	public String getErrMessage() {
		return errMessage;
	}
	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}
}
