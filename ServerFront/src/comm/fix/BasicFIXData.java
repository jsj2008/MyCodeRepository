package comm.fix;

import server.define.DataTypeDefine;
import allone.crypto.AES.AESSecretKey;

public abstract class BasicFIXData {

	protected int dataType;
	protected int isZip;
	protected int isEncrypt;
	protected AESSecretKey key;
	protected byte[] dataBuffer;
	protected String description;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getDataType() {
		return dataType;
	}

	public void setDataType(int dataType) {
		this.dataType = dataType;
	}

	public byte[] getDataBuffer() {
		return dataBuffer;
	}

	public void setDataBuffer(byte[] dataBuffer) {
		this.dataBuffer = dataBuffer;
	}

	public abstract void parse() throws Exception;

	public abstract byte[] format() throws Exception;

	public int getIsZip() {
		return isZip;
	}

	public void setIsZip(int isZip) {
		this.isZip = isZip;
	}

	public int getIsEncrypt() {
		return isEncrypt;
	}

	public void setIsEncrypt(int isEncrypt) {
		this.isEncrypt = isEncrypt;
	}

	public AESSecretKey getKey() {
		return key;
	}

	public void setKey(AESSecretKey key) {
		this.key = key;
	}

	public BasicFIXData(int dataType) {
		super();
		this.dataType = dataType;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("Data Length=");
		sb.append(dataBuffer.length);
		sb.append(" ; ");
		sb.append("zip=");
		sb.append(isZip == DataTypeDefine.TRUE);
		sb.append(" ; ");
		sb.append("Encrypt=");
		sb.append(isEncrypt == DataTypeDefine.TRUE);
		sb.append(" ; ");
		sb.append("Description=");
		sb.append(description);
		return sb.toString();
	}
}
