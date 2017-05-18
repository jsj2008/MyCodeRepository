package jedi.ex02.CSTS3.server.config;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletContext;

import jedi.ex02.CSTS3.server.cs.net.ConfigServerNetProxy;
import allone.Log.simpleLog.log.LogProxy;
import allone.configProxy.api.CommAPI;
import allone.configProxy.comm.ipop.OPFather;
import allone.configProxy.comm.ipop.server.IP_S4CS1001;
import allone.configProxy.comm.ipop.server.IP_S4CS1002;
import allone.configProxy.comm.ipop.server.OP_S4CS1001;
import allone.configProxy.comm.struct.client.ClientSystem;
import allone.configProxy.comm.struct.client.MapType.ClientNode;
import allone.configProxy.comm.struct.server.customize.cqtsconfig.JCQTS_Config;
import allone.configProxy.comm.struct.server.service.CSNode;
import allone.configProxy.comm.struct.server.service.CSServerNode;
import allone.configProxy.interfaces.IServCallNameTable4CS;
import allone.configProxy.interfaces.keyMapping.IParseKeyMapping;
import allone.util.net.multi.client.config.ClientConfig;
import allone.util.socket.address.AddressNode;
import allone.util.socket.address.AddressPack;
import allone.util.socket.address.AddressRecord;


public class CSConfigCaptain {

	private String logPath;
	private boolean isRunning = false;

	private String CADTSIp;
	private int CADTSCmdPort;
	private int CADTSDataPort;
	private String CADTSServName;

	private boolean useCmd = false;
	private int maxFattackNum = 160;
	private boolean sendAllQuote = true;
	private boolean toSendQuoteVol = false;
	private long toSendInfo_TRADESERV1016DelayTime = 0;
	private String netWeightDir;
	private int SecurityXMLPort;
	private String webdomain;
	private AddressRecord record;
	private String cstsName;
	private int clientSocketPort;
	private int maxUser;
	
	public boolean init(ServletContext context) {
		isRunning = true;
		
		isRunning = initCommConfig(context);

		return isRunning;
	}


	private ClientSystem clientSystem;
	private ClientNode clientNode;
	
	private boolean initCommConfig(ServletContext context) {
		// 0. 获取环境变量值（key: CS4CommDataInterface.SystemProperty�?
		String clientConfigPath = getEnv();
		if(clientConfigPath == null) {
			System.out.println(" ==== Serv_EX02P_MTP_CSTSV3:[init] clientConfigPath is null ==== ");
			return false;
		}

		// 1. 根据clientConfigPath 解析 ConfigServer 的客户端配置文件�?
		clientSystem = initClientSystemConfig(clientConfigPath);
		if(clientSystem == null) {
			System.out.println(" ==== Serv_EX02P_MTP_CSTSV3:[init] clientSystem is null: ["+ clientConfigPath + "] not exist] ==== ");
			return false;
		}

		// 获取 tomcat 上层folder
		String contextPath = context.getRealPath("WEB-INF");
		File file = new File(contextPath);
		String folderName = file.getParentFile().getParentFile().getParentFile().getParentFile().getName();
		// 2. 根据folder 获取 当前服务的subSystem
		clientNode = clientSystem.getClientNode(folderName);

		// TODO: 3. 初始化日志记录器
		String logRootPath = clientSystem.getLogRootPath();
		if(logRootPath == null) {
			logRootPath = "D:\\logs";
		}
		logPath = CommAPI.getLogPath(logRootPath, IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3, clientNode);
		LogProxy.init(logPath);
		
		// 4. 初始化与ConfigServer的网络连�?
		ClientConfig config = initNetClientConfig(clientSystem);
		while (isRunning && !ConfigServerNetProxy.getInstance().init(config)) {
			LogProxy.OutPrintln(" ==== Serv_EX02P_MTP_CSTSV3:[init] ConfigServerNet failed ==== ");
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		LogProxy.OutPrintln(" ==== Serv_EX02P_MTP_CSTSV3:[init] ConfigServerNet Succeed ==== ");

		// 5. 从ConfigServer请求数据
		List<String> servList = new ArrayList<String>();
		servList.add(IServCallNameTable4CS.Serv_EX02P_CADTS);
		
		IP_S4CS1001 ip1001 = initIP(clientSystem , clientNode, IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3, servList);
		OPFather op = ConfigServerNetProxy.getInstance().doTrade(ip1001);
		while (isRunning && ((op == null) || (!op.isSucceed()))) {
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			op = ConfigServerNetProxy.getInstance().doTrade(ip1001);
			if(op != null && !op.isSucceed()) {
				LogProxy.OutPrintln(" ==== Serv_EX02P_MTP_CSTSV3:[init] send request to ConfigServer failed ==== ");
				sendServerStateToConfigServer(false, op.getErrCode() + ": " + op.getErrMessage());
			}
		}

		if(op.isSucceed()) {
			// 6. 初始化Config
			isRunning = init(op);
		}
		return isRunning;
	}

	public void sendServerStateToConfigServer(boolean state, String errorMessage) {
		if(clientSystem == null || clientNode == null) {
			System.out.println("clientConfig.xml read Failed");
			LogProxy.OutPrintln("clientConfig.xml read Failed");
			return;
		}
		IP_S4CS1002 ip1002 = CommAPI.initIP(clientSystem, clientNode, IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3, state, errorMessage);
		ConfigServerNetProxy.getInstance().doTrade(ip1002);
	}
	
	private boolean init(OPFather op) {
		OP_S4CS1001 op1001 = (OP_S4CS1001)op;
		// 1. 解析通用设置

		// 特定的serverNode
		HashMap<String, CSServerNode> serverNodeMap = op1001.getServerNodeMap();

		// 解析�?Serv_EX02_CADTS 节点
		CSServerNode CADTSNode = serverNodeMap.get(IServCallNameTable4CS.Serv_EX02P_CADTS);
		ConcurrentHashMap<String, CSNode> cNodeMap = CADTSNode.getNodeMap();
		if(!initCADTSNode(cNodeMap)) {
			LogProxy.OutPrintln(" ==== Serv_EX02P_MTP_CSTSV3:[init] parse Serv_EX02P_CADTS failed ==== ");
			return false;
		}

		// 解析�?Serv_EX02P_MTP_CSTSV3 节点
		CSServerNode reportServerNode = serverNodeMap.get(IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3);
		ConcurrentHashMap<String, CSNode> dNodeMap = reportServerNode.getNodeMap();
		if(!initCSTSNode(dNodeMap)) {
			LogProxy.OutPrintln(" ==== Serv_EX02P_MTP_CSTSV3:[init] parse Serv_EX02P_MTP_CSTSV3 failed ==== ");
			return false;
		}
		return true;
	}

	private boolean initCSTSNode(ConcurrentHashMap<String, CSNode> dNodeMap) {
		if(checkNull(dNodeMap, "name", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			return false;
		}
		this.cstsName = dNodeMap.get("name".toUpperCase()).getValueStr();
		
		if(checkNull(dNodeMap, "clientSocketPort", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			return false;
		}
		this.clientSocketPort = Integer.parseInt(dNodeMap.get("clientSocketPort".toUpperCase()).getValueStr());
		
		if(!checkNull(dNodeMap, "maxUser", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			this.maxUser = Integer.parseInt(dNodeMap.get("maxUser".toUpperCase()).getValueStr());
		}
		
		if(!checkNull(dNodeMap, "useCmd", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			String useCmdStr = dNodeMap.get("useCmd".toUpperCase()).getValueStr();
			this.useCmd = useCmdStr.equalsIgnoreCase("true");
		}
		
		if(!checkNull(dNodeMap, "sendQuoteVol", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			String sendQuoteVolStr = dNodeMap.get("sendQuoteVol".toUpperCase()).getValueStr();
			this.toSendQuoteVol = sendQuoteVolStr.equalsIgnoreCase("true");
		}
		
		if(!checkNull(dNodeMap, "TRADESERV1016DelayTime", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			String TRADESERV1016DelayTimeStr = dNodeMap.get("TRADESERV1016DelayTime".toUpperCase()).getValueStr();
			this.toSendInfo_TRADESERV1016DelayTime = Integer.valueOf(TRADESERV1016DelayTimeStr.trim());
		}
		
		if(!checkNull(dNodeMap, "sendAllQuote", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			String sendAllQuoteStr = dNodeMap.get("sendAllQuote".toUpperCase()).getValueStr();
			this.sendAllQuote = Boolean.parseBoolean(sendAllQuoteStr);
		}
		
		if(!checkNull(dNodeMap, "maxFattackNum", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			String maxFattackNumStr = dNodeMap.get("maxFattackNum".toUpperCase()).getValueStr();
			this.maxFattackNum = Integer.parseInt(maxFattackNumStr);
		}
		
		if(!checkNull(dNodeMap, "webdomain", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			this.webdomain = dNodeMap.get("webdomain".toUpperCase()).getValueStr();
		}
		
		if(!checkNull(dNodeMap, "SecurityXMLPort", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			String securityXMLPortStr = dNodeMap.get("SecurityXMLPort".toUpperCase()).getValueStr();
			this.SecurityXMLPort = Integer.parseInt(securityXMLPortStr);
		}
		
		if(!checkNull(dNodeMap, "netWeightDir", IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3)) {
			this.netWeightDir = dNodeMap.get("netWeightDir".toUpperCase()).getValueStr();
		}
		
		//
		if (dNodeMap.get(IParseKeyMapping.ParseKey_JCQTS_Config.toUpperCase()) == null || dNodeMap.get(IParseKeyMapping.ParseKey_JCQTS_Config.toUpperCase()).getValueObj() == null) {
			LogProxy.OutPrintln(" --- Serv_EX02P_MTP_CSTSV3: " + IServCallNameTable4CS.Serv_EX02P_MTP_CSTSV3 + " " + IParseKeyMapping.ParseKey_JCQTS_Config + " is null!!! --- ");
			return false;
		}
		ArrayList<JCQTS_Config> fdList = (ArrayList<JCQTS_Config>) dNodeMap.get(IParseKeyMapping.ParseKey_JCQTS_Config.toUpperCase()).getValueObj();
		this.record = new AddressRecord();
		ArrayList<AddressPack> liveAddressList = new ArrayList<AddressPack>();
		ArrayList<AddressPack> demoAddressList = new ArrayList<AddressPack>();
		
		for (JCQTS_Config cfg : fdList) {
			AddressNode node = new AddressNode();
			node.setIp(cfg.getIP());
			node.setName(cfg.getName());
			node.setPort(Integer.parseInt(cfg.getPORT()));
			if(cfg.getisLive()) {
				AddressPack pack = new AddressPack();
				pack.add(node);
				pack.setDemo(false);
				liveAddressList.add(pack);
			} else {
				AddressPack pack = new AddressPack();
				pack.add(node);
				pack.setDemo(true);
				demoAddressList.add(pack);
			}
		}
		record.setDemoAddressList((ArrayList<AddressPack>) demoAddressList);
		record.setLiveAddressList((ArrayList<AddressPack>) liveAddressList);
		return true;
	}


	private boolean checkNull(ConcurrentHashMap<String, CSNode> cNodeMap, String value, String title) {
		if(cNodeMap.get(value.toUpperCase()) == null || (cNodeMap.get(value.toUpperCase()).getValueStr() == null || cNodeMap.get(value.toUpperCase()).getValueStr().isEmpty())) {
			LogProxy.OutPrintln(" ---- Serv_EX02P_MTP_CSTSV3: "+ title + " " + value + " is null ----");
			return true;
		}
		return false;

	}

	private IP_S4CS1001 initIP(ClientSystem clientSystem, ClientNode clientNode, String serverName, List<String> servList) {
		IP_S4CS1001 ip1001 = CommAPI.initIP(clientSystem, clientNode, serverName, servList);
		return ip1001;
	}

	private ClientConfig initNetClientConfig(ClientSystem clientSystem) {
		ClientConfig config = CommAPI.initNetClientConfig(clientSystem);
		return config;
	}

	private ClientSystem initClientSystemConfig(String clientConfigPath) {
		ClientSystem clientSystem = null;
		try {
			clientSystem = CommAPI.initClientSystemConfig(clientConfigPath);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return clientSystem;
	}

	private String getEnv() {
		String clientConfigPath = CommAPI.getEnv(); 

		if(clientConfigPath == null || clientConfigPath.isEmpty()) {
			isRunning = false;
			return null;
		}
		return clientConfigPath;
	}


	private boolean initCADTSNode(ConcurrentHashMap<String, CSNode> cNodeMap) {
		if(checkNull(cNodeMap, "ip", IServCallNameTable4CS.Serv_EX02P_CADTS)) {
			return false;
		}
		this.CADTSIp = cNodeMap.get("ip".toUpperCase()).getValueStr();

		if(checkNull(cNodeMap, "cmdPort", IServCallNameTable4CS.Serv_EX02P_CADTS)) {
			return false;
		}
		this.CADTSCmdPort = Integer.parseInt(cNodeMap.get("cmdPort".toUpperCase()).getValueStr());

		if(checkNull(cNodeMap, "dataPort", IServCallNameTable4CS.Serv_EX02P_CADTS)) {
			return false;
		}
		this.CADTSDataPort = Integer.parseInt(cNodeMap.get("dataPort".toUpperCase()).getValueStr());

		if(checkNull(cNodeMap, "name", IServCallNameTable4CS.Serv_EX02P_CADTS)) {
			return false;
		}
		this.CADTSServName = cNodeMap.get("name".toUpperCase()).getValueStr();
		return true;
	}

	public void destroy() {
	}

	public String getLogPath() {
		return logPath;
	}

	public String getCADTSIp() {
		return CADTSIp;
	}

	public int getCADTSCmdPort() {
		return CADTSCmdPort;
	}

	public int getCADTSDataPort() {
		return CADTSDataPort;
	}

	public String getCADTSServName() {
		return CADTSServName;
	}

	public boolean isUseCmd() {
		return useCmd;
	}

	public int getMaxFattackNum() {
		return maxFattackNum;
	}

	public boolean isSendAllQuote() {
		return sendAllQuote;
	}

	public boolean isToSendQuoteVol() {
		return toSendQuoteVol;
	}

	public long getToSendInfo_TRADESERV1016DelayTime() {
		return toSendInfo_TRADESERV1016DelayTime;
	}

	public String getNetWeightDir() {
		return netWeightDir;
	}

	public String getCstsName() {
		return cstsName;
	}

	public int getClientSocketPort() {
		return clientSocketPort;
	}

	public int getMaxUser() {
		return maxUser;
	}

	public int getSecurityXMLPort() {
		return SecurityXMLPort;
	}

	public String getWebdomain() {
		return webdomain;
	}

	public AddressRecord getRecord() {
		return record;
	}
	
}
