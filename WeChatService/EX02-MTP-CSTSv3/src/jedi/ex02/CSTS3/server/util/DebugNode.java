package jedi.ex02.CSTS3.server.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

public class DebugNode {

	private String des;
	public long startedTime;
	public long endTime = -1;

	DebugNode(String des) {
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

}
