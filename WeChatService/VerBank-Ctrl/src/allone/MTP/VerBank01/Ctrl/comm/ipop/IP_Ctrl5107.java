package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: IP_Ctrl5106.java 
 * @Package allone.MTP.VerBank01.Ctrl.comm.ipop 
 * @Description:取得憑證　(QueryCert)
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月15日 下午3:24:48 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class IP_Ctrl5107 extends CtrlServerIPFather {

	private static final long serialVersionUID = 7284128843784596825L;
	
	
	// 憑證用戶證件號碼(身分證字號、統一編號、統一證號)
	private String aeid;
	// 裝置類別(如下所列)IP: iPhone IA: iPad GP: GPhone AA: Android Pad
	private String deviceType;
	// 裝置 ID (Ex: 手機號碼, 行動裝置 IMEI Code 或其它足以識別裝置的代碼 + App 安裝時之時間序)
	private String deviceId;
	// 軟體/廠商/APP 代碼
	private String venderId;
	// 憑證序號(十六進位)
	private String serial;

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

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

}
