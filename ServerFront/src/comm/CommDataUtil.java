package comm;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class CommDataUtil {

	public static byte[] objectToByte(Object obj) throws Exception {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(bos));
		oos.writeObject(obj);
		oos.flush();
		byte buf[] = bos.toByteArray();
		return buf;
	}

	public static Object byteToObject(byte[] buf) throws Exception {
		ByteArrayInputStream bis = new ByteArrayInputStream(buf);
		ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(bis));
		return ois.readObject();
	}

}
