package api.test;

import allone.util.socket.address.AddressCaptain;
import allone.util.socket.address.AddressNode;
import api.base.message.ITradeResult;
import api.client.ClientApi;
import api.client.trade.details.ClientUserApi;

public class MainTest {
	private AddressCaptain addressCaptain = null;
	private AddressNode currentAddress;
	private String delaerName;
	private String cryptPassword;

	public static void main(String[] args) {
		try {
			// AddressCaptain.loadData("E:\\work-svn\\ex02p\\trunk\\code\\server\\ex02-fund-com\\EX02P-API-FundDealer\\config\\FundDealer-127-19001.obj");
			AddressCaptain.loadData("E:\\loginTest.obj");

			MainTest fundTest = new MainTest();
			fundTest.handleDSTSList(true, "felix", "123456");
			fundTest.login("dsts");
			// ThreadUtil.sleepInM(2);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void handleDSTSList(boolean isLive, String dealerName, String password) throws Exception {
		if (isLive) {
			addressCaptain = AddressCaptain.createLiveAddressCaptain(dealerName);
		} else {
			addressCaptain = AddressCaptain.createDemoAddressCaptain(dealerName);
		}

		cryptPassword = allone.crypto.Crypt.encryptALLONE(password, dealerName);
		currentAddress = null;
	}

	private void login(String dstsName) throws Exception {
		if (addressCaptain == null) {
			throw new Exception("DSTS addresses need to be prepared first!");
		}

		currentAddress = addressCaptain.getAddress(dstsName);
		if (currentAddress == null) {
			throw new Exception("Given DSTS addresses not exist!");
		}

		if (!ClientApi.getInstance().initNetwork(addressCaptain, currentAddress)) {
			throw new Exception("init network failed!");
		}

		ClientUserApi clientUserApi = ClientApi.getInstance().getTradeApi().getApiClient();
		if (clientUserApi == null) {
			throw new Exception("invalid dealer trade api failed!");
		}

		ITradeResult tradeRlt = clientUserApi.login(this.delaerName, this.cryptPassword);
		System.out.println("--> loginResult : " + tradeRlt.getState());
		System.out.println("--> errorCode   : " + tradeRlt.getErrorCode());
		System.out.println("--> errorMessage: " + tradeRlt.getMessage());
	}
}
