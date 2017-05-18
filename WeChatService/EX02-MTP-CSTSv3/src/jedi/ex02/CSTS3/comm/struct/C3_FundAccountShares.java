package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.FundAccountShares;


public class C3_FundAccountShares extends allone.json.AbstractJsonData {

	public static final String jsonId = "29";

	public static final String account = "1";
	public static final String fundid = "2";
	public static final String shares = "3";
	public static final String costprice = "4";
	public static final String costAmount = "5";
	public static final String description = "6";

	public C3_FundAccountShares(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(FundAccountShares data) throws Exception {
		setAccount(data.getAccount());
		setFundid(data.getFundid());
		setShares(data.getShares());
		setCostprice(data.getCostprice());
		setCostAmount(data.getCostAmount());
		setDescription(data.getDescription());
	}

	public FundAccountShares format(){
		FundAccountShares data=new FundAccountShares();
		data.setAccount(getAccount());
		data.setFundid(getFundid());
		data.setShares(getShares());
		data.setCostprice(getCostprice());
		data.setCostAmount(getCostAmount());
		data.setDescription(getDescription());
		return data;
	}


	public long getAccount() {
		try {
			long data=getEntryLong(C3_FundAccountShares.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_FundAccountShares.account, account);
	}

	public long getFundid() {
		try {
			long data=getEntryLong(C3_FundAccountShares.fundid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundid(long fundid) {
		setEntry(C3_FundAccountShares.fundid, fundid);
	}

	public double getShares() {
		try {
			double data=getEntryDouble(C3_FundAccountShares.shares);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setShares(double shares) {
		setEntry(C3_FundAccountShares.shares, shares);
	}

	public double getCostprice() {
		try {
			double data=getEntryDouble(C3_FundAccountShares.costprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCostprice(double costprice) {
		setEntry(C3_FundAccountShares.costprice, costprice);
	}

	public double getCostAmount() {
		try {
			double data=getEntryDouble(C3_FundAccountShares.costAmount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCostAmount(double costAmount) {
		setEntry(C3_FundAccountShares.costAmount, costAmount);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_FundAccountShares.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_FundAccountShares.description, description);
	}


}