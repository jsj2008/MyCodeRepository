package cn.allone.weixin;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
//import javax.servlet.annotation.WebListener;

import cn.allone.utility.Log4jWrapper;


//@WebListener
public class InitContextListener implements ServletContextListener {
	
	protected static GlobalContext globalContext = null;
		
	public static GlobalContext getGlobalContext() {
		return globalContext;
	}
	
    public InitContextListener() {

    }
    
    @Override
    public void contextInitialized( ServletContextEvent arg0)  { 
//    	Log4jWrapper.infoo( "%s - contextInitialized.", this.getClass().getName());
    	
    	ServletContext sc = arg0.getServletContext();
		String appId = sc.getInitParameter("weixinAppId");
    	String appSecret = sc.getInitParameter("weixinAppSecret");
    	String urlOfEntry = sc.getInitParameter("weixinUrlOfEntry");
    	String urlOfOAuthRedirectUri = sc.getInitParameter("weixinUrlOfOAuthRedirectUri");
    	String clientPageLocation = sc.getInitParameter("weixinClientPageLocation");
    	Long weixinApiRetryFetchIntervalTimeMillis = Long.parseLong( sc.getInitParameter("weixinApiRetryFetchIntervalTimeMillis"));
    	
    	globalContext = new GlobalContext( appId, appSecret, urlOfEntry, urlOfOAuthRedirectUri, clientPageLocation, weixinApiRetryFetchIntervalTimeMillis);
    }

    @Override
    public void contextDestroyed( ServletContextEvent arg0)  { 
//    	Log4jWrapper.infoo( "%s - contextDestroyed.", this.getClass().getName());
    }
    	
}
