package jedi.ex01.CSTS3.comm.ipop;


public class IP_Web1001 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_Web1001";

	public static final String locale = "1";
	public static final String keySet = "2";
	public static final String accountId = "3";

	public IP_Web1001(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getLocale() {
		try {
			String data=getEntryString(IP_Web1001.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(IP_Web1001.locale, locale);
	}

	public String[] getKeySet() {
		try {
			String[] data=getEntryObjectVec(IP_Web1001.keySet,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setKeySet(String[] keySet) {
		setEntry(IP_Web1001.keySet, keySet);
	}

	public long getAccountId() {
		try {
			long data=getEntryLong(IP_Web1001.accountId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountId(long accountId) {
		setEntry(IP_Web1001.accountId, accountId);
	}


}