package allone.MTP.VerBank01.Ctrl.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;

public class URLConnectionUtil {

	public static String connection(URL url) throws IOException {
		if (StaticContext.getConfigCaptain().isHttps()) {
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			(connection).setHostnameVerifier(new HostnameVerifier() {

				@Override
				public boolean verify(String urlHostName, SSLSession session) {
					return true;
				}
			});
			HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {

				@Override
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			});
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
			// 服务器
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.connect();
			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
			String lines;
			String value = "";
			while ((lines = reader.readLine()) != null) {
				if (lines.trim().length() > 0) {
					value += lines;
				}
			}
			LogProxy.OutPrintln(url + "\r\n" + value);
			reader.close();
			connection.disconnect();
			return value.toString();

		} else {
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
			// 服务器
			connection.connect();
			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
			String lines;
			String value = "";

			while ((lines = reader.readLine()) != null) {
				if (lines.trim().length() > 0) {
					value += lines;
				}
			}
			LogProxy.OutPrintln(url + "\r\n" + value);
			reader.close();
			connection.disconnect();
			return value.toString();
		}
	}

}
