package api.base.data.inter;

import api.base.data.inter.business.IDataClientUser;
import api.base.data.inter.system.IDataSystem;

public interface IClientDataCenter extends IDataCenter {

	public IDataSystem getSystemCache();

	public IDataClientUser getClientUserCache();

}
