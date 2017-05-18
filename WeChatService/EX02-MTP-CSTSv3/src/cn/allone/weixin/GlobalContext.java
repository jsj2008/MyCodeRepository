package cn.allone.weixin;

import java.net.HttpURLConnection;
import java.net.URL;

import java.io.InputStream;

import com.google.gson.Gson;

import cn.allone.utility.Log4jWrapper;
import cn.allone.utility.Utility;
import cn.allone.weixin.json.JsonAuth;

public class GlobalContext {
	
	private String appId;
	private String appSecret;
	private String accessToken; // 微信API的存取令牌。
	private String urlOfEntry;
	private String urlOfOAuthRedirectUri;
	private String clientPageLocation;
	private Long weixinApiRetryFetchIntervalTimeMillis;
	private String encodedOAuthRedirectUri;

	GlobalContext( String appId, String appSecret, String urlOfEntry, String urlOfOAuthRedirectUri, String clientPageLocation, Long weixinApiRetryFetchIntervalTimeMillis) {
		this.appId = appId;
		this.appSecret = appSecret;
		this.urlOfEntry = urlOfEntry;
		this.urlOfOAuthRedirectUri = urlOfOAuthRedirectUri;
		this.clientPageLocation = clientPageLocation;
		this.weixinApiRetryFetchIntervalTimeMillis = weixinApiRetryFetchIntervalTimeMillis;
		
		new WeixinTokenRequestor().start();
		
//		Log4jWrapper.infoo( "global context was created.");
//		Log4jWrapper.infoo( "appId: %s", appId);
//		Log4jWrapper.infoo( "appSecret: %s", appSecret);
//		Log4jWrapper.infoo( "urlOfEntry: %s", urlOfEntry);
//		Log4jWrapper.infoo( "urlOfOAuthRedirectUri: %s", urlOfOAuthRedirectUri);
//		Log4jWrapper.infoo( "clientPageLocation: %s", clientPageLocation);
//		Log4jWrapper.infoo( "weixinApiRetryFetchIntervalTimeMillis: %s", weixinApiRetryFetchIntervalTimeMillis);
		
    	try {
    		encodedOAuthRedirectUri = Utility.encodedUriCompoment( urlOfOAuthRedirectUri);
//    		Log4jWrapper.infoo( "encodedOAuthRedirectUri: %s", encodedOAuthRedirectUri);
    	}
    	catch (Exception e) {
    		System.out.println(e);
    	}
	}
	
	public String getAppId() {
		return appId;
	}
	
	public String getAppSecret() {
		return appSecret;
	}
	
	public String getAccessToken() {
		String clonedAccessToken;
		synchronized(this) {
			clonedAccessToken = new String( accessToken);
		}
		return clonedAccessToken;
	}
	
	public String getUrlOfEntry() {
		return urlOfEntry;
	}
	
	public String getUrlOfOAuthRedirectUri() {
		return urlOfOAuthRedirectUri;
	}
	
	public String getClientPageLocation() {
		return clientPageLocation;
	}
	
	public Long getWeixinApiRetryFetchIntervalTimeMillis() {
		return weixinApiRetryFetchIntervalTimeMillis;
	}
	
	public String getEncodedOAuthRedirectUri() {
		return encodedOAuthRedirectUri;
	}
	
	protected class WeixinTokenRequestor extends Thread {
		
		@Override
		public void run() {
			// 閱讀此段程式前可請先參考官方文件：
			// http://mp.weixin.qq.com/wiki/11/0e4b294685f817b95cbed85ba5e82b8f.html
			
			while (true) {
				try {
					String urlStr = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId + "&secret=" + appSecret;
//					Log4jWrapper.infoo( "URL: " + urlStr);
					
					URL url = new URL( urlStr);
					HttpURLConnection conn = (HttpURLConnection) url.openConnection();
					conn.setRequestMethod("GET");
					conn.connect();
					
//					Log4jWrapper.infoo( "HTTP response code: " + conn.getResponseCode());
							
					long timeMillis;
					if (conn.getResponseCode() == 200) {			
						InputStream is = conn.getInputStream();
				        String json = Utility.convertToString( is);
				        
			        	// Parse JSON into obj.
				        JsonAuth jsonObj = new Gson().fromJson( json, JsonAuth.class);
//				        Log4jWrapper.infoo( "%s", jsonObj);
				        
				        // 檢查是否有錯誤。
				        if (jsonObj.errcode == null && jsonObj.access_token != null) {
				        	// 無誤，使用accessToken。
				        	synchronized(GlobalContext.this) {
				        		accessToken = jsonObj.access_token;
				        	}
					        
					        // 官方文件上表明目前access_token的有效時間為7200秒。
					        timeMillis = jsonObj.expires_in != null ? jsonObj.expires_in * 1000 : InitContextListener.getGlobalContext().getWeixinApiRetryFetchIntervalTimeMillis(); // 有到期時間就用，沒有的話就內定7200秒。
//					        Log4jWrapper.infoo( "update after " + timeMillis + " (msec).");
				        }
				        else {
				        	// 有誤。
//				        	Log4jWrapper.infoo( "error msg: " + jsonObj.errmsg);
				        	
							timeMillis = InitContextListener.getGlobalContext().getWeixinApiRetryFetchIntervalTimeMillis();
//							Log4jWrapper.infoo( "retry after " + timeMillis + " (msec).");
				        }
					}
					else {
						timeMillis = InitContextListener.getGlobalContext().getWeixinApiRetryFetchIntervalTimeMillis();
//						Log4jWrapper.infoo( "retry after " + timeMillis + " (msec).");
					}
					
					// 一段時間後再嘗試取一次。
					Thread.sleep( timeMillis);
				}
				catch (Exception e) {
//					Log4jWrapper.errorr( e, "");					
				}
			}
			
		}

	}
	
}
