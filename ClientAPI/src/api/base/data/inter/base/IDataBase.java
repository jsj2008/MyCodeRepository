package api.base.data.inter.base;

/**   
 * @Project: EX03-API-Base 
 * @Title: IDataBase.java 
 * @Package aex.api.base.data.center 
 * @Description: 数据管理基类 
 * @author felix cao.jianguo@allone.cn 
 * @date 2015年2月11日 下午3:51:39 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public interface IDataBase {
	
	/**  
	 * @Title: isEmpty
	 * @Description: 是否是空数据
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean isEmpty();
	
	/**  
	 * @Title: isDestroy
	 * @Description: 是否已经销毁
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean isDestroy();
	
	/**  
	 * @Title: update
	 * @Description: 更新数据,有些数据需要计算从而获得更新
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean 	update();
	
	/**  
	 * @Title: updateFromServer
	 * @Description: 从服务器上更新数据
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean	updateFromServer();
	
	/**  
	 * @Title: clean
	 * @Description: 清空数据
	 * @param 
	 * @return void
	 * @throws  
	 */
	public void clean();
	
	/**  
	 * @Title: destroy
	 * @Description: 销毁数据对象
	 * @param 
	 * @return void
	 * @throws  
	 */
	public void destroy();
}
