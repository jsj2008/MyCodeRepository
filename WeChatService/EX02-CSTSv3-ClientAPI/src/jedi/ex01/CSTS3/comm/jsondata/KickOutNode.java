package jedi.ex01.CSTS3.comm.jsondata;


public class KickOutNode extends allone.json.AbstractJsonData {

	public static final String jsonId = "KickOutNode";

	public static final String kickerIp = "1";

	public KickOutNode(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getKickerIp() {
		try {
			String data=getEntryString(KickOutNode.kickerIp);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setKickerIp(String kickerIp) {
		setEntry(KickOutNode.kickerIp, kickerIp);
	}


}