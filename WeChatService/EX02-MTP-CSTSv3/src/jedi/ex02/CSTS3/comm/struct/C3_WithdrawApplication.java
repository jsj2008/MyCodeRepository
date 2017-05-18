package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.WithdrawApplication;

public class C3_WithdrawApplication extends allone.json.AbstractJsonData {

	public static final String jsonId = "27";

	public static final String guid = "1";
	public static final String type = "2";
	public static final String account = "3";
	public static final String currency = "4";
	public static final String amount = "5";
	public static final String appTime = "6";
	public static final String ipAddress = "7";
	public static final String bankAccount = "8";
	public static final String bankName = "9";
	public static final String accountName = "10";
	public static final String bankAddress = "11";
	public static final String internationalCode = "12";
	public static final String description = "13";
	public static final String dealer = "14";
	public static final String dealerIp = "15";
	public static final String isRead = "16";
	public static final String readTime = "17";

	public C3_WithdrawApplication(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(WithdrawApplication data) throws Exception {
		setGuid(data.getGuid());
		setType(data.getType());
		setAccount(data.getAccount());
		setCurrency(data.getCurrency());
		setAmount(data.getAmount());
		setAppTime(data.getAppTime());
		setIpAddress(data.getIpAddress());
		setBankAccount(data.getBankAccount());
		setBankName(data.getBankName());
		setAccountName(data.getAccountName());
		setBankAddress(data.getBankAddress());
		setInternationalCode(data.getInternationalCode());
		setDescription(data.getDescription());
		setDealer(data.getDealer());
		setDealerIp(data.getDealerIp());
		setIsRead(data.getIsRead());
		setReadTime(data.getReadTime());
	}

	public WithdrawApplication format(){
		WithdrawApplication data=new WithdrawApplication();
		data.setGuid(getGuid());
		data.setType(getType());
		data.setAccount(getAccount());
		data.setCurrency(getCurrency());
		data.setAmount(getAmount());
		data.setAppTime(getAppTime());
		data.setIpAddress(getIpAddress());
		data.setBankAccount(getBankAccount());
		data.setBankName(getBankName());
		data.setAccountName(getAccountName());
		data.setBankAddress(getBankAddress());
		data.setInternationalCode(getInternationalCode());
		data.setDescription(getDescription());
		data.setDealer(getDealer());
		data.setDealerIp(getDealerIp());
		data.setIsRead(getIsRead());
		data.setReadTime(getReadTime());
		return data;
	}


	public String getGuid() {
		try {
			String data=getEntryString(C3_WithdrawApplication.guid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuid(String guid) {
		setEntry(C3_WithdrawApplication.guid, guid);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_WithdrawApplication.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_WithdrawApplication.type, type);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_WithdrawApplication.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_WithdrawApplication.account, account);
	}

	public String getCurrency() {
		try {
			String data=getEntryString(C3_WithdrawApplication.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(C3_WithdrawApplication.currency, currency);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(C3_WithdrawApplication.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_WithdrawApplication.amount, amount);
	}

	public Date getAppTime() {
		try {
			Date data=getEntryDate(C3_WithdrawApplication.appTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAppTime(Date appTime) {
		setEntry(C3_WithdrawApplication.appTime, appTime);
	}

	public String getIpAddress() {
		try {
			String data=getEntryString(C3_WithdrawApplication.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(C3_WithdrawApplication.ipAddress, ipAddress);
	}

	public String getBankAccount() {
		try {
			String data=getEntryString(C3_WithdrawApplication.bankAccount);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAccount(String bankAccount) {
		setEntry(C3_WithdrawApplication.bankAccount, bankAccount);
	}

	public String getBankName() {
		try {
			String data=getEntryString(C3_WithdrawApplication.bankName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankName(String bankName) {
		setEntry(C3_WithdrawApplication.bankName, bankName);
	}

	public String getAccountName() {
		try {
			String data=getEntryString(C3_WithdrawApplication.accountName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountName(String accountName) {
		setEntry(C3_WithdrawApplication.accountName, accountName);
	}

	public String getBankAddress() {
		try {
			String data=getEntryString(C3_WithdrawApplication.bankAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAddress(String bankAddress) {
		setEntry(C3_WithdrawApplication.bankAddress, bankAddress);
	}

	public String getInternationalCode() {
		try {
			String data=getEntryString(C3_WithdrawApplication.internationalCode);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInternationalCode(String internationalCode) {
		setEntry(C3_WithdrawApplication.internationalCode, internationalCode);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_WithdrawApplication.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_WithdrawApplication.description, description);
	}

	public String getDealer() {
		try {
			String data=getEntryString(C3_WithdrawApplication.dealer);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDealer(String dealer) {
		setEntry(C3_WithdrawApplication.dealer, dealer);
	}

	public String getDealerIp() {
		try {
			String data=getEntryString(C3_WithdrawApplication.dealerIp);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDealerIp(String dealerIp) {
		setEntry(C3_WithdrawApplication.dealerIp, dealerIp);
	}

	public int getIsRead() {
		try {
			int data=getEntryInt(C3_WithdrawApplication.isRead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsRead(int isRead) {
		setEntry(C3_WithdrawApplication.isRead, isRead);
	}

	public Date getReadTime() {
		try {
			Date data=getEntryDate(C3_WithdrawApplication.readTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReadTime(Date readTime) {
		setEntry(C3_WithdrawApplication.readTime, readTime);
	}


}