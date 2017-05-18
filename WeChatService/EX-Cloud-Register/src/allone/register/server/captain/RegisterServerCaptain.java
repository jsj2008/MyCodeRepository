package allone.register.server.captain;

import allone.Log.simpleLog.log.LogProxy;
import allone.register.server.cadts.CADTSCaptain;
import allone.register.server.config.ConfigCaptain;

/**
 * @author zhang.lei
 *
 */
public class RegisterServerCaptain {
	/**
	 * 
	 * @Title: destroy
	 * @Description: 销毁方法
	 * @param 
	 * @return void
	 * @throws  
	 */
	public void destroy() {
		try {
			CADTSCaptain.getInstance().destroy();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			LogProxy.destory();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @Title: init
	 * @Description: 初始化方法
	 * @param @param rootPath
	 * @param @return
	 * @return boolean
	 * @throws  
	 */
	public boolean init(String rootPath) {
		if (!ConfigCaptain.getInstance().init(rootPath)) {
			System.out.println("初始化Config失败！");
			return false;
		}
		LogProxy.init(ConfigCaptain.getInstance().getLogPath());
		if (!CADTSCaptain.getInstance().init()) {
			LogProxy.ErrPrintln("初始化CADTS失败！");
			return false;
		}
		return true;

	}
}
