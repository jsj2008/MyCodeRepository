package api.base.message;


public interface ITradeResult {
	
	public int getState();
	public void setState(int value);
	
	public String getErrorCode();
	public void setErrorCode(String value);
	
	public String getMessage();
	public void setMessage(String value);
	
	public Exception getException();
	public void setException(Exception ex);
	
}
