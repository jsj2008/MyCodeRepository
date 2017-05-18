package allone.MTP.VerBank01.Ctrl.ca.url;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

public class CAURLProxy {

	public static final String URL_WITHOUT_ARGS_EXAMPLE = "http://10.48.16.150:8086/PVUI/onSiteTrustLinkLogin.htm";
	
	public static String createURL(String idNo) {
		return URL_WITHOUT_ARGS_EXAMPLE + createURLArgs(idNo);
	}
	
	public static String createURLArgs(String idNo) {
		return createURLArgs(idNo, new Date());
	}
	
	public static String createURLArgs(String idNo, Date loginTime) {
		return createURLArgs(idNo, "2012/05/23", loginTime);
	}
	
	public static String createURLArgs(String idNo, String birthDay, Date loginTime) {
		String argu = "?IdNo=%1$s&birthday=%2$s&LoginTime=%3$s&SessionCode=%4$s";
		
		String bd;
		try {
			bd = URLEncoder.encode(birthDay, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new InternalError();
		}
		
		String lt;
		if (loginTime == null) {
			lt = DateTimeUtil.format(new Date());
		} else {
			lt = DateTimeUtil.format(new Date());
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append(idNo).append(birthDay).append(lt).append("TWCA");
		byte[] dst = MessageDigestUtil.digest(sb.toString());
		String sc = Base64Util.encode(dst);
		try {
			sc = URLEncoder.encode(sc, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new InternalError();
		}
		
		String s = String.format(argu,idNo,bd,lt, sc);
		return s;
	}
	
	
}
