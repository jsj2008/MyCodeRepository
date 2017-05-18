package jedi.ex02.CSTS3.server.debug;

import java.util.HashMap;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

import allone.Log.simpleLog.log.LogProxy;

public class DebugLogCaptain {

	private static DebugLogCaptain instance = new DebugLogCaptain();
	private static final String ENTER = "\r\n";

	private HashMap<Long, ThreadLog> ThreadLog = new HashMap<Long, ThreadLog>();
	private Timer checkTimeout = new Timer();

	public DebugLogCaptain() {
		super();
		checkTimeout.schedule(new CheckTimeout(), 1000, 5000);
	}

	public static DebugLogCaptain getInstance() {
		return instance;
	}

	public void log(String ipAddress, String log) {
//		if (StaticContext.getCSConfigCaptain().checkDebugLogIP(ipAddress)) {
//			Thread thread = Thread.currentThread();
//			long id = thread.getId();
//			StackTraceElement el = thread.getStackTrace()[2];
//			ThreadLog threadLog = ThreadLog.get(id);
//			if(threadLog==null){
//				threadLog = new ThreadLog();
//				ThreadLog.put(id, threadLog);
//			}
//			threadLog.getLog().append(el.toString() + "\t"+ipAddress+"\t out: " + log + ENTER);
//			threadLog.setLastLogTime(System.currentTimeMillis());
//		}
	}

	public void printLog() {
		Thread thread = Thread.currentThread();
		long id = thread.getId();
		ThreadLog threadLog = ThreadLog.get(id);
		if (threadLog == null) {
			return;
		}
		if (threadLog.getLog().length() > 0) {
			LogProxy.OutPrintln(threadLog.getLog().toString());
		}
		ThreadLog.remove(id);
	}

	class CheckTimeout extends TimerTask {

		@Override
		public void run() {
			Set<Long> idv = ThreadLog.keySet();
			for (Long id : idv) {
				ThreadLog log = ThreadLog.get(id);
				if (System.currentTimeMillis() - log.getLastLogTime() > 60 * 1000) {
					LogProxy.OutPrintln(log.getLog().toString());
					ThreadLog.remove(id);
				}
			}
		}

	}

}
