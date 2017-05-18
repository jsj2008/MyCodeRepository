package allone.MTP.VerBank01.Ctrl.ca.check;

public class TestMain {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		for (CertState cs : CertState.values()) {
//			System.out.println("CertState: " + cs + ", Code: " + cs.getCode() + ", Desc: " + cs.getDesc());
//		}
		
		
		String dn = "Admin";
		String roleName = "Admin";
		int idx = dn.indexOf("role_");
		if (idx != -1) {
			roleName = dn.substring(idx + 5);
		}

		System.out.println(roleName);
	}

}
