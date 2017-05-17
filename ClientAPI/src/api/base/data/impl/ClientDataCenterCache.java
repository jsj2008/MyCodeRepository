package api.base.data.impl;

import api.base.data.impl.business.ClientUserCache;
import api.base.data.impl.system.SystemCache;
import api.base.data.inter.IClientDataCenter;
import api.base.data.inter.base.IDataUnitType;
import api.base.data.inter.business.IDataClientUser;
import api.base.data.inter.system.IDataSystem;

public class ClientDataCenterCache extends DataCenterCache implements IClientDataCenter {

	@Override
	public boolean initDataCenter() {
		boolean addRlt = true;
		addRlt = addRlt && this.addDataUnit(IDataUnitType.utClientUser, new ClientUserCache());
		addRlt = addRlt && this.addDataUnit(IDataUnitType.utSystem, new SystemCache());
		return addRlt;
	}

	@Override
	public synchronized boolean updateFromServer() {
		return updateFundDataFromServer();
	}

	protected boolean updateFundDataFromServer() {
		// ITradeResult result =
		// FundDealerApi.getInstance().getTradeApi().getDealerApi().queryFundAccount();
		// if (result.getState() != FundDataTypeDefine.FUND_TRADE_SUCCESS) {
		// LogProxy.ErrPrintln("query fund account failed.");
		// return false;
		// }

		return true;
	}

	@Override
	public IDataClientUser getClientUserCache() {
		return (IDataClientUser) this.getDataUnit(IDataUnitType.utClientUser);
	}

	@Override
	public IDataSystem getSystemCache() {
		return (IDataSystem) this.getDataUnit(IDataUnitType.utSystem);
	}

}
