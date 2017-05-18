package jedi.ex01.CSTS3.comm.struct;


public class FundAccountShares extends allone.json.AbstractJsonData {

	public static final String jsonId = "29";

	public static final String account = "1";
	public static final String fundid = "2";
	public static final String shares = "3";
	public static final String costprice = "4";
	public static final String costAmount = "5";
	public static final String description = "6";

	public FundAccountShares(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(FundAccountShares.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(FundAccountShares.account, account);
	}

	public long getFundid() {
		try {
			long data=getEntryLong(FundAccountShares.fundid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundid(long fundid) {
		setEntry(FundAccountShares.fundid, fundid);
	}

	public double getShares() {
		try {
			double data=getEntryDouble(FundAccountShares.shares);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setShares(double shares) {
		setEntry(FundAccountShares.shares, shares);
	}

	public double getCostprice() {
		try {
			double data=getEntryDouble(FundAccountShares.costprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCostprice(double costprice) {
		setEntry(FundAccountShares.costprice, costprice);
	}

	public double getCostAmount() {
		try {
			double data=getEntryDouble(FundAccountShares.costAmount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCostAmount(double costAmount) {
		setEntry(FundAccountShares.costAmount, costAmount);
	}

	public String getDescription() {
		try {
			String data=getEntryString(FundAccountShares.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(FundAccountShares.description, description);
	}


}