package cn.allone.weixin.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.allone.weixin.json.JsonClientUser;
import cn.allone.weixin.user.WeixinUserInfo;

import com.google.gson.Gson;

/**
 * 用來返回用戶資訊。
 * 由前端使用Ajax(HttpRequest)來請求。
 */
//@WebServlet("/ajaxUserInfo")
public class AjaxUserInfoServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public AjaxUserInfoServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		
    	PrintWriter pw = response.getWriter();
				
		// 檢查session。
    	WeixinUserInfo userInfo = null;
    	boolean createSessionWhenEmpty = false;
    	HttpSession session = request.getSession( createSessionWhenEmpty);
		if (session != null) {
			userInfo = (WeixinUserInfo) session.getAttribute("userInfo");
		}
		
		if (userInfo != null) {			
			// 檢查帳戶是否存在。
			
			JsonClientUser jsonClientUser = new JsonClientUser(); 
			jsonClientUser.openId = userInfo.getOpenId();
			jsonClientUser.nickname = userInfo.getNickname();
			jsonClientUser.gender = userInfo.getGender() == WeixinUserInfo.Gender.MALE ? 1 : userInfo.getGender() == WeixinUserInfo.Gender.FEMALE ? 2 : 0;  
			jsonClientUser.city = userInfo.getCity();
			jsonClientUser.country = userInfo.getCountry();
			jsonClientUser.urlOfHeadImage = userInfo.getUrlOfHeadImage();
			jsonClientUser.unionId = userInfo.getUnionId();
			
			Gson gs = new Gson();
			String json = gs.toJson(jsonClientUser);
			pw.print( json);
			System.out.println("UserInfoServlet : " + json);
		}
		else {
			pw.print("{}");	
			System.out.println("UserInfoServlet : {}");
		}
		
		
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet( request, response);
	}

}
