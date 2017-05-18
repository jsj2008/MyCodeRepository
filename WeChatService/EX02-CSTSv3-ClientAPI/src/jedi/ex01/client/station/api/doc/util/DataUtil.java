package jedi.ex01.client.station.api.doc.util;

public class DataUtil {
	// 四舍五入，将double精确到指定小数位
	public static double roundDouble(double v, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException(
					"The scale must be a positive integer or zero");
		}
		double n = Math.pow(10, scale);
		double absV = Math.abs(v);
		if (absV < 1 / (n * 10)) {
			return 0;
		}
		double mark = v / Math.abs(v);
		double tempV = absV * n + 0.000001; // 考虑double精确的问题，认为0.9999999==1
		return mark * ((double) ((long) (tempV + 0.5))) / n;
	}

}
