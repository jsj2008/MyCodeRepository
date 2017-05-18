package jedi.ex01.CSTS3.proxy.debug;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;

public class PackageLog {
	private static boolean debug = false;
	private static String path;
	private static LinkedList list = new LinkedList();
	private static BufferedWriter writer = null;
	private static Thread thread = null;

	public static boolean isDebug() {
		return debug;
	}

	public static void startDebug(String path) throws FileNotFoundException {
		PackageLog.debug = true;
		PackageLog.path = path;
		writer = new BufferedWriter(new OutputStreamWriter(
				new FileOutputStream(path)));
		thread = new Thread() {
			public void run() {
				PackageLog.run();
			}
		};
		thread.start();
	}

	public static void endDebug() {
		PackageLog.debug = false;
		thread.interrupt();
		thread = null;
		if (writer != null) {
			try {
				writer.close();
			} catch (Exception e) {
			}
			writer = null;
		}
	}

	public static void log_Package(Object obj, String des) {
		if (!PackageLog.debug) {
			return;
		}
		int size = 0;
		ByteArrayOutputStream bos = null;
		try {
			bos = new ByteArrayOutputStream();
			ObjectOutputStream oos = new ObjectOutputStream(bos);
			oos.writeObject(obj);
			oos.flush();
			oos.close();
			size = bos.toByteArray().length;
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			_logout(sdf.format(new Date()) + "   size : " + size + "  \t" + des);
		} catch (Exception e) {
		} finally {
			if (bos != null) {
				try {
					bos.close();
				} catch (Exception e) {
				}
			}
		}
	}

	private static void _logout(String des) {
		synchronized (list) {
			list.addFirst(des);
		}
	}

	private static void __write(String des) {
		if (writer != null) {
			try {
				writer.write(des);
				writer.write("\r\n");
				writer.flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	static void run() {
		while (debug) {
			String str = null;
			synchronized (list) {
				if (!list.isEmpty()) {
					str = list.removeLast().toString();
				}
			}
			if (str != null) {
				__write(str);
			} else {
				try {
					Thread.sleep(1000);
				} catch (Exception e) {
				}
			}
		}
	}
}
