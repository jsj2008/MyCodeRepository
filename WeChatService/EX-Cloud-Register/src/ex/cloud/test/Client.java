package ex.cloud.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

/**
 * @author zhang.lei
 *
 */
public class Client {

	public static void main(String[] args) throws IOException {
		
//		JSONObject jo = new JSONObject();  
//        jo.put("name", "001");  
//        jo.put("age", "1");  
		
		String url = "http://127.0.0.1:8080/EX-Cloud-Register/regist?age=100";
		URL realUrl = new URL(url);

		// �򿪺�URL֮�������
		HttpURLConnection connection = (HttpURLConnection) realUrl.openConnection();
		// ����ͨ�õ���������
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setUseCaches(false);
		connection.setRequestProperty("Content-Type", "text/xml;charset=UTF-8");

		OutputStreamWriter osw = new OutputStreamWriter(
				connection.getOutputStream(), "UTF-8");

//		osw.write(jo.toString());
		osw.flush();
		osw.close();
		// ��ȡ������Ӧͷ�ֶ�
		Map<String, List<String>> map = connection.getHeaderFields();
		// �������е���Ӧͷ�ֶ�
		for (String mkey : map.keySet()) {
			System.out.println(mkey + "--->" + map.get(mkey));
		}
		// ���� BufferedReader����������ȡURL����Ӧ
		BufferedReader in = new BufferedReader(new InputStreamReader(
				connection.getInputStream(), "UTF-8"));
		StringBuffer buffer = new StringBuffer();
		String temp;
		while ((temp = in.readLine()) != null) {
			buffer.append(temp);
			buffer.append("\n");
		}
		System.out.println(buffer.toString());
	}

}
