package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: OP_Ctrl5106.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description: 取得憑證　(GetCertState)
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午4:44:16 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class OP_Ctrl5106 extends CtrlServerOPFather {

	private static final long serialVersionUID = -2415371148750299558L;

	private int returnCode;

	private int state;

	public OP_Ctrl5106(CtrlServerIPFather ip) {
		super(ip);
	}

	public int getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(int returnCode) {
		this.returnCode = returnCode;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

}
