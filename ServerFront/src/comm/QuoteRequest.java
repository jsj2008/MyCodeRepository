package comm;

import java.io.Serializable;

public class QuoteRequest implements Serializable {
	private static final long serialVersionUID = -9044538308453434301L;

	private String[] instruments = new String[0];

	public String[] getInstruments() {
		return instruments;
	}

	public void setInstruments(String[] instruments) {
		this.instruments = instruments;
	}
}
