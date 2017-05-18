package allone.MTP.VerBank01.Ctrl.ca.check;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import allone.MTP.VerBank01.Ctrl.comm.structure.UserCertState;

public class ResultReader {
	
	private static final Pattern pattern = Pattern.compile("[^\\[\\]\\s]+");
	
	
	private static List<String> readInfo(String s) {
		
		Matcher m = pattern.matcher(s);
		ArrayList<String> tmp = new ArrayList<String>();
		while (m.find()) {
			tmp.add(m.group());
		}
		
		return tmp;
	}
	
	public static String[] getExpiredUsers(String result) {
		List<String> tmp = readInfo(result);
		if (checkOK(tmp)) {
			String[] users = new String[tmp.size() - 1];
			for (int i = 0; i < users.length; i++) {
				users[i] = tmp.get(i + 1);
			}
			return users;
		}
		
		return null;
	}
	
	public static UserCertState getUserCertState(String result) {
		List<String> tmp = readInfo(result);
		if (checkOK(tmp)) {
			return initUserCertState(tmp);
		}

		return null;
	}
	
	private static boolean checkOK(List<String> list) {
		return list.size() > 0 && "0".equals(list.get(0));
	}
	
	private static UserCertState initUserCertState(List<String> tmp) {
		tmp.remove(0);
		
		UserCertState ucs = new UserCertState();
		for (String s : tmp) {
			if (s.startsWith("ApplyID")) {
				String[] ss = s.split("=");
				ucs.setApplyId(ss[1]);
			} else if (s.startsWith("CertState")) {
				String[] ss = s.split("=");
				String desc = ss[1];
				int start = desc.indexOf('(');
				if (start == -1) {
					ucs.setCertState(Integer.parseInt(desc));
				} else {
					String cs = desc.substring(0, start);
					String csDesc = desc.substring(desc.indexOf('(') + 1, desc.indexOf(')'));
					ucs.setCertState(Integer.parseInt(cs));
					ucs.setCertStateDesc(csDesc);
				}
			} else if (s.startsWith("Serial")) {
				String[] ss = s.split("=");
				ucs.setSerial(ss[1]);
			} else if (s.startsWith("CommonName")) {
				String[] ss = s.split("=");
				ucs.setCommonName(ss[1]);
			} else if (s.startsWith("NotBefore")) {
				String[] ss = s.split("=");
				ucs.setNotBefore(ss[1]);
			} else if (s.startsWith("NotAfter")) {
				String[] ss = s.split("=");
				ucs.setNotAfter(ss[1]);
			}
		}
		
		return ucs;
	}
	
//	public static void main(String[] args) {
//		ResultReader rr = new ResultReader();
//		String result = "[0][ApplyID=24][CertState=31(憑證即將過期)][Serial=1300354229][CommonName=M235472419][NotBefore=20120528160536][NotAfter=20120611235959]";
//		UserCertState user = rr.getUserCertState(result);
//		System.out.println(user);
//	}
}
