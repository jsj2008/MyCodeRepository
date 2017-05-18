package jedi.ex01.client.station.api.bankserver;

import java.util.Map;

import jedi.v7.bankserver.comm.struct.IBankMetadata;

public class BCTradeResult_SignCheck extends BCTradeResult {

	private long streamID;
	private String[] bankIDList;
	private Map<String, IBankMetadata> bankInfoMap;

	public long getStreamID() {
		return streamID;
	}

	public void setStreamID(long streamID) {
		this.streamID = streamID;
	}

	public String[] getBankIDList() {
		return bankIDList;
	}

	public void setBankIDList(String[] bankIDList) {
		this.bankIDList = bankIDList;
	}

	public Map<String, IBankMetadata> getBankInfoMap() {
		return bankInfoMap;
	}

	public void setBankInfoMap(Map<String, IBankMetadata> bankInfoMap) {
		this.bankInfoMap = bankInfoMap;
	}

}
