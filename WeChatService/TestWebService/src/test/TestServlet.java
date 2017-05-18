package test;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import test.json.JsonUserAuth;
import test.json.WeixinUserInfo;
import test.util.Utility;

import com.google.gson.Gson;

public class TestServlet extends HttpServlet {

	private static final long serialVersionUID = 5222793251610509039L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	IOException {
		this.doTrade(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doTrade(request, response);
	}

	private void doTrade(HttpServletRequest request, HttpServletResponse response) throws IOException {
//		response.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html; charset=UTF-8");
//				
//		// Ո������http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
//		String code = request.getParameter("code");
//		String state = request.getParameter("state");
//		
////		Log4jWrapper.infoo( "code: %s, state: %s", code, state);
//		if (code == null) {
//			// �Ñ���΢�ŵ��ڙ�_�J���ܽ^�ˡ�
//			return;
//		}
//		
//		// ��code�@ȡ�W��Ñ���accessToken(��ͬ�΢��API��access token)�copen ID��
////		String appId = InitContextListener.getGlobalContext().getAppId();
////		String appSecret = InitContextListener.getGlobalContext().getAppSecret();
//		String appId = "wx3f742afd00e65648";
//		String appSecret = "78640a5f3057b838ebf75d764ac4aa0f";
//		String urlStr = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appId + "&secret=" + appSecret + "&code=" + code + "&grant_type=authorization_code";
//		
////		Log4jWrapper.infoo( "URL: " + urlStr);
//		
//		URL url = new URL( urlStr);
//		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//		conn.setRequestMethod("GET");
//		conn.connect();
//		
////		Log4jWrapper.infoo( "HTTP response code: " + conn.getResponseCode());
//		
//		if (conn.getResponseCode() == 200) {						
//			InputStream is = conn.getInputStream();
//	        String json = Utility.convertToString( is);
//	        
//        	// Parse JSON.
//	        JsonUserAuth jsonObj = new Gson().fromJson( json, JsonUserAuth.class);
////	        Log4jWrapper.infoo( "%s", jsonObj);
//	        
//        	// �z���Ƿ����e�`��
//	        if (jsonObj.errcode == null) {
//	        	// �o�`��ֱ��ȡ���Ñ���Ϣ(���@���E�_ʼ��Ҫ�÷���̖������֧Ԯsnsapi_userinfo��scope)��
////	        	Log4jWrapper.infoo( "try to send HTTP request to get user info.");
//	        	WeixinUserInfo userInfo = tryToGetUserInfo( jsonObj.access_token, jsonObj.openid);
//	        	if (userInfo != null) {
//		        	// �����Ñ����P������session��
//		        	Log4jWrapper.infoo( "put accessToken, openId and expireTime into session.");
//		        	boolean createSessionWhenEmpty = true;
//		        	HttpSession session = request.getSession( createSessionWhenEmpty);
//		        	synchronized(session) {
//		        		session.setAttribute( "accessToken", jsonObj.access_token);
//		        		session.setAttribute( "openId", jsonObj.openid);
//		        		session.setAttribute( "expireTime", jsonObj.expires_in);
//		        		session.setAttribute( "userInfo", userInfo);
//		        	}
//		        	
//		        	// �O��session���ٶȌ���һ��entry��档
//		        	Log4jWrapper.infoo( "redirect to entry page.");
//		        	response.sendRedirect( InitContextListener.getGlobalContext().getUrlOfEntry());
//	        	}
//	        	else {
//	        		// �o�����_��ȡ���Ñ���Ϣ���˻ص�֮ǰ����档
//		        	response.sendRedirect( request.getHeader("referer"));
//	        	}
//	        }
//	        else {
//	        	// ���`��
//	        	Log4jWrapper.infoo( "error msg: " + jsonObj.errmsg);
//	        	
//	        	// �˻ص�֮ǰ����档
//	        	response.sendRedirect( request.getHeader("referer"));
//	        }
//		}
//		else {
//        	// �˻ص�֮ǰ����档
//        	response.sendRedirect( request.getHeader("referer"));
//		}
	}

	
}
