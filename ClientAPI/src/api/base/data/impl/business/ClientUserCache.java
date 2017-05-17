package api.base.data.impl.business;

import api.base.data.impl.base.CacheUnit;
import api.base.data.inter.business.IDataClientUser;
import api.struct.ClientUser;

public class ClientUserCache extends CacheUnit implements IDataClientUser {

	private ClientUser mainClientUser;

	@Override
	public ClientUser getClientUser() {
		return this.mainClientUser;
	}

}
