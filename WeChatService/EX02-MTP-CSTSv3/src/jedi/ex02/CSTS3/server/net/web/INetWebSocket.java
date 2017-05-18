package jedi.ex02.CSTS3.server.net.web;

import java.nio.ByteBuffer;

/**   
 * @Project: EX02-MTP-CSTS-WS 
 * @Title: INetSocket.java 
 * @Package aex.CSTS3.server.network.idefine 
 * @Description: 网络连接接口 
 * @author felix cao.jianguo@allone.cn 
 * @date 2015�?�?6日 下�?:43:51 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public interface INetWebSocket {
	
	/**  
	 * @Title: getRemoteIp
	 * @Description: TODO
	 * @param @return
	 * @return String
	 * @throws  
	 */
	public String getRemoteIp();
	/**  
	 * @Title: getRemotePort
	 * @Description: TODO
	 * @param @return
	 * @return int
	 * @throws  
	 */
	public int    getRemotePort();

	/**  
	 * @Title: sendTextMessage
	 * @Description: TODO
	 * @param @param txtMsg
	 * @return void
	 * @throws  
	 */
	public void sendTextMessage(String txtMsg);
	/**  
	 * @Title: sendBinaryMessage
	 * @Description: TODO
	 * @param @param buffer
	 * @return void
	 * @throws  
	 */
	public void sendBinaryMessage(ByteBuffer buffer);
	/**  
	 * @Title: closeNetSocket
	 * @Description: TODO
	 * @param 
	 * @return void
	 * @throws  
	 */
	public void closeNetSocket();
}
