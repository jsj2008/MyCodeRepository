package jedi.ex01.CSTS3.proxy.debug;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

public class RunningTimeDebugTools {
	private static boolean isDebug = false;

	public static boolean isDebug() {
		return isDebug;
	}

	public static void setDebug(boolean isDebug) {
		RunningTimeDebugTools.isDebug = isDebug;
	}

	private static HashMap<String, RunningTimeDebugTools> rrtMap = new HashMap<String, RunningTimeDebugTools>();
	private static HashMap<String, Long> timeoutMap = new HashMap<String, Long>();
	private static _AutoPrintThread autoPrintThread = null;

	public final synchronized static RunningTimeDebugTools newInstance(String des) {
		return new RunningTimeDebugTools(des);
	}

	public final synchronized static RunningTimeDebugTools newRecordInstance(String ID, String des) {
		return newRecordInstance(ID, des, false, 0);
	}

	public final synchronized static RunningTimeDebugTools newRecordInstance(String ID, String des, boolean autoPrint,
			long timeout) {
		RunningTimeDebugTools rrt = new RunningTimeDebugTools(des);
		if (isDebug) {
			rrtMap.put(ID, rrt);
			if (autoPrint && timeout > 0) {
				timeoutMap.put(ID, timeout);
				if (autoPrintThread == null) {
					autoPrintThread = new _AutoPrintThread();
					autoPrintThread.start();
				}
			}
		}
		return rrt;
	}

	public final static RunningTimeDebugTools getRecord(String ID) {
		return rrtMap.get(ID);
	}

	public final synchronized static void destroy() {
		if (autoPrintThread != null) {
			autoPrintThread.destroy();
			autoPrintThread = null;
		}
		timeoutMap.clear();
		rrtMap.clear();
	}

	static synchronized void doAutoPrint() {
		String[] keys = timeoutMap.keySet().toArray(new String[0]);
		for (int i = 0; i < keys.length; i++) {
			String key = keys[i];
			long timeout = timeoutMap.get(key);
			RunningTimeDebugTools rrt = rrtMap.get(key);
			if (rrt == null) {
				timeoutMap.remove(key);
			}
			if (rrt.endTime > 0) {
				timeoutMap.remove(key);
				rrtMap.remove(key);
			}
			if (System.currentTimeMillis() - rrt.startedTime > timeout) {
				timeoutMap.remove(key);
				rrtMap.remove(key);
				rrt.print(true);
			}
		}
	}

	// -----------------------------------------------------------------------------
	// -----------------------------------------------------------------------------
	// -----------------------------------------------------------------------------
	// -----------------------------------------------------------------------------
	// -----------------------------------------------------------------------------
	private String des;
	private long startedTime;
	private long endTime = -1;

	private RunningTimeDebugTools(String des) {
		this.des = des;
		startedTime = System.currentTimeMillis();
	}

	private HashMap<Integer, String> stepNameMap = new HashMap<Integer, String>();
	private ArrayList<Long> timeList = new ArrayList<Long>();

	public void stepTo(String stepName) {
		stepNameMap.put(timeList.size(), stepName);
		timeList.add(System.currentTimeMillis());
	}

	public void end(String stepName) {
		stepTo(stepName);
		endTime = System.currentTimeMillis();
	}

	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss.SSS");

	public void print(boolean isAutoPrint) {
		System.out.println(format(isAutoPrint));
	}

	public void print() {
		System.out.println(format(false));
	}

	public String format() {
		return format(false);
	}

	public String format(boolean autoPrint) {
		StringBuffer sb = new StringBuffer();
		sb.append("------------------------------------");
		sb.append("\r\n");
		sb.append("[Process] ");
		sb.append(des);
		sb.append("\r\n");
		sb.append("[Started at]\t");
		sb.append(sdf.format(startedTime));
		sb.append("\r\n");
		if (autoPrint) {
			sb.append("[Auto Print at]\t");
			sb.append(sdf.format(System.currentTimeMillis()));
			sb.append("\r\n");
		} else if (endTime <= 0) {
			sb.append("[Not ended yet!]");
			sb.append("\r\n");
		} else {
			sb.append("[Ended at]\t");
			sb.append(sdf.format(endTime));
			sb.append("\r\n");
		}
		for (int i = 0; i < timeList.size(); i++) {
			long time = timeList.get(i);
			long preTime;
			if (i == 0) {
				preTime = startedTime;
			} else {
				preTime = timeList.get(i - 1);
			}
			sb.append(" ");
			sb.append(i);
			sb.append(": ");
			sb.append(time - preTime);
			sb.append(" , ");
			sb.append(stepNameMap.get(i));
			sb.append("\r\n");
		}
		sb.append("------------------------------------");
		return sb.toString();
	}

	public static void main(String args[]) throws InterruptedException {
		RunningTimeDebugTools rtt = RunningTimeDebugTools.newRecordInstance("a", "des", true, 10000);
		rtt.stepTo("test1");
		Thread.sleep(100);
		rtt.stepTo("test2");
		Thread.sleep(100);
		rtt.stepTo("test3");
		Thread.sleep(100);
		rtt.stepTo("test4");
		Thread.sleep(100);
		rtt.stepTo("test5");
		Thread.sleep(100);
		rtt.stepTo("test6");
		Thread.sleep(10000);
		rtt.stepTo("test7");
		Thread.sleep(10000);
		System.out.println(rtt.format());
	}
}

class _AutoPrintThread extends Thread {
	private boolean isDestroy = false;

	_AutoPrintThread() {

	}

	public void run() {
		while (!isDestroy) {
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (!isDestroy) {
				try {
					RunningTimeDebugTools.doAutoPrint();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	public void destroy() {
		isDestroy = true;
		this.interrupt();
	}
}
