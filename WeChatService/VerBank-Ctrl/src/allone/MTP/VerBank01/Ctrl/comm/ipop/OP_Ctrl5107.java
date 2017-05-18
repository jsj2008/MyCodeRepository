package allone.MTP.VerBank01.Ctrl.comm.ipop;

import allone.MTP.VerBank01.Ctrl.comm.structure.FnCertState;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: OP_Ctrl5107.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description: 取得憑證　(QueryCert) 
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午5:20:12 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class OP_Ctrl5107 extends CtrlServerOPFather {

	private static final long serialVersionUID = -2415371148750299558L;

	private FnCertState certState;

	public OP_Ctrl5107(CtrlServerIPFather ip) {
		super(ip);
	}

	public FnCertState getCertState() {
		return certState;
	}

	public void setCertState(FnCertState certState) {
		this.certState = certState;
	}

}
