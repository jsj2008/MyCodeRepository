package allone.MTP.VerBank01.Ctrl.util;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;

public class ControlUtil {

	public static CheckResult checkVersion(String version) {
		CheckResult result = new CheckResult();
		try {
			if (!StaticContext.getConfigCaptain().isCheckVersion()) {
				return result.caculate(true);
			}
			if (version == null) {
				return result.caculate(false, "Need check version, client version is null !");
			}
			String[] strs = version.split("\\.");
			if (strs.length < 2) {
				return result.caculate(false, "Need check version, client version " + version + " format error !");
			}

			if (strs[0].equalsIgnoreCase("AA") || strs[0].equalsIgnoreCase("AI")) {
				return checkAndroidAndIOSAppVersion(version, result, strs);
			} else {
				return checkClientVersion(version, result, strs);
			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
			return result.caculate(false, e.getMessage());
		}
	}

	private static CheckResult checkClientVersion(String version, CheckResult result, String[] strs) {
		String sysVer = StaticContext.getConfigCaptain().getVersion(strs[0]);
		if (sysVer == null) {
			return result.caculate(false, "Need check version, client version " + version + " not found in server !");
		}

		String[] sysStrs = sysVer.split("\\.");
		int mVer = Integer.parseInt(strs[1]);
		int msVer = Integer.parseInt(sysStrs[1]);
		if (mVer < msVer) {
			return result.caculate(false, "Need min version " + sysVer + ", client version " + version + " is lower !");
		}
		int sVec = strs.length >= 3 ? Integer.parseInt(strs[2]) : 0;
		int ssVer = sysStrs.length >= 3 ? Integer.parseInt(sysStrs[2]) : 0;
		if (sVec < ssVer) {
			return result.caculate(false, "Need min version " + sysVer + ", client version " + version + " is lower !");
		}
		return result.caculate(true);
	}

	private static CheckResult checkAndroidAndIOSAppVersion(String version, CheckResult result, String[] strs) {
		String sysMinVer = StaticContext.getConfigCaptain().getPhoneMinVersion(strs[0]);
		if (sysMinVer == null) {
			return result.caculate(false, "Need check version, app version " + version + " not found in server !");
		}
		String[] sysMinStrs = sysMinVer.split("\\.");
		int mVer = Integer.parseInt(strs[1]);
		int msVer = Integer.parseInt(sysMinStrs[1]);
		if (mVer < msVer) {
			return result.caculate(false, "Need min version " + sysMinVer + ", app version " + version + " is lower !");
		}
		int sVec = strs.length >= 3 ? Integer.parseInt(strs[2]) : 0;
		int ssVer = sysMinStrs.length >= 3 ? Integer.parseInt(sysMinStrs[2]) : 0;
		if (sVec < ssVer) {
			return result.caculate(false, "Need min version " + sysMinVer + ", app version " + version + " is lower !");
		}
		String sysMaxVer = StaticContext.getConfigCaptain().getPhoneMaxVersion(strs[0]);
		if (sysMaxVer == null || sysMaxVer.equals("")) {
			return result.caculate(true);
		}
		String[] sysMaxStrs = sysMaxVer.split("\\.");
		int maxVer = Integer.parseInt(strs[1]);
		int msMaxVer = Integer.parseInt(sysMaxStrs[1]);
		if (maxVer < msMaxVer) {
			return result.caculate(false, "Need min version " + sysMaxVer + ", app version " + version + " is lower !");
		}
		int sMaxVec = strs.length >= 3 ? Integer.parseInt(strs[2]) : 0;
		int ssMaxVer = sysMaxStrs.length >= 3 ? Integer.parseInt(sysMaxStrs[2]) : 0;
		if (sMaxVec > ssMaxVer) {
			return result.caculate(false, "Need max version " + sysMaxVer + ", app version " + version + " is high !");
		}
		return result.caculate(true);

	}
}
