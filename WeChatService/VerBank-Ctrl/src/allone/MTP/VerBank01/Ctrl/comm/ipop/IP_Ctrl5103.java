package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: IP_Ctrl5103.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description: 更新憑證　(ReNewCert)：呼叫此API前需驗章成功
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午3:20:56 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class IP_Ctrl5103 extends CtrlServerIPFather {

	private static final long serialVersionUID = -7630805954547504963L;
	// 憑證用戶證件號碼(身分證字號、統一編號、統一證號)
	private String aeid;
	// 裝置類別(如下所列)IP: iPhone IA: iPad GP: GPhone AA: Android Pad
	private String deviceType;
	// 裝置 ID (Ex: 手機號碼, 行動裝置 IMEI Code 或其它足以識別裝置的代碼 + App 安裝時之時間序)
	private String deviceId;
	// 軟體/廠商/APP 代碼
	private String venderId;
	// 憑證申請密碼。
	private String password;
	// 依憑證用戶 ID, 裝置類別及裝置 ID產生 CSR 值(請先 URL ENCODE) ，如以GetFnStatus
	// 取得目前可用功能及操作狀態之回傳值第 1 個字元為「2」時，此項參數值應為空字串
	private String CSR;

	private String sign;
	private String certsn;

	public String getAeid() {
		return aeid;
	}

	public void setAeid(String aeid) {
		this.aeid = aeid;
	}

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getVenderId() {
		return venderId;
	}

	public void setVenderId(String venderId) {
		this.venderId = venderId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCSR() {
		return CSR;
	}

	public void setCSR(String cSR) {
		CSR = cSR;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getCertsn() {
		return certsn;
	}

	public void setCertsn(String certsn) {
		this.certsn = certsn;
	}

}
