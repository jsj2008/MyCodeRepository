package jedi.ex01.client.station.api.bankserver;

import java.util.Map;

public class BCTradeResult_DWCheck extends BCTradeResult {

	private long streamId;
	private Map<String, IBankMetadata> bankInfoMap;

	public long getStreamId() {
		return streamId;
	}

	public void setStreamId(long streamId) {
		this.streamId = streamId;
	}

	public Map<String, IBankMetadata> getBankInfoMap() {
		return bankInfoMap;
	}

	public void setBankInfoMap(Map<String, IBankMetadata> bankInfoMap) {
		this.bankInfoMap = bankInfoMap;
	}

}
