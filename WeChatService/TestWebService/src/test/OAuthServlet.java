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
import test.json.JsonWeixinUserInfo;
import test.json.WeixinUserInfo;
import test.json.WeixinUserInfo.Gender;
import test.util.Utility;

import com.google.gson.Gson;

public class OAuthServlet extends HttpServlet {

	private static final long serialVersionUID = -72497061144715947L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doTrade(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doTrade(request, response);
	}

	private void doTrade(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// 請參考：http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
		String code = request.getParameter("code");
		String state = request.getParameter("state");

		// Log4jWrapper.infoo( "code: %s, state: %s", code, state);
		if (code == null) {
			// 用戶在微信的授權確認頁面拒絕了。
			return;
		}

		// 用code獲取網頁用戶的accessToken(不同於微信API的access token)與open ID。
		// String appId = InitContextListener.getGlobalContext().getAppId();
		// String appSecret =
		// InitContextListener.getGlobalContext().getAppSecret();
		String appId = "wx3f742afd00e65648";
		String appSecret = "78640a5f3057b838ebf75d764ac4aa0f";
		String urlStr = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
				+ appId
				+ "&secret="
				+ appSecret
				+ "&code="
				+ code
				+ "&grant_type=authorization_code";
		// Log4jWrapper.infoo( "URL: " + urlStr);

		URL url = new URL(urlStr);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.connect();

		// Log4jWrapper.infoo( "HTTP response code: " + conn.getResponseCode());

		if (conn.getResponseCode() == 200) {
			InputStream is = conn.getInputStream();
			String json = Utility.convertToString(is);

			// Parse JSON.
			JsonUserAuth jsonObj = new Gson()
					.fromJson(json, JsonUserAuth.class);
			// Log4jWrapper.infoo( "%s", jsonObj);

			// 檢查是否有錯誤。
			if (jsonObj.errcode == null) {
				// 無誤，直接取得用戶信息(從這步驟開始需要用服務號，才能支援snsapi_userinfo的scope)。
				// Log4jWrapper.infoo(
				// "try to send HTTP request to get user info.");
				WeixinUserInfo userInfo = tryToGetUserInfo(jsonObj.access_token, jsonObj.openid);
				if (userInfo != null) {
					// 保存用戶相關數據到session。
					// Log4jWrapper.infoo(
					// "put accessToken, openId and expireTime into session.");
					boolean createSessionWhenEmpty = true;
					HttpSession session = request
							.getSession(createSessionWhenEmpty);
					synchronized (session) {
						session.setAttribute("accessToken",
								jsonObj.access_token);
						session.setAttribute("openId", jsonObj.openid);
						session.setAttribute("expireTime", jsonObj.expires_in);
						session.setAttribute("userInfo", userInfo);
					}

					// 設置session後再度導向一次entry頁面。
					// Log4jWrapper.infoo( "redirect to entry page.");
					// response.sendRedirect(
					// InitContextListener.getGlobalContext().getUrlOfEntry());
					response.sendRedirect("http://online.cangjinbao.com/TestWebService/entry");
				} else {
					// 無法正確的取得用戶信息，退回到之前的頁面。
					response.sendRedirect(request.getHeader("referer"));
				}
			} else {
				// 有誤。
				// Log4jWrapper.infoo( "error msg: " + jsonObj.errmsg);

				// 退回到之前的頁面。
				response.sendRedirect(request.getHeader("referer"));
			}
		} else {
			// 退回到之前的頁面。
			response.sendRedirect(request.getHeader("referer"));
		}
	}

	// 嘗試透過用戶的accessToken與OpenId取得用戶信息。
	protected WeixinUserInfo tryToGetUserInfo(String accessToken, String openId) {
		String urlStr = "https://api.weixin.qq.com/sns/userinfo?access_token="
				+ accessToken + "&openid=" + openId + "&lang=zh_CN";
		// Log4jWrapper.infoo( "URL: " + urlStr);

		try {
			URL url = new URL(urlStr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.connect();

			// Log4jWrapper.infoo( "HTTP response code: " +
			// conn.getResponseCode());

			if (conn.getResponseCode() == 200) {
				// Log4jWrapper.infoo( "succeeded.");

				InputStream is = conn.getInputStream();
				String json = Utility.convertToString(is);

				// Parse JSON into obj.
				JsonWeixinUserInfo jsonObj = new Gson().fromJson(json,
						JsonWeixinUserInfo.class);
				// Log4jWrapper.infoo( "%s", jsonObj);

				// 檢查是否有錯誤。
				if (jsonObj.errcode == null) {
					// 正確。
					WeixinUserInfo userInfo = new WeixinUserInfo();
					userInfo.setOpenId(jsonObj.openid);
					userInfo.setNickname(jsonObj.nickname);
					userInfo.setGender(jsonObj.sex == 0 ? Gender.UNKNOWN
							: jsonObj.sex == 1 ? Gender.MALE : Gender.FEMALE);
					userInfo.setProvince(jsonObj.province);
					userInfo.setCity(jsonObj.city);
					userInfo.setCountry(jsonObj.country);
					userInfo.setUrlOfHeadImage(jsonObj.headimgurl);
					userInfo.setPrivileges(jsonObj.privilege);
					userInfo.setUnionId(jsonObj.unionid);
					return userInfo;
				} else {
					// 有誤。
					// Log4jWrapper.infoo( "error msg: " + jsonObj.errmsg);
				}
			} else {
				// Log4jWrapper.infoo( "faild to request URL.");
			}
		} catch (Exception e) {
			// Log4jWrapper.errorr( e, "");
		}

		return null;
	}

}
