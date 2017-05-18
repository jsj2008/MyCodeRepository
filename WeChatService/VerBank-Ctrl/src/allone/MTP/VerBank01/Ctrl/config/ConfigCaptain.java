package allone.MTP.VerBank01.Ctrl.config;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;
import java.util.TimeZone;

import allone.MTP.VerBank01.ConfigSev.comm.CtrlServConfigNode;
import allone.MTP.VerBank01.ConfigSev.proxy.ConfigProxy;
import allone.MTP.VerBank01.comm.ServCallNameTable;

public class ConfigCaptain {
	private CtrlServConfigNode configNode;
	private String logPath;
	private String monitorConfigPath;
	private TimeZone timeZone;
	private String[] cstsNames;
	private String[] dstsNames;

	private boolean debug;
	private String caLoginAcct;
	private String caLoginPassword;
	private String caServletUrl;
	private String caLoginMessage;
	private String caCheckCertStateUrl;

	private String glDBUPath;
	private String glDBUFile;
	private String glOBUPath;
	private String glOBUFile;
	private String glTimeFormat;

	private String phone_CAServletUrl;
	private String phone_fnStatus;
	private String phone_applyCert;
	private String phone_reNewCert;
	private String phone_certInstallComplete;
	private String phone_getCert;
	private String phone_getCertState;
	private String phone_queryCert;

	private Properties versions = new Properties();
	private boolean checkVersion;

	public boolean init(String rootPath) {
		monitorConfigPath = rootPath + File.separator + "config" + File.separator + "MonitorConfig.properties";
		String cfgPath = rootPath + File.separator + "config" + File.separator + "CfgProxy.properties";

		configNode = ConfigProxy.queryCtrlServConfigNode(cfgPath);
		if (configNode == null) {
			return false;
		}

		logPath = configNode.getLogPath();
		File file = new File(logPath);
		if (!file.exists()) {
			if (!file.mkdirs()) {
				logPath = rootPath + File.separator + "log";
			}
		}

		cstsNames = configNode.getCSTSNames();
		dstsNames = configNode.getDSTSNames();

		try {
			Properties pro = new Properties();
			FileInputStream fi = new FileInputStream(rootPath + File.separator + "config" + File.separator + "other.properties");
			pro.load(fi);
			fi.close();
			String timezone = pro.getProperty("timezone");
			if (timezone != null) {
				timeZone = TimeZone.getTimeZone(timezone);
			} else {
				timeZone = TimeZone.getDefault();
			}
			String checkVersion = pro.getProperty("checkVersion");
			if (checkVersion != null) {
				this.checkVersion = Boolean.parseBoolean(checkVersion);
			} else {
				this.checkVersion = false;
			}

			initCAConfig(rootPath);

			initPhoneCAConfig(rootPath);

			initGLConfig(rootPath);

			initVersions(rootPath);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	private void initCAConfig(String rootPath) throws Exception {
		Properties pro = new Properties();
		FileInputStream fi = new FileInputStream(rootPath + File.separator + "config" + File.separator + "ca.properties");
		pro.load(fi);
		fi.close();

		debug = Boolean.valueOf(pro.getProperty("debug"));
		caLoginAcct = pro.getProperty("loginacc");
		caLoginPassword = pro.getProperty("loginpass");
		caServletUrl = pro.getProperty("servleturl");
		caLoginMessage = pro.getProperty("loginlogmsg");
		caCheckCertStateUrl = pro.getProperty("checkCertStateUrl");
	}

	private void initPhoneCAConfig(String rootPath) throws Exception {
		Properties pro = new Properties();
		FileInputStream fi = new FileInputStream(rootPath + File.separator + "config" + File.separator + "phone_ca.properties");
		pro.load(fi);
		fi.close();
		phone_CAServletUrl = pro.getProperty("servleturl");
		phone_fnStatus = pro.getProperty("getFnStatus");
		phone_applyCert = pro.getProperty("applyCert");
		phone_reNewCert = pro.getProperty("reNewCert");
		phone_certInstallComplete = pro.getProperty("certInstallComplete");
		phone_getCert = pro.getProperty("getCert");
		phone_getCertState = pro.getProperty("getCertState");
		phone_queryCert = pro.getProperty("queryCert");

	}

	private void initGLConfig(String rootPath) throws Exception {
		Properties pro = new Properties();
		FileInputStream fi = new FileInputStream(rootPath + File.separator + "config" + File.separator + "gl.properties");
		pro.load(fi);
		fi.close();

		glDBUPath = pro.getProperty("dbuPath");
		glDBUFile = pro.getProperty("dbufile");
		glOBUPath = pro.getProperty("obuPath");
		glOBUFile = pro.getProperty("obufile");
		glTimeFormat = pro.getProperty("timeFormat");
	}

	private void initVersions(String rootPath) throws Exception {
		FileInputStream fi = new FileInputStream(rootPath + File.separator + "config" + File.separator + "version.properties");
		versions.load(fi);
		fi.close();
	}

	public String getVersion(String type) {
		return versions.getProperty(type.toUpperCase());
	}

	public String getPhoneMinVersion(String type) {
		return versions.getProperty(type.toUpperCase() + "_min");
	}

	public String getPhoneMaxVersion(String type) {
		return versions.getProperty(type.toUpperCase() + "_max");
	}

	public String getCADTSIp() {
		return configNode.getCADTSIp();
	}

	public int getCADTSCmdPort() {
		return configNode.getCADTSCmdPort();
	}

	public int getCADTSDataPort() {
		return configNode.getCADTSDataPort();
	}

	public String getCADTSServName() {
		return configNode.getCADTSServName();
	}

	public String getCADTSPorxyName() {
		return ServCallNameTable.SERV_VERBANK_CTRL;
	}

	public String getLogPath() {
		return this.logPath;
	}

	public void destroy() {
		ConfigProxy.destroy();
	}

	public String getMonitorConfigPath() {
		return monitorConfigPath;
	}

	public TimeZone getTimeZone() {
		return timeZone;
	}

	public String[] getCstsNames() {
		return cstsNames;
	}

	public String[] getDstsNames() {
		return dstsNames;
	}

	public boolean isDebug() {
		return debug;
	}

	public String getCaLoginAcct() {
		return caLoginAcct;
	}

	public String getCaLoginPassword() {
		return caLoginPassword;
	}

	public String getCaServletUrl() {
		return caServletUrl;
	}

	public String getCaLoginMessage() {
		return caLoginMessage;
	}

	public String getGlDBUPath() {
		return glDBUPath;
	}

	public String getGlDBUFile() {
		return glDBUFile;
	}

	public String getGlOBUPath() {
		return glOBUPath;
	}

	public String getGlOBUFile() {
		return glOBUFile;
	}

	public String getGlTimeFormat() {
		return glTimeFormat;
	}

	public String getCaCheckCertStateUrl() {
		return caCheckCertStateUrl;
	}

	public boolean isCheckVersion() {
		return checkVersion;
	}

	public String getPhone_CAServletUrl() {
		return phone_CAServletUrl;
	}

	public String getPhone_fnStatus() {
		return phone_fnStatus;
	}

	public String getPhone_applyCert() {
		return phone_applyCert;
	}

	public String getPhone_reNewCert() {
		return phone_reNewCert;
	}

	public String getPhone_certInstallComplete() {
		return phone_certInstallComplete;
	}

	public String getPhone_getCert() {
		return phone_getCert;
	}

	public String getPhone_getCertState() {
		return phone_getCertState;
	}

	public String getPhone_queryCert() {
		return phone_queryCert;
	}

	public boolean isHttps() {
		return getPhone_CAServletUrl().startsWith("https:");
	}

}
