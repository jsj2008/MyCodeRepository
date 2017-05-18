package allone.MTP.VerBank01.Ctrl.comm.structure;

import java.io.Serializable;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: FnStatus.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.structure 
 * @Description: ReturnCode | Return Message | 有效憑證數 |已申請憑證數 | 最新一張憑證序號 |
 *                          最新一張憑證狀態 | CSR 金鑰長度 | 前次未完成流程憑證 |
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午3:39:25 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class FnStatus implements Serializable {

	private static final long serialVersionUID = -6071049073830642864L;

	private int returnCode;

	private int returnMessage;

	// 有效憑證數
	private int effectiveCAnumber;

	// 已申請憑證數
	private int requestCANumber;

	// 最新一張憑證序號
	private String lastCASerial;

	// 最新一張憑證狀態
	private int lastCAState;

	// CSR 金鑰長度
	private int csrLength;

	// 前次未完成流程憑證
	private String previousCA;

	public int getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(int returnCode) {
		this.returnCode = returnCode;
	}

	public int getReturnMessage() {
		return returnMessage;
	}

	public void setReturnMessage(int returnMessage) {
		this.returnMessage = returnMessage;
	}

	public int getEffectiveCAnumber() {
		return effectiveCAnumber;
	}

	public void setEffectiveCAnumber(int effectiveCAnumber) {
		this.effectiveCAnumber = effectiveCAnumber;
	}

	public int getRequestCANumber() {
		return requestCANumber;
	}

	public void setRequestCANumber(int requestCANumber) {
		this.requestCANumber = requestCANumber;
	}

	public String getLastCASerial() {
		return lastCASerial;
	}

	public void setLastCASerial(String lastCASerial) {
		this.lastCASerial = lastCASerial;
	}

	public int getLastCAState() {
		return lastCAState;
	}

	public void setLastCAState(int lastCAState) {
		this.lastCAState = lastCAState;
	}

	public int getCsrLength() {
		return csrLength;
	}

	public void setCsrLength(int csrLength) {
		this.csrLength = csrLength;
	}

	public String getPreviousCA() {
		return previousCA;
	}

	public void setPreviousCA(String previousCA) {
		this.previousCA = previousCA;
	}

}
