package api.base.data.inter;

import api.base.data.inter.base.IDataBase;
import api.base.data.inter.base.IDataUnit;

public interface IDataCenter extends IDataBase {
	
	/**  
	 * @Title: initDataCenter
	 * @Description: 初始化数据中心
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean initDataCenter();
	
	/**  
	 * @Title: addDataUnit
	 * @Description: 添加数据单元
	 * @param @param dataUnit
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean 	addDataUnit(IDataUnit dataUnit);
	
	/**  
	 * @Title: getDataUnit
	 * @Description: 获取数据单元
	 * @param @param unitType
	 * @param @return
	 * @return IDataUnit
	 * @throws  
	 */
	public IDataUnit getDataUnit(String unitType);
	
}
