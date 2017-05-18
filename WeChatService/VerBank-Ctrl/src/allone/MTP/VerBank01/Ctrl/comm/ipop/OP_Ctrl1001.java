package allone.MTP.VerBank01.Ctrl.comm.ipop;

import allone.MTP.VerBank01.comm.datastruct.AccountBasic;

public class OP_Ctrl1001 extends CtrlServerOPFather {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6677802243627921087L;
	private boolean passwordNeedChange;
	private boolean userNameNeedChange;
	private String[] fixedIPVector;
	private int result;
	private long loginTime = -1;
    private AccountBasic accountList[];
    private int certState;
    private String certStateDesc;
    
	public OP_Ctrl1001(CtrlServerIPFather ip) {
		super(ip);
	}

	public boolean isPasswordNeedChange() {
		return passwordNeedChange;
	}

	public void setPasswordNeedChange(boolean passwordNeedChange) {
		this.passwordNeedChange = passwordNeedChange;
	}

	public boolean isUserNameNeedChange() {
		return userNameNeedChange;
	}

	public void setUserNameNeedChange(boolean userNameNeedChange) {
		this.userNameNeedChange = userNameNeedChange;
	}

	public String[] getFixedIPVector() {
		return fixedIPVector;
	}

	public void setFixedIPVector(String[] fixedIPVector) {
		this.fixedIPVector = fixedIPVector;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public long getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(long loginTime) {
		this.loginTime = loginTime;
	}

	public AccountBasic[] getAccountList() {
		return accountList;
	}

	public void setAccountList(AccountBasic[] accountList) {
		this.accountList = accountList;
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

	
}
