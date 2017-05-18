package jedi.ex02.CSTS3.comm.jsondata;



public class C3_KickOutNode extends allone.json.AbstractJsonData {

	public static final String jsonId = "KickOutNode";

	public static final String kickerIp = "1";

	public C3_KickOutNode(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getKickerIp() {
		try {
			String data=getEntryString(C3_KickOutNode.kickerIp);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setKickerIp(String kickerIp) {
		setEntry(C3_KickOutNode.kickerIp, kickerIp);
	}


}