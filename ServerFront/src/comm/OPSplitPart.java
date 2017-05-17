package comm;

import java.io.Serializable;

public class OPSplitPart implements Serializable {
	private static final long serialVersionUID = 5015264290992902934L;

	private String guid;
	private int index;
	private byte[] buf;
	private boolean endPart;

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public byte[] getBuf() {
		return buf;
	}

	public void setBuf(byte[] buf) {
		this.buf = buf;
	}

	public boolean isEndPart() {
		return endPart;
	}

	public void setEndPart(boolean endPart) {
		this.endPart = endPart;
	}

}
