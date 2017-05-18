package jedi.ex01.client.station.api.bankserver;

import java.util.Map;

public final class CommMetaData implements IBankMetadata {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1410049166573504388L;
	private String bankID;
	private boolean dwneed;
	private Map<String, String> bankCodeMap;
	private Map<String, String> otherInfoMap;
	private String notice;
	private String signNotice;
	private boolean _fromGW;
	private boolean _anotherStreamID;

	public CommMetaData(String bankID) {
		this.bankID = bankID;
	}

	@Override
	public String getBankID() {
		return bankID;
	}

	public boolean isDwneed() {
		return dwneed;
	}

	public void setDwneed(boolean dwneed) {
		this.dwneed = dwneed;
	}

	public Map<String, String> getBankCodeMap() {
		return bankCodeMap;
	}

	public void setBankCodeMap(Map<String, String> bankCodeMap) {
		this.bankCodeMap = bankCodeMap;
	}

	public Map<String, String> getOtherInfoMap() {
		return otherInfoMap;
	}

	public void setOtherInfoMap(Map<String, String> otherInfoMap) {
		this.otherInfoMap = otherInfoMap;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public boolean is_fromGW() {
		return _fromGW;
	}

	public void set_fromGW(boolean _fromgw) {
		_fromGW = _fromgw;
	}

	public boolean is_anotherStreamID() {
		return _anotherStreamID;
	}

	public void set_anotherStreamID(boolean streamID) {
		_anotherStreamID = streamID;
	}

	public String getSignNotice() {
		return signNotice;
	}

	public void setSignNotice(String signNotice) {
		this.signNotice = signNotice;
	}

}
