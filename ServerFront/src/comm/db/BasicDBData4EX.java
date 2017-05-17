package comm.db;

import java.io.Serializable;
import java.lang.reflect.Method;

public class BasicDBData4EX implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9001180663277467743L;

	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		Class<? extends BasicDBData4EX> cl = this.getClass();
		try {
			for (Method mt : cl.getMethods()) {
				if (mt.getName().startsWith("get")&&!mt.getName().equalsIgnoreCase("getClass")) {
					Object obj=mt.invoke(this);
					if(obj!=null) {
						sb.append(obj.toString());
					}else {
						sb.append("");
					}
					sb.append("|");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

}
