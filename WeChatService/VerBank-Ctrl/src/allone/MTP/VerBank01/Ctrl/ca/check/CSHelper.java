package allone.MTP.VerBank01.Ctrl.ca.check;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class CSHelper {

	private static final Properties DESC_PROP;
	static {
		InputStream is = CSHelper.class.getResourceAsStream("cert_state.properties");
		DESC_PROP = new Properties();
		try {
			DESC_PROP.load(is);
		} catch (IOException e) {
			throw new InternalError("init cert state desciption failed.");
		}		
		
	}
	
	public static String desc(String key) {
		return DESC_PROP.getProperty(key);
	}
}
