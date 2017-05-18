package jedi.ex01.CSTS3.comm.ipop;


public class OP_TRADESERV5110 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5110";

	public static final String result = "1";

	public OP_TRADESERV5110(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getResult() {
		try {
			int data=getEntryInt(OP_TRADESERV5110.result);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setResult(int result) {
		setEntry(OP_TRADESERV5110.result, result);
	}


}