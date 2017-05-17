package comm.fix;

import java.io.EOFException;
import java.io.InputStream;
import java.io.OutputStream;

import allone.crypto.AES.AESSecretKey;

import comm.fix.data.ObjectData4FIX;

public class FixIoUtil {

	public static void writeData(byte buffer[], OutputStream os) throws Exception {
		byte lengthBuff[] = FixDataUtil.formatInt(buffer.length + FixDateDefine.LENGTHHEADLEN, FixDateDefine.LENGTHHEADLEN);
		os.write(lengthBuff);
		os.write(buffer);
		os.flush();
	}

	public static void writeEcho(OutputStream os) throws Exception {
		byte echo[] = FixDataUtil.formatInt(FixDateDefine.LENGTHHEADLEN, FixDateDefine.LENGTHHEADLEN);
		os.write(echo);
		os.flush();
	}

	public static BasicFIXData readData(InputStream is, AESSecretKey key) throws Exception {
		byte lengthBuf[] = readBuffer(is, FixDateDefine.LENGTHHEADLEN);
		int length = FixDataUtil.parseInt(lengthBuf);
		if (length == 0 || length == FixDateDefine.LENGTHHEADLEN) {
			return null;
		}

		byte datatypeBuf[] = readBuffer(is, 2);
		int datatype = FixDataUtil.parseInt(datatypeBuf);
		byte isZipBuf[] = readBuffer(is, 1);
		int isZip = FixDataUtil.parseInt(isZipBuf);
		byte isEncryptBuf[] = readBuffer(is, 1);
		int isEncrypt = FixDataUtil.parseInt(isEncryptBuf);
		int leftSize = length - FixDateDefine.LENGTHHEADLEN - 4;
		byte leftBuf[] = readBuffer(is, leftSize);

		BasicFIXData bd = null;
		switch (datatype) {
		case FixDateDefine.DATATYPE_ECHO:
			return null;
		case FixDateDefine.DATATYPE_OBJECT:
			bd = new ObjectData4FIX();
			break;
		// case FixDateDefine.DATATYPE_QUOTE:
		// bd = new QuoteData4FIX();
		// break;
		default:
			throw new Exception("Unknow data type for " + datatype);
		}

		bd.setDataBuffer(leftBuf);
		bd.setDataType(datatype);
		bd.setIsZip(isZip);
		bd.setIsEncrypt(isEncrypt);
		bd.setKey(key);
		bd.parse();
		bd.setDescription("Net Length=" + length);
		return bd;
	}

	public static byte[] readBuffer(InputStream is, int length) throws Exception {
		byte buf[] = new byte[length];
		for (int i = 0; i < length; i++) {
			int v = is.read();
			if (v < 0) {
				throw new EOFException();
			}
			buf[i] = (byte) v;
		}
		return buf;
	}
}
