package comm.message;

public class OP_Client1001 extends OPFather {
	private static final long serialVersionUID = 5406271540109035700L;
	private int result;

	public OP_Client1001(IP_Client1001 ip) {
		super(ip);
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}
}
