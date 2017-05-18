package allone.MTP.VerBank01.Ctrl.ca;

public interface CACommonDataInterface {

	public static final int CERT_OK = 0;
	public static final int CERT_READY_FOR_RETURN = 10;
	public static final int CERT_APPLICATE_FAILED = 11;
	public static final int CERT_READY_FOR_DOWNLOAD = 12;
	public static final int CERT_WAIT_FOR_AUDIT = 13;
	public static final int CERT_CANCEL = 20;
	public static final int CERT_EXPIRED = 30;
	public static final int CERT_TO_BE_EXPIRED = 31;
	public static final int CERT_NOT_FOUND = 40;
	public static final int CERT_SUSPEND = 50;
	public static final int CERT_REGISTER_ONLINE = 60;
	public static final int CERT_REGISTER_ON_COUNTER = 61;
	public static final int CERT_REGISTER_CANCELED = 62;
	public static final int CERT_REGISTER_EXPIRED = 63;
}
