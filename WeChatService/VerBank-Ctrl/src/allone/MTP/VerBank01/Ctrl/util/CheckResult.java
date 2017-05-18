package allone.MTP.VerBank01.Ctrl.util;

public class CheckResult {

	private boolean succeed;
	private String message;

	public CheckResult caculate(boolean succeed) {
		return caculate(succeed, "");
	}

	public CheckResult caculate(boolean succeed, String message) {
		this.succeed = succeed;
		this.message = message;
		return this;
	}

	public boolean isSucceed() {
		return succeed;
	}

	public void setSucceed(boolean succeed) {
		this.succeed = succeed;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
