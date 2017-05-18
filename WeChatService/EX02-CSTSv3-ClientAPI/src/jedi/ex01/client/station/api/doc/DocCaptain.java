package jedi.ex01.client.station.api.doc;


public class DocCaptain {
	private final static DocCaptain instance = new DocCaptain();

	public static DocCaptain getInstance() {
		return instance;
	}

	public static DataDoc getDataDoc() {
		return DataDoc.getInstance();
	}

	private static boolean inited = false;

	public static void setInited(boolean flag) {
		inited = flag;
	}

	public static boolean isInited() {
		return inited;
	}

	private DocCaptain() {

	}

	public boolean init() {
		return true;
	}

	public void destroy() {

	}
}
