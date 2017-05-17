package api.base;

import api.base.data.inter.IDataCenter;
import api.base.message.ITradeApi;

public abstract class ApiBase {

	private IDataCenter dataCenter = null;
	private ITradeApi tradeApi = null;

	protected void setDataCenter(IDataCenter dataCenter) {
		this.dataCenter = dataCenter;
	}

	protected void setTradeApi(ITradeApi tradeApi) {
		this.tradeApi = tradeApi;
	}

	protected IDataCenter getDataCenterInternal() {
		return this.dataCenter;
	}

	protected ITradeApi getTradeApiInternal() {
		return this.tradeApi;
	}
}
