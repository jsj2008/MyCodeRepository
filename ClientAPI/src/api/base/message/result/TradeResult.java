package api.base.message.result;

import api.base.message.ITradeResult;

public class TradeResult implements ITradeResult {

	private int resultState = -1;
	private String errorCode;
	private String errorMessag;
	private Exception exception;

	@Override
	public int getState() {
		return this.resultState;
	}

	@Override
	public void setState(int value) {
		this.resultState = value;
	}

	@Override
	public String getErrorCode() {
		return this.errorCode;
	}

	@Override
	public void setErrorCode(String value) {
		this.errorCode = value;
	}

	@Override
	public String getMessage() {
		return this.errorMessag;
	}

	@Override
	public void setMessage(String value) {
		this.errorMessag = value;
	}

	@Override
	public Exception getException() {
		return this.exception;
	}

	@Override
	public void setException(Exception ex) {
		this.exception = ex;
	}

}
