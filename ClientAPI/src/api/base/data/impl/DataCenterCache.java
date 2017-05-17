package api.base.data.impl;

import java.util.HashMap;

import api.base.data.inter.IDataCenter;
import api.base.data.inter.base.IDataUnit;

public abstract class DataCenterCache implements IDataCenter {
	/**
	 * @Fields cacheDataUnitMap : 缓存数据，键值是：IDataUnitType
	 */
	private HashMap<String, IDataUnit> cacheDataUnitMap = new HashMap<String, IDataUnit>();
	private boolean isDestroy = false;

	@Override
	public boolean isEmpty() {
		if (this.isDestroy()) {
			return true;
		}
		return this.cacheDataUnitMap.size() == 0;
	}

	@Override
	public boolean isDestroy() {
		return this.isDestroy;
	}

	@Override
	public synchronized boolean update() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public synchronized boolean updateFromServer() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public synchronized void clean() {
		if (this.cacheDataUnitMap == null) {
			return;
		}
		synchronized (this.cacheDataUnitMap) {
			for (IDataUnit dataUnit : this.cacheDataUnitMap.values()) {
				dataUnit.clean();
			}
			this.cacheDataUnitMap.clear();
		}
	}

	@Override
	public void destroy() {
		this.isDestroy = true;
		this.clean();
	}

	@Override
	public boolean addDataUnit(IDataUnit dataUnit) {
		if (this.isDestroy() || dataUnit == null || dataUnit.getType() == null) {
			return false;
		}
		synchronized (this.cacheDataUnitMap) {
			this.cacheDataUnitMap.put(dataUnit.getType(), dataUnit);
			return true;
		}
	}

	@Override
	public IDataUnit getDataUnit(String unitType) {
		if (this.isDestroy()) {
			return null;
		}
		synchronized (this.cacheDataUnitMap) {
			return this.cacheDataUnitMap.get(unitType);
		}
	}

	protected boolean addDataUnit(String unitType, IDataUnit dataUnit) {
		if (dataUnit == null || unitType == null) {
			return false;
		}
		dataUnit.setType(unitType);
		return this.addDataUnit(dataUnit);
	}
}
