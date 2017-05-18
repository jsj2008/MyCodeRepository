package allone.MTP.VerBank01.Ctrl.ca.url;

import org.apache.commons.codec.binary.Base64;

public class Base64Util {

	private Base64Util() {
		super();
	}

	public static String encode(byte[] data) {
		String svalue = null;

		if (data != null && data.length > 0) {
			Base64 b = new Base64();
			byte[] dst = b.encode(data);
			svalue = new String(dst);
		}

		return svalue;
	}

	public static byte[] decode(String data) {
		byte[] d_data = null;

		if (data != null && !data.trim().isEmpty()) {
			Base64 b = new Base64();
			d_data = b.decode(data.getBytes());
		}

		return d_data;
	}

}
