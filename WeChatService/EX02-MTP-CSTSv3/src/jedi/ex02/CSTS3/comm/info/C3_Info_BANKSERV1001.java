package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfile;
import jedi.v7.bankserver.comm.infor.dealer.INFO_BankServ1001;
import jedi.v7.bankserver.comm.struct.UserBankProfile;
import jedi.v7.comm.datastruct.information.InforFather;

/***
 * 用户签解约通知
 * @author zhanglei
 * A // 并没有什么用， 通知dealer的
 */

public class C3_Info_BANKSERV1001 extends C3_InfoFather {
	public static final String jsonId = "Info_BANKSERV1004";

	public static final String userBankProfile = "1";

	public C3_Info_BANKSERV1001(InforFather info) {
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(INFO_BankServ1001 data) throws Exception {
		super.parseFromSysData(data);
		C3_UserBankProfile userBankProfile = new C3_UserBankProfile();
		UserBankProfile bankProfile = data.getProfile();
		userBankProfile.parseFromSysData(bankProfile);
		setUserBankProfile(userBankProfile);
	}

	public C3_UserBankProfile getUserBankProfile() {
		try {
			C3_UserBankProfile data = getEntryObject(C3_Info_BANKSERV1001.userBankProfile);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserBankProfile(C3_UserBankProfile userBankProfile) {
		setEntry(C3_Info_BANKSERV1001.userBankProfile, userBankProfile);
		
	}
}
