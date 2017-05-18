package jedi.ex02.CSTS3.server.monitor.task;

import jedi.ex02.CSTS3.server.StaticContext;
import monitor.proxy.client.captain.MonitorClientCaptain;
import monitor.proxy.client.trade.task.PluralismStateTask;

/**
 * ��������������
 * 
 * @author Administrator
 * 
 */
public class MonitorTask_OnlineUser extends PluralismStateTask<Integer> {

	public MonitorTask_OnlineUser(MonitorClientCaptain captain) {
		super(10, "Front_ONLINE_USER_NUM_CSTSV3", captain);
	}

	@Override
	public Integer getState() {
		return StaticContext.getCSTSDoc().getOnlineUserNum();
	}
}
