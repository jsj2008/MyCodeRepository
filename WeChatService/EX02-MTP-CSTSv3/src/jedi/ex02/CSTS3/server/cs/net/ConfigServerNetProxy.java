package jedi.ex02.CSTS3.server.cs.net;

import java.util.ArrayList;

import allone.Log.simpleLog.log.LogProxy;
import allone.configProxy.comm.ipop.IPFather;
import allone.configProxy.comm.ipop.OPFather;
import allone.configProxy.net.proxy.ClientForCSProxy;
import allone.configProxy.net.proxy.IClientForCSListener;
import allone.util.net.multi.client.config.ClientConfig;
import allone.util.net.multi.monitor.struct.Monitor_Data;
import allone.util.net.multi.monitor.struct.Monitor_SessionContainer_Info;
import allone.util.net.multi.monitor.struct.Monitor_Session_Info;

/**   
 * @Project: EX02-MTP-CSTSv3 
 * @Title: ConfigServerNetProxy.java 
 * @Package jedi.ex02.CSTS3.server.cs.net 
 * @Description: TODO 
 * @author amy wang.jingjing@allone.cn 
 * @date 2015年11月11日 上午11:27:23 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class ConfigServerNetProxy implements IClientForCSListener {

	private static ConfigServerNetProxy instance = new ConfigServerNetProxy();

	private boolean destroy = false;

	private ClientForCSProxy proxy = new ClientForCSProxy();

	private ConfigServerNetProxy(){}

	public static ConfigServerNetProxy getInstance() {
		return instance;
	}

	public boolean init(ClientConfig config) {
		config.setBackup_type(ClientConfig.BACKUP_TYPE_ACTIVE_STANDBY);
		// 初始�?客户端网�?
		destroy = false;
		new _RunMonitor().start();
		return proxy.init(config, this);
	}
	
	public void destroy() {
		destroy = true;
		proxy.destroy();
	}

	/**  
	 * @Title: doTrade
	 * @Description: send to ConfigServer
	 * @param @param ip
	 * @param @return
	 * @param @throws Exception
	 * @return OPFather
	 * @throws  
	 */
	public OPFather doTrade(IPFather ip) {
		OPFather op = proxy.trade(ip);
		LogProxy.printTrade(ip.get_ID(), ip, op, op.isSucceed());
		return op;
	}
	
	@Override
	public OPFather onTrade(IPFather ip) {
		return null;
	}

	@Override
	public void onDataCall(Object data) {
		try {
			if(data instanceof IPFather) {
				System.out.println("ClientForCSProxy onDataCall");
			}
		} catch (Exception e) {
			e.printStackTrace();
			LogProxy.printException(e);
		}

	}

	class _RunMonitor extends Thread {

		@Override
		public void run() {
			while (!destroy) {
				try {
					sleep(60 * 1000);
				} catch (InterruptedException e) {
				}
				try {
					StringBuffer sb = new StringBuffer();
					sb.append("------------------------------------------------------------------\r\n");
					sb.append("[EX02-MTP-CSTSV3: ConfigServerNetProxy --> ConfigServer] client\r\n");
					sb.append("------------------------------------------------------------------\r\n");
					sb.append("\r\n");
					Monitor_Data mon = proxy.createMonitorData();
					Monitor_SessionContainer_Info infos = mon.getSessionContainerInfo();
					ArrayList<Monitor_Session_Info> list = infos.getSessionInfoList();
					for (Monitor_Session_Info info : list) {
						sb.append(info.getID() + "\t" + info.getHostName() + "\t" + info.getSessionID() + "\t" + info.getPing() + "\r\n");
					}
					sb.append("------------------------------------------------------------------\r\n");
					LogProxy.OutPrintln(sb.toString());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
