package api.client;

import allone.util.socket.address.AddressCaptain;
import allone.util.socket.address.AddressNode;
import api.base.ApiBase;
import api.base.data.impl.ClientDataCenterCache;
import api.base.data.inter.IClientDataCenter;
import api.client.network.ClientNetCaptain;
import api.client.trade.ClientTradeApi;
import api.client.trade.details.ClientUserApi;

public class ClientApi extends ApiBase {
	private static ClientApi gsFundDeaerApi = new ClientApi();

	public static ClientApi getInstance() {
		return gsFundDeaerApi;
	}

	public ClientApi() {
		this.initDataCenter();
		this.initTradeApi();
	}

	/**
	 *   
	 * 
	 * @Title: initNetwork
	 * @Description: 初始化网络，外部调用
	 * @param @param captain
	 * @param @param address
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean initNetwork(AddressCaptain captain, AddressNode address) {
		try {
			return ClientNetCaptain.getInstance().init(captain, address);
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}

	/**
	 *   
	 * 
	 * @Title: getIsLogined
	 * @Description: 判断当前是否是登录状态
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean getIsLogined() {
		ClientUserApi clientUserApi = this.getTradeApi().getApiClient();
		if (clientUserApi == null) {
			return false;
		} else {
			return clientUserApi.getIsLogined();
		}
	}

	/**
	 *   
	 * 
	 * @Title: getDataCenter
	 * @Description: 获取基金的数据中心
	 * @param @return
	 * @return IFundDataCenter
	 * @throws  
	 */
	public IClientDataCenter getDataCenter() {
		return (IClientDataCenter) this.getDataCenterInternal();
	}

	public ClientTradeApi getTradeApi() {
		return (ClientTradeApi) this.getTradeApiInternal();
	}

	/**
	 *   
	 * 
	 * @Title: initDataCenter
	 * @Description: 初始化数据中心，目前是内部调用
	 * @param 
	 * @return void
	 * @throws  
	 */
	private void initDataCenter() {
		ClientDataCenterCache dataCenter = new ClientDataCenterCache();
		dataCenter.initDataCenter();
		this.setDataCenter(dataCenter);
	}

	/**
	 *   
	 * 
	 * @Title: initTradeApi
	 * @Description: 初始化数据中心，目前是内部调用
	 * @param 
	 * @return void
	 * @throws  
	 */
	private void initTradeApi() {
		ClientTradeApi tradeApi = new ClientTradeApi();
		this.setTradeApi(tradeApi);
	}

}
