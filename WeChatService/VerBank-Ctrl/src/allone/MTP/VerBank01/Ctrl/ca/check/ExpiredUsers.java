package allone.MTP.VerBank01.Ctrl.ca.check;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import allone.MTP.VerBank01.Ctrl.comm.structure.UserCertState;

public class ExpiredUsers {

	public static void main(String[] args) {
		try {
			String GET_URL = "http://localhost:8088/VerBank-TDB/index.jsp";
			String getURL = GET_URL + "?CN=" + URLEncoder.encode("E189132315", "utf-8");
			URL getUrl = new URL(getURL);
			// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
			// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
			HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
			connection.setDoInput(true);
			connection.setUseCaches(false);
			// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
			// 服务器
			connection.connect();
			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//			System.out.println("=============================");
//			System.out.println("Contents of get request");
//			System.out.println("=============================");
			String lines;
			String value=null;
			while ((lines = reader.readLine()) != null) {
				if(lines.trim().length()>0) {
					value=lines;
				}
			}
			reader.close();
			// 断开连接
			connection.disconnect();
//			System.out.println("=============================");
//			System.out.println("Contents of get request ends");
//			System.out.println("=============================");
			UserCertState state=ResultReader.getUserCertState(value);
			System.out.println(state.getCertState()+"|"+state.getCertStateDesc());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
