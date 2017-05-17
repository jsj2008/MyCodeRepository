package api.client.trade;

import api.client.trade.base.TradeApiBase;
import api.client.trade.details.ClientUserApi;
import api.client.trade.details.SystemApi;

public class ClientTradeApi extends TradeApiBase {

	private SystemApi apiSystem = new SystemApi();
	private ClientUserApi apiClient = new ClientUserApi();

	public SystemApi getApiSystem() {
		return apiSystem;
	}

	public void setApiSystem(SystemApi apiSystem) {
		this.apiSystem = apiSystem;
	}

	public ClientUserApi getApiClient() {
		return apiClient;
	}

	public void setApiClient(ClientUserApi apiClient) {
		this.apiClient = apiClient;
	}

}
