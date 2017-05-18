package allone.MTP.VerBank01.Ctrl.comm.util;

import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Comparator;

import allone.MTP.VerBank01.comm.datastruct.CommDataInterface;
import allone.MTP.VerBank01.comm.datastruct.DB.OtherClientConfig;

public class CtrlDigistTool {
	public static char SPERATOR = (char) 01;

	public static boolean isMatch(byte[] digist1, byte[] digist2) {
		if (digist1 == null || digist2 == null) {
			return false;
		}
		if (digist1.length != digist2.length) {
			return false;
		}
		for (int i = 0; i < digist1.length; i++) {
			if (digist1[i] != digist2[i]) {
				return false;
			}
		}
		return true;
	}

	public static byte[] digist(OtherClientConfig[] OtherClientConfigVec) {
		try {
			if (OtherClientConfigVec == null) {
				return new byte[0];
			}
			Arrays.sort(OtherClientConfigVec,
					new Comparator<OtherClientConfig>() {
						public int compare(OtherClientConfig t1,
								OtherClientConfig t2) {
							return t1.getKey().compareTo(t2.getKey());
						}
					});
			
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < OtherClientConfigVec.length; i++) {
				OtherClientConfig cc = OtherClientConfigVec[i];
				sb.append(cc.getKey());
				sb.append("=");
				sb.append(cc.getType());
				sb.append(",");
				if (cc.getType() == CommDataInterface.OTHER_CLIENT_CONFIG_TYPE_LINK) {
					sb.append(cc.getLink());
				} else if (cc.getType() == CommDataInterface.OTHER_CLIENT_CONFIG_TYPE_VALUE) {
					sb.append(cc.getValue());
				} else if (cc.getType() == CommDataInterface.OTHER_CLIENT_CONFIG_TYPE_CONTENT) {
					sb.append(cc.getContent().length);
				} else {
					sb.append(cc.getValue());
				}
				sb.append(";");
			}
			return getDigestBuf(sb.toString().trim().getBytes());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private static byte[] getDigestBuf(byte[] buf) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return md.digest(buf);
	}

}
