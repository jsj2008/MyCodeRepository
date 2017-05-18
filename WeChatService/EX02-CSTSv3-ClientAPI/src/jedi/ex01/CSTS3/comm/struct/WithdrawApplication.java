package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class WithdrawApplication extends allone.json.AbstractJsonData {

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

	public WithdrawApplication(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getGuid() {
		try {
			String data=getEntryString(WithdrawApplication.guid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuid(String guid) {
		setEntry(WithdrawApplication.guid, guid);
	}

	public int getType() {
		try {
			int data=getEntryInt(WithdrawApplication.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(WithdrawApplication.type, type);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(WithdrawApplication.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(WithdrawApplication.account, account);
	}

	public String getCurrency() {
		try {
			String data=getEntryString(WithdrawApplication.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(WithdrawApplication.currency, currency);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(WithdrawApplication.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(WithdrawApplication.amount, amount);
	}

	public Date getAppTime() {
		try {
			Date data=getEntryDate(WithdrawApplication.appTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAppTime(Date appTime) {
		setEntry(WithdrawApplication.appTime, appTime);
	}

	public String getIpAddress() {
		try {
			String data=getEntryString(WithdrawApplication.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(WithdrawApplication.ipAddress, ipAddress);
	}

	public String getBankAccount() {
		try {
			String data=getEntryString(WithdrawApplication.bankAccount);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAccount(String bankAccount) {
		setEntry(WithdrawApplication.bankAccount, bankAccount);
	}

	public String getBankName() {
		try {
			String data=getEntryString(WithdrawApplication.bankName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankName(String bankName) {
		setEntry(WithdrawApplication.bankName, bankName);
	}

	public String getAccountName() {
		try {
			String data=getEntryString(WithdrawApplication.accountName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountName(String accountName) {
		setEntry(WithdrawApplication.accountName, accountName);
	}

	public String getBankAddress() {
		try {
			String data=getEntryString(WithdrawApplication.bankAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAddress(String bankAddress) {
		setEntry(WithdrawApplication.bankAddress, bankAddress);
	}

	public String getInternationalCode() {
		try {
			String data=getEntryString(WithdrawApplication.internationalCode);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInternationalCode(String internationalCode) {
		setEntry(WithdrawApplication.internationalCode, internationalCode);
	}

	public String getDescription() {
		try {
			String data=getEntryString(WithdrawApplication.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(WithdrawApplication.description, description);
	}

	public String getDealer() {
		try {
			String data=getEntryString(WithdrawApplication.dealer);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDealer(String dealer) {
		setEntry(WithdrawApplication.dealer, dealer);
	}

	public String getDealerIp() {
		try {
			String data=getEntryString(WithdrawApplication.dealerIp);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDealerIp(String dealerIp) {
		setEntry(WithdrawApplication.dealerIp, dealerIp);
	}

	public int getIsRead() {
		try {
			int data=getEntryInt(WithdrawApplication.isRead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsRead(int isRead) {
		setEntry(WithdrawApplication.isRead, isRead);
	}

	public Date getReadTime() {
		try {
			Date data=getEntryDate(WithdrawApplication.readTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReadTime(Date readTime) {
		setEntry(WithdrawApplication.readTime, readTime);
	}


}