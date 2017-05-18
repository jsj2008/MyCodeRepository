package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.UserBankProfile;
import jedi.ex01.CSTS3.comm.struct.UserBankProfileStream;
import jedi.ex01.client.station.api.bankserver.BankServClientOPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;
import jedi.ex01.client.station.api.bankserver.BankServOPFather;

public class OP_BankServ1001 extends BankServOPFather {
	public static final String jsonId = "OP_BankServ1001";

	public static final String profile = "1";
	public static final String profileStream = "2";
	public static final String notice = "3";

	// BankServIPFather ip
	public OP_BankServ1001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public UserBankProfile getProfile() {
		try {
			UserBankProfile data = getEntryObject(OP_BankServ1001.profile);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setProfile(UserBankProfile profile) {
		setEntry(OP_BankServ1001.profile, profile);
	}

	public UserBankProfileStream getProfileStream() {
		try {
			UserBankProfileStream data = getEntryObject(OP_BankServ1001.profileStream);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setProfileStream(UserBankProfileStream profileStream) {
		setEntry(OP_BankServ1001.profileStream, profileStream);
	}

	public String getNotice() {
		try {
			String data = getEntryString(OP_BankServ1001.notice);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setNotice(String notice) {
		setEntry(OP_BankServ1001.notice, notice);
	}

}