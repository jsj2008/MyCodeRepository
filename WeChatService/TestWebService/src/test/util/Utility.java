package test.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


public class Utility {

//	private static MsgGatewayCaptain captain;
	
	Utility( ServletContext servletContext) {
//		captain = new MsgGatewayCaptain();
		 
		String rootPath = servletContext.getRealPath("WEB-INF");
		//String rootPath = System.getProperty("user.dir") + File.separator + "config";
		// System.out.println(rootPath);
//		captain.init(rootPath);
	}
	
	public static String convertToString( InputStream is) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(is,"UTF-8"));
        StringBuilder out = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            out.append(line);
        }
        return out.toString();
	}
	
	public static String encodedUriCompoment( String uri) throws UnsupportedEncodingException {
		return URLEncoder.encode( uri, "UTF-8")
		.replaceAll("\\+", "%20")
        .replaceAll("\\%21", "!")
        .replaceAll("\\%27", "'")
        .replaceAll("\\%28", "(")
        .replaceAll("\\%29", ")")
        .replaceAll("\\%7E", "~");
	}
	
//	public boolean sendSmsMsg( String phoneNumber, String msg) {	
//		ShortMessage sm = new ShortMessage();
//		sm.setPhone( phoneNumber);
//		sm.setContent( msg);
//		sm.setSendtime( new Date());
//		
//		try {
//			// 發送簡信。
//			GWSendStatus result = (GWSendStatus) captain.getGatewayAPI().sendMessage(captain.getGatewayConfig(), sm);
//			
//			// 檢測錯誤狀況。
//			if (false == result.getRetCode().equals("Sucess")) {
//				Log4jWrapper.errorr( "failed to send message, ret code: %s", result.getRetCode()); 
//				return false;
//			}
//			
//			// 沒有錯誤也不代表正確，檢查有沒有送出失敗的手機號碼。
//			if (result.getErrPhones() != null && false == result.getErrPhones().isEmpty()) {
//				Log4jWrapper.errorr( "failed to send message to below phones: %s", result.getErrPhones()); 
//				return false;
//			}
//		} catch (IOException e) {
//			e.printStackTrace();
//			return false;
//		}
//		return true;
//	}
	
	public static void printCookie( HttpServletRequest request) {
		StringBuilder sb = new StringBuilder();
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			String name = cookies[i].getName();
			String value = cookies[i].getValue();
			sb.append( name + "=" + value + ";");
		}
		
//		Log4jWrapper.infoo( "cookie: %s", sb.toString());
	}
}
