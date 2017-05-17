package api.base.data.inter.base;

/**   
 * @Project: EX03-API-Base 
 * @Title: IDataUnit.java 
 * @Package aex.api.base.data.center 
 * @Description: 数据类型
 * @author felix cao.jianguo@allone.cn 
 * @date 2015年2月11日 下午3:51:39 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public interface IDataUnit extends IDataBase {
	
	/**  
	 * @Title: getType
	 * @Description: 获取数据类型，其不同的客户端其数量类型定义不同
	 * @param @return
	 * @return String
	 * @throws  
	 */
	public String 	getType();
	
	/**  
	 * @Title: setType
	 * @Description: 设置数据类型
	 * @param @param value
	 * @return void
	 * @throws  
	 */
	public void		setType(String value);
}
