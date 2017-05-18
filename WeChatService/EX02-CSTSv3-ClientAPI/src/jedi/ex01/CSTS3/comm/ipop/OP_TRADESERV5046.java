package jedi.ex01.CSTS3.comm.ipop;


public class OP_TRADESERV5046 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5046";

	public static final String result = "1";

	public OP_TRADESERV5046(){
		super();
		setEntry("jsonId", jsonId);
	}

	public boolean isResult() {
		try {
			boolean data=getEntryBoolean(OP_TRADESERV5046.result);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setResult(boolean result) {
		setEntry(OP_TRADESERV5046.result, result);
	}


}