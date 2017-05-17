package comm.fix;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;

public class FixStyledData {
	private static final char SEPERATOR = (char) 01;
	private static final String MIDSEPERATOR = "=";
	private HashMap<Integer, String> map = new HashMap<Integer, String>();
	private String formatedData;

	public void addData(int index, String data) {
		map.put(index, data);
	}

	public void addData(int index, double data, int frictionNum) {
		DecimalFormat df = new DecimalFormat();
		df.setMaximumFractionDigits(frictionNum);
		df.setGroupingUsed(false);
		addData(index, df.format(data));
	}

	public void format() throws Exception {
		StringBuffer sb = new StringBuffer();
		Iterator<Integer> it = map.keySet().iterator();
		while (it.hasNext()) {
			Object key = it.next();
			Object value = map.get(key);
			sb.append(key.toString());
			sb.append(MIDSEPERATOR);
			sb.append(value);
			sb.append(SEPERATOR);
		}
		formatedData = sb.toString();
	}

	public void parse(String data) {
		String ss[] = data.split(String.valueOf(SEPERATOR));
		map = new HashMap<Integer, String>();
		for (int i = 0; i < ss.length; i++) {
			String temps = ss[i];
			int index = temps.indexOf(MIDSEPERATOR);
			if (index <= 0) {
				continue;
			}
			String key = temps.substring(0, index);
			String value = temps.substring(index + 1);
			map.put(Integer.valueOf(key.trim()), value);
		}
	}

	public String getAt(int index) {
		Integer key = Integer.valueOf(index);
		if (map.containsKey(key)) {
			Object value = map.get(key);
			if (value == null) {
				// System.out.println("Null value: key=" + index);
				return null;
			}
			return map.get(key).toString();
		} else {
			// System.out.println("No such key: key=" + index);
			return null;
		}
	}

	public String getFormatedData() {
		return formatedData;
	}

}
