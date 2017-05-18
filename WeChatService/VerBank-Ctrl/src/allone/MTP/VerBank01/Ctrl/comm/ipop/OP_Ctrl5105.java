package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: OP_Ctrl5105.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description: 取得憑證　(GetCert)
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午4:43:13 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class OP_Ctrl5105 extends CtrlServerOPFather {

	private static final long serialVersionUID = -2415371148750299558L;

	private int returnCode;

	// 前次未完成流程憑證
	private String previousCA;

	public OP_Ctrl5105(CtrlServerIPFather ip) {
		super(ip);
	}

	public int getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(int returnCode) {
		this.returnCode = returnCode;
	}

	public String getPreviousCA() {
		return previousCA;
	}

	public void setPreviousCA(String previousCA) {
		this.previousCA = previousCA;
	}

}
