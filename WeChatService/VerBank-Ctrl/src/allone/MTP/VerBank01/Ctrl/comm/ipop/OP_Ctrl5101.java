package allone.MTP.VerBank01.Ctrl.comm.ipop;

import allone.MTP.VerBank01.Ctrl.comm.structure.FnStatus;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: OP_Ctrl5101.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description: 行動GW-GetFnStatus2 
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午3:40:53 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class OP_Ctrl5101 extends CtrlServerOPFather {

	private static final long serialVersionUID = -8560898802046325126L;

	private FnStatus fnStatus;

	public OP_Ctrl5101(CtrlServerIPFather ip) {
		super(ip);
	}

	public FnStatus getFnStatus() {
		return fnStatus;
	}

	public void setFnStatus(FnStatus fnStatus) {
		this.fnStatus = fnStatus;
	}

}
