package allone.MTP.VerBank01.Ctrl.comm.ipop.csts;

/**
 * 查询在线用户
 * 
 * @author admin
 * 
 */
public class IP_CtrlCSTS2001 extends CtrlCSTSIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1694316297268895671L;
	public final static int TYPE_ALL = 0;
	public final static int TYPE_ONE = 1;
	
	private int type;
	private String userName;

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
