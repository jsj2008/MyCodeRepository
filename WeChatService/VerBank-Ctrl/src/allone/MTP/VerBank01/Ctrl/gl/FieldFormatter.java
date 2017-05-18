package allone.MTP.VerBank01.Ctrl.gl;


public class FieldFormatter {

	/**
	 * 返回double的字符串格式化形式，前补0，带小数点
	 * @param num
	 * @param len 总长度
	 * @param accuracy
	 * @return
	 */
	public static String formatDoubleWithPoint(double num, int len, int accuracy) {
		StringBuilder sb = new StringBuilder();
		sb.append("%0").append(len).append('.').append(accuracy).append("f");
//		System.out.println(sb);
		return String.format(sb.toString(), num);
	}
	
	public static String formatDouble(double num, int len, int accuracy) {
		int nLen = len;
		if (accuracy > 0) {
			nLen++;
		}
		return formatDoubleWithPoint(num, nLen, accuracy).replaceAll("\\.", "");
	}
	
//	public static void main(String[] args) {
//		double d = 1234.342;
//		System.out.println(formatDouble(d, 15, 0));
//		System.out.println(formatMoney(d));
//		
//		String space = appendSpace("MTPCnRev", 13);
//		System.out.println(space);
//		System.out.println(space.length());
//		System.out.println(preposeZero("1234", 10));
//	}
	
	/**
	 * 返回金额的字符串表现形式，前补0，不带小数点
	 * @param money
	 * @return
	 */
	public static String formatMoney(double money) {
		return formatDouble(money, 15, 2);
	}
	
	/**
	 * 字符串后添加空格
	 * @param src
	 * @param len
	 * @return
	 */
	public static String appendSpace(String src, int len) {
		StringBuilder sb = new StringBuilder();
		sb.append("%-").append(len).append('s');
		if (src == null || src.isEmpty()) {
			src = "";
		}
		
		return String.format(sb.toString(), src);
	}
	
	/**
	 * 前置添加零
	 * @param src
	 * @param len
	 * @return
	 */
	public static String preposeZero(String src, int len) {
		if (src == null || src.isEmpty()) {
			src = "";
		}
		
		if (src.length() >= len) {
			return src;
		}
		
		StringBuilder sb = new StringBuilder();
		int num = len - src.length();
		for (int i = 0; i < num; i++) {
			sb.append('0');
		}
		sb.append(src);
		return sb.toString();
	}
}
