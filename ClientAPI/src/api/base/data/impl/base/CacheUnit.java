package api.base.data.impl.base;

import api.base.data.inter.base.IDataUnit;

public class CacheUnit implements IDataUnit {
	protected String unitType;
	protected boolean isDestroyed = false;

	@Override
	public boolean isEmpty() {
		return false;
	}

	@Override
	public boolean isDestroy() {
		return this.isDestroyed;
	}

	@Override
	public boolean update() {
		return false;
	}

	@Override
	public boolean updateFromServer() {
		return false;
	}

	@Override
	public void clean() {
	}

	@Override
	public synchronized void destroy() {
		if (this.isDestroy()) {
			return;
		}
		this.isDestroyed = true;
	}

	@Override
	public String getType() {
		return this.unitType;
	}

	@Override
	public void setType(String value) {
		this.unitType = value;
	}
}
