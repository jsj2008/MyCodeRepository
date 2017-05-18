package jedi.ex01.client.station.api.bankserver;

import java.util.Map;

import jedi.ex01.CSTS3.comm.struct.UserBankProfile;
import jedi.ex01.CSTS3.comm.struct.UserBankProfileStream;

public class BCTradeResult_UserBankProfile extends BCTradeResult {

	private UserBankProfile profile;
	private UserBankProfileStream stream;
	private String notice;
	private Map<String, String> otherInfoMap;

	public UserBankProfile getProfile() {
		return profile;
	}

	public void setProfile(UserBankProfile profile) {
		this.profile = profile;
	}

	public UserBankProfileStream getStream() {
		return stream;
	}

	public void setStream(UserBankProfileStream stream) {
		this.stream = stream;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public Map<String, String> getOtherInfoMap() {
		return otherInfoMap;
	}

	public void setOtherInfoMap(Map<String, String> otherInfoMap) {
		this.otherInfoMap = otherInfoMap;
	}

}
