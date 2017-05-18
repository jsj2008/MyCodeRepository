package jedi.ex02.CSTS3.server.monitor;

import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.monitor.task.MonitorTask_OnlineUser;
import monitor.comm.TaskType;
import monitor.comm.struct.res.general.db.NormalServiceResult;
import monitor.proxy.client.captain.MonitorClientCaptain;
import monitor.proxy.client.trade.task.HeartbeatTask;
import allone.Log.simpleLog.log.LogProxy;

public class MonitorCaptain {

	private MonitorClientCaptain monitorClientCaptain;

	public boolean init(String rootPath) {
		boolean isInitSuccess = false;
		
		/*
		 * 初始化监控部分启动类
		 */
		monitorClientCaptain = new MonitorClientCaptain(rootPath, StaticContext.getCSConfigCaptain().getCstsName());
		isInitSuccess = monitorClientCaptain.init();

		if (isInitSuccess) {
			// 注册任务事件
			monitorClientCaptain.registerTask(new HeartbeatTask(monitorClientCaptain));
			// 在线人数监控
			monitorClientCaptain.registerTask(new MonitorTask_OnlineUser(monitorClientCaptain));
			LogProxy.OutPrintln("MonitorClientCaptain init success.");
		} else {
			LogProxy.ErrPrintln("MonitorClientCaptain init failed.");
		}

		return isInitSuccess;
	}

	/**
	 * 销毁
	 */
	public void destroy() {
		monitorClientCaptain.destroy();
	}
	/**
	 * 线程监控
	 * 
	 * @param threadKey
	 * @param normalFlag
	 */
	public void monitorThreadState(String threadKey, boolean normalFlag) {
		try {
			NormalServiceResult state = new NormalServiceResult();
			state.setType(TaskType.DUALITY_STATE);
			state.setKey(threadKey);
			state.setValue(normalFlag);
			monitorClientCaptain.getDocCaptain().addResult(threadKey, state);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
