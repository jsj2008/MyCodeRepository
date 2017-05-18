package jedi.ex02.CSTS3.comm.ipop;


public class C3_IP_Web1001 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_Web1001";

	public static final String locale = "1";
	public static final String keySet = "2";
	public static final String accountId = "3";

	public C3_IP_Web1001(){
		super();
		setEntry("jsonId", jsonId);
	}

//	public IP_Web1001 formatIP() {
//		IP_Web1001 ip=new IP_Web1001();
//		ip.setLocale(getLocale());
//		ip.setKeySet(getKeySet());
//		ip.setAccountId(getAccountId());
//		return ip;
//	}

	public String getLocale() {
		try {
			String data=getEntryString(C3_IP_Web1001.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(C3_IP_Web1001.locale, locale);
	}

	public String[] getKeySet() {
		try {
			String[] data=getEntryObjectVec(C3_IP_Web1001.keySet,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setKeySet(String[] keySet) {
		setEntry(C3_IP_Web1001.keySet, keySet);
	}

	public long getAccountId() {
		try {
			long data=getEntryLong(C3_IP_Web1001.accountId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountId(long accountId) {
		setEntry(C3_IP_Web1001.accountId, accountId);
	}


}