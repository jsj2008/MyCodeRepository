package comm.message;

import java.io.Serializable;
import java.security.SecureRandom;

public class IPFather implements Serializable {
	private static final long serialVersionUID = -8107844503083140411L;
	private String _HashID;
	private String _ID;
	private String _fromServer;
	private String _toServer;
	private long _CreateTime;
	private String _description;

	public IPFather() {
		SecureRandom sr = new SecureRandom();
		_HashID = (Long.toHexString(System.currentTimeMillis() % 10000000) + "_" + Long.toHexString(hashCode()) + "_" + Integer.toHexString(sr.nextInt())).toUpperCase();
		_CreateTime = System.currentTimeMillis();
		String classname = getClass().getName();
		if (classname.indexOf("_") >= 0) {
			this.set_ID(classname.substring(classname.lastIndexOf("_") + 1));
		}
	}

	public String get_ID() {
		return _ID;
	}

	public void set_ID(String _id) {
		_ID = _id;
	}

	public String get_HashID() {
		return _HashID;
	}

	public long get_CreateTime() {
		return _CreateTime;
	}

	public String toXmlString() {
		return "";
	}

	public String get_fromServer() {
		return _fromServer;
	}

	public void set_fromServer(String server) {
		_fromServer = server;
	}

	public String get_toServer() {
		return _toServer;
	}

	public void set_toServer(String server) {
		_toServer = server;
	}

	public String get_description() {
		return _description;
	}

	public void set_description(String _description) {
		this._description = _description;
	}

	public static void main(String args[]) {
		for (int i = 0; i < 100; i++) {
			System.out.println(new IPFather().get_HashID());
		}
	}
}
