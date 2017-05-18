package ex.cloud.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import allone.Log.simpleLog.log.LogProxy;
import allone.register.server.trade.api.ECRServerAPI;
import allone.register.server.trade.api.ECRTradeTypeTable;
import allone.register.server.trade.api.message.RegistResponse;

/**
 * @author zhang.lei
 *
 */
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = -2475025480906047969L;

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

		String tradeType = request.getParameter("tradeType");
		if (tradeType == null) {
			LogProxy.OutPrintln("trade type cannot be null");
			return;
		}
		if (tradeType.equalsIgnoreCase(ECRTradeTypeTable.EXC_SERVER_RIGIST)) {
			String openAccount = request.getParameter("openAccount");
			String pwd = request.getParameter("password");
			String marketIdString = request.getParameter("marketId");
			String ibAccountString = request.getParameter("ibAccount");

			int marketId  = stringIsEmpty(marketIdString) ? 0 : Integer.parseInt(marketIdString);
			int ibAccount = stringIsEmpty(ibAccountString) ? 0 : Integer.parseInt(ibAccountString);
			System.out.println("reciveResponse : account : " + openAccount);
			RegistResponse registResponse = ECRServerAPI.getInstance().register(openAccount, pwd, marketId, ibAccount);

			// todo response 
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json; charset=utf-8");
			String jsonStr = registResponse.responseToJson();
			PrintWriter out = null;
			try {
				out = response.getWriter();
				out.write(jsonStr);
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (out != null) {
					out.close();
				}
			}

		} else {
			LogProxy.OutPrintln("unknow trade type : " + tradeType);
		}
	}

	private boolean stringIsEmpty(String inString){
		if (inString == null || inString.length() == 0) {
			return true;
		}
		return false;
	}

}
