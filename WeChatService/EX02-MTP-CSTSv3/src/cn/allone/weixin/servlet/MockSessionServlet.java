package cn.allone.weixin.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.allone.weixin.user.WeixinUserInfo;


public class MockSessionServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public MockSessionServlet() {
        super();
    }

	@SuppressWarnings("deprecation")
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter pw = response.getWriter();
				
		String argOpenId = (String) request.getParameter("openId");
		String argNickname = (String) request.getParameter("nickname");
		String argGender = (String) request.getParameter("gender");
		String argProvince = (String) request.getParameter("province");
		String argCity = (String) request.getParameter("city");
		String argCountry = (String) request.getParameter("country");
		String argUrlOfHeadImage = (String) request.getParameter("urlOfHeadImage");
		String argVcode = (String) request.getParameter("vcode");
		
		WeixinUserInfo userInfo = null;
		String vcode = null;
				
		if (argOpenId != null) {
			// 用這個openId建立session。
			userInfo = new WeixinUserInfo();
	    	userInfo.setOpenId( argOpenId);
	    	userInfo.setNickname( argNickname != null ? argNickname : "unknown");
	    	
    		if (argGender.equals("1")) {
    			userInfo.setGender( WeixinUserInfo.Gender.MALE);
    		}
    		else if (argGender.equals("2")) {
    			userInfo.setGender( WeixinUserInfo.Gender.FEMALE);
    		}
    		else {
    			userInfo.setGender( WeixinUserInfo.Gender.UNKNOWN);
    		}
	    	
	    	userInfo.setProvince( argProvince);
	    	userInfo.setCity( argCity);
	    	userInfo.setCountry( argCountry);
	    	userInfo.setUrlOfHeadImage( argUrlOfHeadImage);
	    	userInfo.setPrivileges(null);
	    	userInfo.setUnionId("unique_" + argOpenId);
	    	
	    	Date expireDate = new Date();
	    	expireDate.setYear( expireDate.getYear() + 1);
	    
	    	boolean createSessionWhenEmpty = true;
	    	HttpSession session = request.getSession( createSessionWhenEmpty);
	    	synchronized(session) {
	    		session.setAttribute( "accessToken", "");
	    		session.setAttribute( "openId", userInfo.getOpenId());
	    		session.setAttribute( "expireTime", expireDate.getTime());
	    		session.setAttribute( "userInfo", userInfo);
	    		if (argVcode != null && false == argVcode.isEmpty()) {
	    			// 重新取得驗證碼。
	    			session.setAttribute( "vcodeTime", new Date());
	    			session.setAttribute( "vcode", argVcode);
	    			vcode = argVcode;
	    		}
	    	}
		}
		else {
			// 嘗試取出userInfo。
			HttpSession session = request.getSession(false);
			if (session != null) {
				userInfo = (WeixinUserInfo) session.getAttribute( "userInfo");
				if (argVcode != null && false == argVcode.isEmpty()) {
					// 重新取得驗證碼。
					session.setAttribute( "vcodeTime", new Date());
					session.setAttribute( "vcode", argVcode);
					vcode = argVcode;
				}
			}
		}
		
		pw.print( "<h1> Welcome to Weixin Trader test page.</h1><hr/>");
		
		// 顯示userInfo。
		if (userInfo == null) {
			pw.print( "open ID is not existing in session ┐(´д`)┌");
			
			// 建立一個空的userInfo讓顯示的程序正常運作。
			userInfo = new WeixinUserInfo();
		}
		else {
			pw.print( "open ID in session ヽ(*´∀`)ﾉ<br/>");
			pw.print( "your current open ID is: <span style=\"color: green;\">" + userInfo.getOpenId() + "</span>");
		}
		
		// 顯示表單。
		int genderChecked = 0; // unknown.
		if (userInfo.getGender() != null) {
			switch (userInfo.getGender()) {
				case MALE: genderChecked = 1; break;
				case FEMALE: genderChecked = 2; break;
				case UNKNOWN: genderChecked = 0; break;
			}
		}
		
		pw.print( "<hr/>");
		pw.print( "<form method=\"POST\"><table>");
		pw.print( "<tr><td>OpenID:</td><td><input type=\"text\" name=\"openId\" value=\"" + (userInfo.getOpenId() != null ? userInfo.getOpenId() : "") + "\" /></td></tr>");
		pw.print( "<tr><td>Nickname:</td><td><input type=\"text\" name=\"nickname\" value=\"" + (userInfo.getNickname() != null ? userInfo.getNickname() : "") + "\" /></td></tr>");
		pw.print( "<tr><td>Gender:</td><td><input type=\"radio\" name=\"gender\" value=\"0\" " + (genderChecked == 0 ? "checked" : "") + "/>Unknown<input type=\"radio\" name=\"gender\" value=\"1\" " + (genderChecked == 1 ? "checked" : "") + "/>Male<input type=\"radio\" name=\"gender\" value=\"2\" " + (genderChecked == 2 ? "checked" : "") + "/>Female</td></tr>");
		pw.print( "<tr><td>Province:</td><td><input type=\"text\" name=\"province\" value=\"" + (userInfo.getProvince() != null ? userInfo.getProvince() : "") + "\" /></td></tr>");
		pw.print( "<tr><td>City:</td><td><input type=\"text\" name=\"city\" value=\"" + (userInfo.getCity() != null ? userInfo.getCity() : "") + "\" /></td></tr>");
		pw.print( "<tr><td>Country:</td><td><input type=\"text\" name=\"country\" value=\"" + (userInfo.getCountry() != null ? userInfo.getCountry() : "") + "\" /></td></tr>");
		pw.print( "<tr><td>Url of head image:</td><td><input type=\"text\" name=\"urlOfHeadImage\" value=\"" + (userInfo.getUrlOfHeadImage() != null ? userInfo.getUrlOfHeadImage() : "") + "\" /></td></tr>");
		pw.print( "<tr><td>Verification code:</td><td><input type=\"text\" name=\"vcode\" maxlength=\"6\" value=\"" + (vcode != null ? vcode : "") + "\" /></td></tr>");
		pw.print( "<tr><td colspan=\"2\" style=\"text-align: right;\"><input type=\"submit\" value=\"change\" /></td></tr>");
		pw.print( "</table></form>");
		
		if (userInfo != null) {
			pw.print( "<a href=\"./\" target=\"weixinTrader\" rel=\"noreferrer\">Go to entry page</a>");	
		}
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet( request, response);
	}    
}
