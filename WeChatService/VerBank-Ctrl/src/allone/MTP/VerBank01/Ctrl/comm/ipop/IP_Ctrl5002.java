package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class IP_Ctrl5002 extends CtrlServerIPFather {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3221147337100117088L;
	private long account;
	private int level;
	private String tradeDay;
	public long getAccount() {
		return account;
	}
	public void setAccount(long account) {
		this.account = account;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getTradeDay() {
		return tradeDay;
	}
	public void setTradeDay(String tradeDay) {
		this.tradeDay = tradeDay;
	}
	
	
}
