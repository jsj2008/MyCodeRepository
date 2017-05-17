package server.config;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

public class ConfigCaptain {

	private int clientSocketPort;
	private String serverName;

	public boolean init(String configPath) {
		String configFile = configPath + File.separator + "config.properties";
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(configFile);
			Properties pro = new Properties();
			pro.load(fis);
			clientSocketPort = Integer.parseInt(pro.getProperty("clientSocketPort"));
			serverName = pro.getProperty("serverName");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		}
		return true;
	}

	public int getClientSocketPort() {
		return clientSocketPort;
	}

	public String getServerName() {
		return serverName;
	}

}
