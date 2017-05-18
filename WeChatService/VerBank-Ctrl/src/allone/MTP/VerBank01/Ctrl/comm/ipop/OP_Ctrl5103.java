package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: OP_Ctrl5103.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description: 更新憑證　(ReNewCert)：呼叫此API前需驗章成功 
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午4:41:28 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class OP_Ctrl5103 extends CtrlServerOPFather {

	private static final long serialVersionUID = -2415371148750299558L;

	private int returnCode;

	// 前次未完成流程憑證
	private String previousCA;

	public OP_Ctrl5103(CtrlServerIPFather ip) {
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
