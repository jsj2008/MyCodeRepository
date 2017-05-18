package jedi.ex02.CSTS3.server.util;

import java.util.HashMap;

import allone.Log.simpleLog.log.LogProxy;

public class DebugUtils extends Thread {

	private final static DebugUtils instance = new DebugUtils();

	public static DebugUtils getInstance_test() {
		return instance;
	}

	public static boolean debug;

	private boolean destroy;

	private HashMap<String,DebugNode> local = new HashMap<String,DebugNode>();

	public void destroy() {
		destroy = true;
	}

	public void run() {
		destroy = false;
		while (!destroy) {
			Thread[] threads=findAllThreads();
			for (Thread thread : threads) {
				DebugNode node = local.get(thread.getName());
				if(node!=null) {
					if(System.currentTimeMillis()-node.startedTime>60*1000) {
						LogProxy.ErrPrintln("DebugUtils time out:\r\n"+node.format());
						local.remove(thread.getName());
					}
				}
			}
			try {
				sleep(2*1000);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public String step(String stepName,String name) {
		DebugNode node = local.get(Thread.currentThread().getName());
		if (node == null) {
			node = new DebugNode(name);
			local.put(Thread.currentThread().getName(),node);
		}
		node.stepTo(stepName);
		return node.format();
	}

	public String step(String stepName) {
		DebugNode node = local.get(Thread.currentThread().getName());
		if (node != null) {
			node.stepTo(stepName);
			return node.format();
		}else {
			return null;
		}
	}

	public String end(String stepName) {
		DebugNode node = local.get(Thread.currentThread().getName());
		if (node != null) {
			local.remove(Thread.currentThread().getName());
			node.end(stepName);
			return node.format();
		} else {
			return null;
		}
	}

	public static Thread[] findAllThreads() {
		ThreadGroup group = Thread.currentThread().getThreadGroup();
		ThreadGroup topGroup = group;

		// 遍历线程组树，获取根线程组
		while (group != null) {
			topGroup = group;
			group = group.getParent();
		}
		// 激活的线程数加倍
		int estimatedSize = topGroup.activeCount() * 2;
		Thread[] slackList = new Thread[estimatedSize];
		// 获取根线程组的所有线程
		int actualSize = topGroup.enumerate(slackList);
		// copy into a list that is the exact size
		Thread[] list = new Thread[actualSize];
		System.arraycopy(slackList, 0, list, 0, actualSize);
		return list;
	}

}
