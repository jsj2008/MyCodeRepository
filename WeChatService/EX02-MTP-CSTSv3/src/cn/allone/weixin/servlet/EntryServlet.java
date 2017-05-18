package cn.allone.weixin.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.allone.utility.Log4jWrapper;
import cn.allone.weixin.InitContextListener;
import cn.allone.weixin.user.WeixinUserInfo;


//@WebServlet("/entry")
public class EntryServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public EntryServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		// 檢查是否已登入(此登入是指web session、並不是CSTS交易用的那個登入)。
		// 基本上要先登入web session，才讓客戶端能夠連上CSTS的WebSocket。
		try {
			boolean createSessionWhenEmpty = false;
			HttpSession session = request.getSession( createSessionWhenEmpty);
			if (session != null) {
				WeixinUserInfo userInfo = (WeixinUserInfo) session.getAttribute("userInfo");
				if (userInfo != null) {					
					// 轉向至客戶端頁面。
					String forwardUrl = InitContextListener.getGlobalContext().getClientPageLocation();
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher( forwardUrl);
					dispatcher.forward( request, response);
					Log4jWrapper.infoo( "forwarding");
					
//					Log4jWrapper.infoo( "redirect to client page.");
//					response.sendRedirect( InitContextListener.getGlobalContext().getUrlOfClient());
					return;
				}
				else {
					// 有session卻沒有userInfo，多執行緒間有極小的機率發生這樣的空隙。略過這種狀況。
					Log4jWrapper.warnn( "there's session data but userInfo is not exising.");
				}
			}
			
			// 尚未登入，重新導向至微信授權登入頁面。
			String appId = InitContextListener.getGlobalContext().getAppId();
			String state = "entry"; // State在微信身份驗證頁轉跳到OAuthResponseServlet時會帶過去給程式參考。
			//response.sendRedirect( "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=http%3A%2F%2Fmars.alloneit.com.tw%2FWeixinVerifier%2FoauthResponse&response_type=code&scope=snsapi_userinfo&state=" + state + "#wechat_redirect");
			String redirectUrl = String.format(
				"https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_userinfo&state=%s#wechat_redirect",
				appId,
				InitContextListener.getGlobalContext().getEncodedOAuthRedirectUri(),
				state
			);
			Log4jWrapper.infoo( "redirect to: %s", redirectUrl);
			response.sendRedirect( redirectUrl);
			System.out.println("EntryServlet : " + redirectUrl);
		}
		catch (Exception e) {
			Log4jWrapper.errorr( e, "");
		}
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet( request, response);
	}

}
