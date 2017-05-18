package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfile;
import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfileStream;
import jedi.v7.bankserver.comm.ipop.client.OP_BankServ1003;

public class C3_OP_BankServ1003 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ1003";

	public static final String profile = "1";
	public static final String profileStream = "2";

	public C3_OP_BankServ1003(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ1003 data) throws Exception {
		super.parseFromSysData(data);
		C3_UserBankProfile userBankProfile = new C3_UserBankProfile();
		userBankProfile.parseFromSysData(data.getProfile());
		setProfile(userBankProfile);

		C3_UserBankProfileStream userBankProfileStream = new C3_UserBankProfileStream();
		userBankProfileStream.parseFromSysData(data.getStream());
		setProfileStream(userBankProfileStream);
	}

	public C3_UserBankProfile getProfile() {
		try {
			C3_UserBankProfile data = getEntryObject(C3_OP_BankServ1003.profile);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setProfile(C3_UserBankProfile profile) {
		setEntry(C3_OP_BankServ1003.profile, profile);
	}

	public C3_UserBankProfileStream getProfileStream() {
		try {
			C3_UserBankProfileStream data = getEntryObject(C3_OP_BankServ1003.profileStream);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setProfileStream(C3_UserBankProfileStream profileStream) {
		setEntry(C3_OP_BankServ1003.profileStream, profileStream);
	}


}