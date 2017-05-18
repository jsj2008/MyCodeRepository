package allone.MTP.VerBank01.Ctrl.ca.url;

import java.security.MessageDigest;

public class MessageDigestUtil {

	private static final String SHA_1_ALGORITHM = "SHA-1";
	
	public static byte[] digest(String src) {
		if (src == null) {
			return null;
		}
		
		try {
			MessageDigest digest = MessageDigest.getInstance(SHA_1_ALGORITHM);
			byte[] dst = digest.digest(src.getBytes());
			return dst;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/*public static void main(String[] args) {
		String idNo = "P205752246";
		String birthDay = "1980/01/05";
		String lt = "20120524152403";
		
		String idNo = "A123456789";
		String birthDay = "2000/01/01";
		String lt = "20120524153616";
		
		StringBuilder sb = new StringBuilder();
		sb.append(idNo).append(birthDay).append(lt).append("TWCA");
		System.out.println(sb);
		byte[] dst = MessageDigestUtil.digest(sb.toString());
		String sc = Base64Util.encode(dst);
		
		try {
			System.out.println(sc);
			System.out.println(URLEncoder.encode(sc, "UTF-8"));
			System.out.println("fsIGU8ULmqgAWS8NQe1YzgBbF%2Bg%3D");
		} catch (Exception e) {
			
		}
	}*/
}
