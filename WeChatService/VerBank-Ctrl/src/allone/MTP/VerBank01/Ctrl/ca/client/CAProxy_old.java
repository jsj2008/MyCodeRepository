package allone.MTP.VerBank01.Ctrl.ca.client;

import allone.MTP.VerBank01.Ctrl.ca.CAErrCodeDesc;
import allone.MTP.VerBank01.Ctrl.ca.CASignException;

import com.formosoft.applet.FEIBCAPILet;

public class CAProxy_old {
	private final static String SUBJECT_TEST = "C=TW\nO=Finance\nOU=TaiCA Test FXML CA\nOU=8050000-RA-FEIBTEST\nOU=FXML";
	private final static String SUBJECT_REAL = "C=TW\nO=Finance\nOU=TWCA Financial User CA\nOU=8050000-FEIBRA\nOU=FXML";

	private static boolean checkString(String s) {
		if (s == null || s.isEmpty()) {
			return false;
		} else {
			return true;
		}
	}

	public static String autoSign(String filePath, String aeid, String password, String data, boolean isReal)
			throws CASignException {
		int flags = FEIBCAPILet.FSCAPI_FLAG_SELCERT_AUTO;
		return sign(filePath, aeid, password, data, flags, isReal);
	}

	public static String manulSign(String filePath, String aeid, String password, String data, boolean isReal)
			throws CASignException {
		int flags = FEIBCAPILet.FSCAPI_FLAG_SELCERT_MANUAL;
		return sign(filePath, aeid, password, data, flags, isReal);
	}

	private static String sign(String filePath, String aeid, String password, String data, int flags, boolean isReal)
			throws CASignException {
		if (!checkString(filePath)) {
			throw new CASignException("[5902] 找不到指定檔案");
		}

		FEIBCAPILet api = new FEIBCAPILet();
		api.init();

		int keyUsage = FEIBCAPILet.FS_KU_DIGITAL_SIGNATURE | FEIBCAPILet.FS_KU_NON_REPUDIATION;

		// String signature = api.FSCAPI_PFXSign(filePath, password, data,
		// flags,
		// keyUsage);
		String signature = null;
		if (isReal) {
			signature = api.FEIBFSCAPI_PFXSign(filePath, password, SUBJECT_REAL + "\nCN=" + aeid, data, flags, 0x00000011,
					keyUsage);
		} else {
			signature = api.FEIBFSCAPI_PFXSign(filePath, password, SUBJECT_TEST + "\nCN=" + aeid, data, flags, 0x00000011,
					keyUsage);
		}

		int errCode = api.GetErrorCode();
		if (CAErrCodeDesc.isSuccess(errCode)) {
			return signature;
		}

		String reason = CAErrCodeDesc.GetErrorMessage(errCode);
		throw new CASignException(errCode, reason);
	}

	public static void main(String[] args) throws Exception {
		String filePath = "E:\\temp\\N210658745_x.pfx";
		String data = "1234";
		// String s = CAProxy.manulSign(filePath, null, data);

		FEIBCAPILet api = new FEIBCAPILet();
		api.init();

		int keyUsage = FEIBCAPILet.FS_KU_DIGITAL_SIGNATURE | FEIBCAPILet.FS_KU_NON_REPUDIATION;

		String signature = api.FSCAPI_PFXSign(filePath, null, data, FEIBCAPILet.FSCAPI_FLAG_SELCERT_AUTO, keyUsage);
		System.out.println(signature);

		// String ss = api.FSCAPI_ReadFile(filePath + 1 + 12, 4);
		// System.out.println(ss);
		// System.out.println(api.GetErrorCode());

		String s = api.CertGetNotAfter(filePath, 0);
		System.out.println(s);
		System.out.println(api.GetErrorCode());
	}
}
