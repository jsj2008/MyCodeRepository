package allone.MTP.VerBank01.Ctrl.util;

import java.util.List;

public class ListUtil {

	public static <T> void setupList(List<T> list, T[] array) {
		for (T t : array) {
			list.add(t);
		}
	}
}
