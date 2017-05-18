package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfile;
import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfileStream;
import jedi.v7.bankserver.comm.ipop.client.OP_BankServ1001;

public class C3_OP_BankServ1001 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ1001";

	public static final String profile = "1";
	public static final String profileStream = "2";
	public static final String notice = "3";

	public C3_OP_BankServ1001(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ1001 data) throws Exception {
		super.parseFromSysData(data);
		C3_UserBankProfile userBankProfile = new C3_UserBankProfile();
		userBankProfile.parseFromSysData(data.getProfile());
		setProfile(userBankProfile);

		C3_UserBankProfileStream userBankProfileStream = new C3_UserBankProfileStream();
		userBankProfileStream.parseFromSysData(data.getProfileStream());
		setProfileStream(userBankProfileStream);
	}

	public C3_UserBankProfile getProfile() {
		try {
			C3_UserBankProfile data = getEntryObject(C3_OP_BankServ1001.profile);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setProfile(C3_UserBankProfile profile) {
		setEntry(C3_OP_BankServ1001.profile, profile);
	}

	public C3_UserBankProfileStream getProfileStream() {
		try {
			C3_UserBankProfileStream data = getEntryObject(C3_OP_BankServ1001.profileStream);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setProfileStream(C3_UserBankProfileStream profileStream) {
		setEntry(C3_OP_BankServ1001.profileStream, profileStream);
	}

	public String getNotice() {
		try {
			String data = getEntryString(C3_OP_BankServ1001.notice);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setNotice(String notice) {
		setEntry(C3_OP_BankServ1001.notice, notice);
	}

}