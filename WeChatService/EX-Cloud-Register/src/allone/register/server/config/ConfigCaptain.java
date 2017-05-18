package allone.register.server.config;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import allone.register.server.util.XMLBeanUtil;

/**
 * @author zhang.lei
 *
 */
public class ConfigCaptain {

	private static final ConfigCaptain instance = new ConfigCaptain();

	private String CADTSIp;
	private int CADTSCmdPort;
	private int CADTSDataPort;
	private String CADTSServName;
	private String logPath;

	private String serverName;
	
	private MarketConfig marketConfig;
	private int marketId;
	private String userGroup;
	
	private Map<String, String> marketMap = new HashMap<String, String>();

	public boolean init(String rootPath) {
		String configPath = rootPath + File.separator + "config" + File.separator;
		String cadtsCfgPath = configPath + "cadts.properties";
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(cadtsCfgPath);
			Properties pro = new Properties();
			pro.load(fis);
			logPath = pro.getProperty("logPath");
			CADTSIp = pro.getProperty("CADTSIp");
			CADTSCmdPort = Integer.parseInt(pro.getProperty("CADTSCmdPort"));
			CADTSDataPort = Integer.parseInt(pro.getProperty("CADTSDataPort"));
			CADTSServName = pro.getProperty("CADTSServName");
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

		String serverCfgPath = configPath + "server.properties";
		try {
			fis = new FileInputStream(serverCfgPath);
			Properties pro = new Properties();
			pro.load(fis);
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

		// init log dir
		logPath = logPath + "/register_server";
		File file = new File(logPath);
		if (!file.exists()) {
			if (!file.mkdirs()) {
				logPath = "log";
			}
		}

		// init serverConfig
		String marketCfgPath = configPath + "marketConfig.xml";
		File marketCfgFile = new File(marketCfgPath);
		if (!marketCfgFile.exists()) {
			System.out.println("server.xml文件不存在！");
			return false;
		}
		try {
			marketConfig = (MarketConfig) XMLBeanUtil.unmarshall(MarketConfig.class, marketCfgFile);
			// 会员号映射关系初始化
			marketId = marketConfig.getMarketId();
			userGroup = marketConfig.getUserGroup();
			List<MarketMappingItem> marketList = marketConfig.getMarketCfg().getMarketList();
			if (marketList != null && !marketList.isEmpty()) {
				for (MarketMappingItem market : marketList) {
					marketMap.put(market.getGroup(), market.getValue());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	public String getLogPath() {
		return logPath;
	}

	public static ConfigCaptain getInstance() {
		return instance;
	}

	public int getCADTSDataPort() {
		return CADTSDataPort;
	}


	public int getCADTSCmdPort() {
		return CADTSCmdPort;
	}

	public String getCADTSIp() {
		return CADTSIp;
	}

	public String getCADTSServName() {
		return CADTSServName;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public MarketConfig getMarketConfig() {
		return marketConfig;
	}

	public void setMarketConfig(MarketConfig marketConfig) {
		this.marketConfig = marketConfig;
	}

	public Map<String, String> getMarketMap() {
		return marketMap;
	}

	public void setMarketMap(Map<String, String> marketMap) {
		this.marketMap = marketMap;
	}

	public int getMarketId() {
		return marketId;
	}

	public void setMarketId(int marketId) {
		this.marketId = marketId;
	}

	public String getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(String userGroup) {
		this.userGroup = userGroup;
	}

}
