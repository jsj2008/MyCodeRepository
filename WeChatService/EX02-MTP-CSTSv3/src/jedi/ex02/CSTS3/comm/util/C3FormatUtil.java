package jedi.ex02.CSTS3.comm.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class C3FormatUtil {
	
	private static final SimpleDateFormat timeSDF=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static String formatTime(Date date){
		if(date==null){
			return null;
		}
		synchronized (timeSDF) {
			return timeSDF.format(date);
		}
	}
	
	public static Date parseTime(String time){
		if(time==null){
			return null;
		}
		synchronized (timeSDF) {
			try {
				return timeSDF.parse(time);
			} catch (Exception e) {
				return null;
			}
		}
	}
	
	public static byte[] objectToByte(Object obj) throws Exception{
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(
				new BufferedOutputStream(bos));
		oos.writeObject(obj);
		oos.flush();
		byte buf[] = bos.toByteArray();
		return buf;
	}
	
	public static Object byteToObject(byte[] buf) throws Exception{
		ByteArrayInputStream bis = new ByteArrayInputStream(buf);
		ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(
				bis));
		return ois.readObject();
	}

}
