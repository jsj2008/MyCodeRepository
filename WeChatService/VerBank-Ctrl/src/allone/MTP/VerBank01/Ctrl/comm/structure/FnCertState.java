package allone.MTP.VerBank01.Ctrl.comm.structure;

import java.io.Serializable;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: FnCertState.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.structure 
 * @Description: 取得憑證　(QueryCert) Retun code|憑證申請 ID|憑證序號|憑證狀態代碼|CN|憑證效期起|憑證效期迄
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午4:47:05 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class FnCertState implements Serializable {

	private static final long serialVersionUID = -6071049073830642864L;

	private int returnCode;

	// 憑證申請 ID
	private int requestID;
	// 憑證序號
	private String caSerial;
	// 憑證狀態代碼
	private int caState;

	private String cn;

	// 憑證效期起
	private long beginValidTime;

	// 憑證效期迄
	private long endValidTime;

	public int getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(int returnCode) {
		this.returnCode = returnCode;
	}

	public int getRequestID() {
		return requestID;
	}

	public void setRequestID(int requestID) {
		this.requestID = requestID;
	}

	public String getCaSerial() {
		return caSerial;
	}

	public void setCaSerial(String caSerial) {
		this.caSerial = caSerial;
	}

	public int getCaState() {
		return caState;
	}

	public void setCaState(int caState) {
		this.caState = caState;
	}

	public String getCn() {
		return cn;
	}

	public void setCn(String cn) {
		this.cn = cn;
	}

	public long getBeginValidTime() {
		return beginValidTime;
	}

	public void setBeginValidTime(long beginValidTime) {
		this.beginValidTime = beginValidTime;
	}

	public long getEndValidTime() {
		return endValidTime;
	}

	public void setEndValidTime(long endValidTime) {
		this.endValidTime = endValidTime;
	}

}
