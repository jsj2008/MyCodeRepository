package comm.fix;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.text.DecimalFormat;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

import allone.crypto.AES.AESCrypt;
import allone.crypto.AES.AESSecretKey;

public class FixDataUtil {

	public static int parseInt(byte buf[]) throws Exception {
		String str = new String(buf).trim();
		if (str.length() == 0) {
			return 0;
		}
		return Integer.parseInt(str);
	}

	public static double parseDouble(byte buf[]) throws Exception {
		String str = new String(buf).trim();
		return Double.parseDouble(str);
	}

	public static double parseLong(byte buf[]) throws Exception {
		String str = new String(buf).trim();
		return Long.parseLong(str);
	}

	public static byte[] formatString(String str, int length) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append(" ");
		}
		sb.replace(0, str.length(), str);
		return sb.substring(0, length).getBytes();
	}

	public static byte[] formatInt(int number, int length) {
		DecimalFormat format = new DecimalFormat();
		format.setMaximumIntegerDigits(length);
		format.setMinimumIntegerDigits(length);
		format.setGroupingUsed(false);
		return format.format(number).getBytes();
	}

	public static byte[] formatDouble(double number, int length) {
		DecimalFormat df = new DecimalFormat();
		df.setMaximumFractionDigits(length);
		df.setGroupingUsed(false);
		String str = df.format(number);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append(" ");
		}
		sb.replace(0, str.length(), str);
		return sb.substring(0, length).getBytes();
	}

	public static void main(String args[]) {
		System.out.println(new String(formatDouble(1.123, 10)));
		System.out.println(new String(formatString("XXX", 10)));
		System.out.println(new String(formatInt(5, 5)));
	}

	public static byte[] zip(byte buf[]) throws Exception {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		GZIPOutputStream zipos = new GZIPOutputStream(bos);
		zipos.write(buf);
		zipos.flush();
		zipos.close();
		return bos.toByteArray();
	}

	public static byte[] unzip(byte buf[]) throws Exception {
		ByteArrayInputStream bis = new ByteArrayInputStream(buf);
		GZIPInputStream zipis = new GZIPInputStream(bis);
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		byte tempbuf[] = new byte[1024];
		for (int size = 0; (size = zipis.read(tempbuf)) > 0;) {
			bos.write(tempbuf, 0, size);
			bos.flush();
		}
		zipis.close();
		return bos.toByteArray();
	}

	public static byte[] encrypt(byte[] tempbuf, AESSecretKey key) throws Exception {
		tempbuf = AESCrypt.encrypt(tempbuf, key.getKey());
		return tempbuf;
	}

	public static byte[] decrypt(byte[] buf, AESSecretKey key) throws Exception {
		buf = AESCrypt.decrypt(buf, key.getKey());
		return buf;
	}

}
