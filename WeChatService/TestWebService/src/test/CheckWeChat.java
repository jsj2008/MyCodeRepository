package test;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.util.SignUtil;

public class CheckWeChat extends HttpServlet {

	private static final long serialVersionUID = -2965046592030975399L;
	
	public CheckWeChat() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.verify(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
//		this.doTrade(request, response);
	}

	
	private void verify(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");
		System.out.println("signature:" + signature);
		System.out.println("timestamp:" + timestamp);
		System.out.println("nonce:" + nonce);
		System.out.println("echostr:" + echostr);
		
		try {
            if (SignUtil.checkSignature(signature, timestamp, nonce)) {
                PrintWriter out = response.getWriter();
                out.print(echostr);
                out.close();
            } else {
//                logger.info("这里存在非法请求！");
            	System.out.println("err");
            }
        } catch (Exception e) {
//            logger.error(e, e);
        	System.out.println(e);
        }
//		PrintWriter pw = response.getWriter();
//		pw.append(echostr);
//		pw.flush();
	}
}
