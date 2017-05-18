package jedi.ex01.CSTS3.comm.jsondata;


public class EchoData extends allone.json.AbstractJsonData {

	public static final String jsonId = "EchoData";


	public EchoData(){
		super();
		setEntry("jsonId", jsonId);
	}


}