package api.client.trade.base;

import api.base.data.impl.ClientDataCenterCache;
import api.base.data.impl.business.ClientUserCache;
import api.base.data.impl.system.SystemCache;
import api.base.data.inter.base.IDataUnitType;
import api.base.message.ITradeApi;
import api.client.ClientApi;

public class TradeApiBase implements ITradeApi {

	public TradeApiBase() {
	}

	protected ClientDataCenterCache getDataCenterCache() {
		return (ClientDataCenterCache) ClientApi.getInstance().getDataCenter();
	}

	protected ClientUserCache getClientUserCache() {
		return (ClientUserCache) this.getDataCenterCache().getDataUnit(IDataUnitType.utClientUser);
	}

	protected SystemCache getSystemCache() {
		return (SystemCache) this.getDataCenterCache().getDataUnit(IDataUnitType.utSystem);
	}

}
