package jedi.ex01.client.station.api;

import java.util.ArrayList;
import java.util.Locale;

import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5001;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5001;
import jedi.ex01.CSTS3.proxy.client.CSTSProxy;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.CSTS3.proxy.util.JsonInitUtil;
import jedi.ex01.client.station.api.CSTS.APIReConnectOperator;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.bankserver.BankOperator;
import jedi.ex01.client.station.api.debug.APIDebugLog;
import jedi.ex01.client.station.api.doc.operator.DocOperator;
import jedi.ex01.client.station.api.event.API_IDEvent;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;
import jedi.ex01.client.station.api.fix.UserDocFixer;
import allone.util.socket.address.AddressCaptain;
import allone.util.socket.address.AddressNode;
import allone.util.socket.address.SockProxyNode;

/**
 * @author Administrator
 */
public class ClientAPI {
	static {
		AddressCaptain.presetPrecheckBuffer(CSTSProxy.getPrecheckbuf());
	}
	private static ClientAPI instance = new ClientAPI();
	private UserDocFixer userDocFixer = null;
	// private UIActiveChecker activeChecker = null;
	private String userName;
	private String cryptPassword = null;
	private AddressCaptain addressCaptain = null;
	private AddressNode currentAddress;
	private String rootDataPath = System.getProperty("user.dir");
	private boolean isFirstLogin = true;
	private long firstLoginTime = -1;
	private boolean docInited = false;
	private APIReConnectOperator connectOperator;
	public Long[] accounts;

	private int marketId;

	public String getRootDataPath() {
		return rootDataPath;
	}

	public void setRootDataPath(String rootDataPath) {
		this.rootDataPath = rootDataPath;
	}

	private ClientAPI() {
		JsonInitUtil.init();
		BankOperator.getInstance().init();
	}

	public static int getMarketId() {
		return ClientAPI.getInstance().getMarketIdInternal();
	}

	public static void setMarketId(int marketId) {
		ClientAPI.getInstance().setMarketIdInternal(marketId);

	}

	public void setMarketIdInternal(int marketId) {
		this.marketId = marketId;
	}

	public int getMarketIdInternal() {
		return marketId;
	}

	public static ClientAPI getInstance() {
		return instance;
	}

	// public static void prepareAddressCaptain(String addressFile) throws
	// Exception {
	// AddressCaptain.loadData(addressFile);
	// }

	public static void prepareAddressCaptain4XML(String xml) throws Exception {
		AddressCaptain.loadDataFromXML(xml);
	}

	public static ArrayList<SockProxyNode> getSocks5ProxyList() {
		return AddressCaptain.getSockProxyList();
	}

	public static void setSocks5Proxy(SockProxyNode proxy) {
		AddressCaptain.setGlobalSocks5Proxy(proxy);
	}

	public static void removeSocks5Proxy() {
		AddressCaptain.removeGlobalSocks5Proxy();
	}

	/**
	 * First step To prepare CSTS addresses Block method
	 * 
	 * @param addressFile
	 * @param isLive
	 * @throws Exception
	 */
	public void prepareCSTSList(boolean isLive, String userName, String password, boolean byCSTSManager) throws Exception {
		currentAddress = null;
		if (addressCaptain == null || addressCaptain.isLive() != isLive) {
			if (isLive) {
				addressCaptain = AddressCaptain.createLiveAddressCaptain(userName, byCSTSManager);
			} else {
				addressCaptain = AddressCaptain.createDemoAddressCaptain(userName, byCSTSManager);
			}
			// addressCaptain.rank();
		}
		this.userName = userName;
		this.cryptPassword = allone.crypto.Crypt.encryptALLONE(password, userName);
	}

	public void resetPassword(String password) {
		this.cryptPassword = allone.crypto.Crypt.encryptALLONE(password, userName);
	}

	public int loginToBestAddress() throws Exception {
		if (addressCaptain == null) {
			throw new Exception("CSTS addresses need to be prepared first!");
		}
		currentAddress = addressCaptain.getBestAddress();
		addressCaptain.debug_list();
		int result = login(currentAddress);
		APIDebugLog.getInstance().logout("Login end:7", APIDebugLog.level_info);
		return result;
	}

	public void requestToRelogin() {
		API_IDEventCaptain.getInstance().fireEventChanged(new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT));
	}

	private int login(AddressNode address) throws Exception {
		int result;
		try {
			boolean flag = CSTSCaptain.getInstance().init(addressCaptain, address);
			if (!flag) {
				return MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_NETERR;
			} else {
				result = _doLogin(userName, cryptPassword);
				// if (activeChecker == null) {
				// activeChecker = new UIActiveChecker();
				// activeChecker.start();
				// }
			}
		} catch (Exception e) {
			APIDebugLog.getInstance().logout("Login end:4-1", APIDebugLog.level_info);
			if (address != null) {
				e.printStackTrace();
				APIDebugLog.getInstance().logout("Login error:" + e.getMessage(), APIDebugLog.level_error);
				throw new Exception(address.getName() + "," + address.getIp() + ":" + address.getPort() + " " + e);
			} else {
				throw e;
			}
		}
		APIDebugLog.getInstance().logout("Login end:5", APIDebugLog.level_info);
		if (result == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED) {
			if (connectOperator == null) {
				connectOperator = new APIReConnectOperator();
				connectOperator.init();
			}
			isFirstLogin = false;
		}
		APIDebugLog.getInstance().logout("Login end:6", APIDebugLog.level_info);
		return result;
	}

	public String[] getAddressList() {
		return addressCaptain.getServNames();
	}

	private int _doLogin(String userName, String encryptedPassword) {
		IP_TRADESERV5001 ip = new IP_TRADESERV5001();
		ip.setUserName(userName);
		ip.setPassword(encryptedPassword);
		ip.setFirstLogin(isFirstLogin);
		ip.setFirstLoginTime(firstLoginTime);
		long l1 = System.currentTimeMillis();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		long l2 = System.currentTimeMillis();
		APIDebugLog.getInstance().logout("Login used time[l2-l1]" + (l2 - l1), APIDebugLog.level_info);
		if (!opfather.isSucceed()) {
			APIDebugLog.getInstance().logout("Login error:" + opfather.getErrCode() + " | " + opfather.getErrMessage(),
					APIDebugLog.level_error);
			return MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_CADTSERR;
		}
		APIDebugLog.getInstance().logout("Login end:1", APIDebugLog.level_info);
		OP_TRADESERV5001 op = (OP_TRADESERV5001) opfather;
		APIDebugLog.getInstance().logout("Login end:2", APIDebugLog.level_info);
		accounts = op.getAccounts();
		APIDebugLog.getInstance().logout("Login end:3", APIDebugLog.level_info);
		if (isFirstLogin) {
			firstLoginTime = op.getLoginTime();
		}
		APIDebugLog.getInstance().logout("Login end:4", APIDebugLog.level_info);
		return op.getResult();
	}

	/**
	 * ��һ�ε�½�ɹ�����Ҫͨ��˷�������ȡ���е�Doc���
	 * 
	 * @return
	 */
	public boolean initDoc(Locale locale, String clientCfgKeys[]) {
		if (!DocOperator.getInstance().initDoc(locale, clientCfgKeys)) {
			return false;
		}
		if (userDocFixer != null) {
			userDocFixer.destroy();
		}
		userDocFixer = new UserDocFixer();
		userDocFixer.start();
		docInited = true;
		return true;
	}

	public static String getUserName() {
		return instance.userName;
	}

	public void destroy() {
		if (userDocFixer != null) {
			userDocFixer.destroy();
			userDocFixer = null;
		}
	}

	public AddressNode getCurrentAddress() {
		return currentAddress;
	}

	public AddressCaptain getAddressCaptain() {
		return addressCaptain;
	}

	public boolean isNetOK() {
		return CSTSCaptain.getInstance().isNetOK();
	}

	public boolean isDocInited() {
		return docInited;
	}

}
