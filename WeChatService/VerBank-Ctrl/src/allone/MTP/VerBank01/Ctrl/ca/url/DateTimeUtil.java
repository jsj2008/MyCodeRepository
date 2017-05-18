package allone.MTP.VerBank01.Ctrl.ca.url;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {

	
	public static final String DAY_TIME = "yyyyMMddHHmmss";
	private static final ThreadLocal<SimpleDateFormat> sdfDayTimes = new ThreadLocal<SimpleDateFormat>() {

		@Override
		protected SimpleDateFormat initialValue() {
			return new SimpleDateFormat(DAY_TIME);
		}
		
	};
	
	public static String format(Date dateTime) {
		SimpleDateFormat sdf = sdfDayTimes.get();
		return sdf.format(dateTime);
	}
}
