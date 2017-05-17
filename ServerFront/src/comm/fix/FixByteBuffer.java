package comm.fix;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

public class FixByteBuffer {

	public final static int PARTLENGTH = 6;

	private ByteArrayOutputStream baos = null;
	private ByteArrayInputStream bais = null;

	private FixByteBuffer() {
		baos = new ByteArrayOutputStream();
	}

	private FixByteBuffer(byte buffer[]) {
		bais = new ByteArrayInputStream(buffer);
	}

	public static FixByteBuffer getWriteInstance() {
		return new FixByteBuffer();
	}

	public static FixByteBuffer getReadInstance(byte buf[]) {
		return new FixByteBuffer(buf);
	}

	public String readString(int length) throws Exception {
		byte buffer[] = readBuffer(length);
		return new String(buffer).trim();
	}

	public double readDouble(int length) throws Exception {
		return Double.parseDouble(readString(length));
	}

	public int readInt(int length) throws Exception {
		return Integer.parseInt(readString(length));
	}

	public long readLong(int length) throws Exception {
		return Long.parseLong(readString(length));
	}

	public String readNextPackedString() throws Exception {
		int length = readInt(PARTLENGTH);
		return this.readString(length);
	}

	public byte[] readBuffer(int length) throws Exception {
		byte buffer[] = new byte[length];
		if (length == 0) {
			return buffer;
		}
		int size = bais.read(buffer);
		if (size < 0) {
			throw new Exception("Read from buffer failed!Return size is " + size);
		}
		return buffer;
	}

	public void writePackedString(String str) throws Exception {
		byte buf[] = str.trim().getBytes();
		this.writeInt(buf.length, PARTLENGTH);
		this.writeBuffer(buf);
	}

	public void writeString(String str, int length) throws Exception {
		baos.write(FixDataUtil.formatString(str, length));
	}

	public void writeDouble(double data, int length) throws Exception {
		baos.write(FixDataUtil.formatDouble(data, length));
	}

	public void writeInt(int data, int length) throws Exception {
		baos.write(FixDataUtil.formatInt(data, length));
	}

	public void writeBuffer(byte buf[]) throws Exception {
		baos.write(buf);
	}

	public byte[] getBuffer() {
		return baos.toByteArray();
	}

	public byte[] getBufferWithLength() {
		byte newbuf[] = new byte[FixDateDefine.LENGTHHEADLEN + baos.size()];
		byte headBuf[] = FixDataUtil.formatInt(newbuf.length, FixDateDefine.LENGTHHEADLEN);
		System.arraycopy(headBuf, 0, newbuf, 0, FixDateDefine.LENGTHHEADLEN);
		byte dataBuf[] = getBuffer();
		System.arraycopy(dataBuf, 0, newbuf, FixDateDefine.LENGTHHEADLEN, dataBuf.length);
		return newbuf;
	}

	public static void main(String args[]) throws Exception {
		FixByteBuffer buffer = new FixByteBuffer();
		buffer.writeInt(1, 10);
		buffer.writeDouble(1.23456, 10);
		buffer.writeString("Hellow", 10);
		byte buf[] = buffer.getBufferWithLength();
		System.out.println(buf.length);
		System.out.println(new String(buf, 0, 10));
		System.out.println(new String(buf, 10, 10));
		System.out.println(new String(buf, 20, 10));
		System.out.println(new String(buf, 30, 10));
	}

}
