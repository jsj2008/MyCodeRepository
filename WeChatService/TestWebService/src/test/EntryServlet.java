package test;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import test.json.WeixinUserInfo;

public class EntryServlet extends HttpServlet {

	private static final long serialVersionUID = 2806951817490287774L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doTrade(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doTrade(request, response);
	}

	private void doTrade(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		// �z���Ƿ��ѵ���(�˵�����ָweb session���K����CSTS�����õ��ǂ�����)��
		// ������Ҫ�ȵ���web session����׌�͑����܉��B��CSTS��WebSocket��
		try {
			boolean createSessionWhenEmpty = false;
			HttpSession session = request.getSession( createSessionWhenEmpty);
			if (session != null) {
				WeixinUserInfo userInfo = (WeixinUserInfo) session.getAttribute("userInfo");
				if (userInfo != null) {					
					// �D�����͑�����档
//					String forwardUrl = InitContextListener.getGlobalContext().getClientPageLocation();
					String forwardUrl = "/index.jsp";
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher( forwardUrl);
					dispatcher.forward( request, response);
//					Log4jWrapper.infoo( "forwarding");
					
//					Log4jWrapper.infoo( "redirect to client page.");
//					response.sendRedirect( InitContextListener.getGlobalContext().getUrlOfClient());
					return;
				}
				else {
					// ��session�s�]��userInfo�������оw�g�ИOС�ęC�ʰl���@�ӵĿ�϶�����^�@�N��r��
//					Log4jWrapper.warnn( "there's session data but userInfo is not exising.");
					System.out.println("there's session data but userInfo is not exising.");
				}
			}
			
			// ��δ���룬��������΢���ڙ������档
//			String appId = InitContextListener.getGlobalContext().getAppId();
			String appId = "wx3f742afd00e65648";
			String state = "entry"; // State��΢�������C��D����OAuthResponseServlet�r�����^ȥ�o��ʽ������
			//response.sendRedirect( "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=http%3A%2F%2Fmars.alloneit.com.tw%2FWeixinVerifier%2FoauthResponse&response_type=code&scope=snsapi_userinfo&state=" + state + "#wechat_redirect");
			String redirectUrl = String.format(
				"https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_userinfo&state=%s#wechat_redirect",
				appId,
//				InitContextListener.getGlobalContext().getEncodedOAuthRedirectUri(),
				"http://online.cangjinbao.com/TestWebService/oauthResponse",
				state
			);
//			Log4jWrapper.infoo( "redirect to: %s", redirectUrl);
			response.sendRedirect( redirectUrl);
			System.out.println("EntryServlet : " + redirectUrl);
		}
		catch (Exception e) {
//			Log4jWrapper.errorr( e, "");
			System.out.println(e);
		}
	}
}
