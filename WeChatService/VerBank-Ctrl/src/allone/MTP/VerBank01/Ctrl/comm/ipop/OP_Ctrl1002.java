package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl1002 extends CtrlServerOPFather {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2630079988058068512L;
	private int result;
	private String[] roleName;
	
	public OP_Ctrl1002(CtrlServerIPFather ip) {
		super(ip);
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public String[] getRoleName() {
		return roleName;
	}

	public void setRoleName(String[] roleName) {
		this.roleName = roleName;
	}

}
