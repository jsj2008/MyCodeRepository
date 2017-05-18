package jedi.ex02.CSTS3.server.infor;

import java.util.HashMap;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.v7.comm.datastruct.information.InforFather;

public class InforCaptain {
	private HashMap<String, InforManageFather> inforMap = new HashMap<String, InforManageFather>();

	public C3_InfoFather formatInfor(InforFather infor) {
		//inforMap里面、若没有则放入
		InforManageFather imf = inforMap.get(infor.get_ID());
		if (imf == null) {
			try {
				imf = (InforManageFather) Class.forName(
						getClass().getPackage().getName() + ".InforManage"
								+ infor.get_ID()).newInstance();
				inforMap.put(infor.get_ID(), imf);
			} catch (Exception e) {
				return null;
			}
		}
		return imf.call_format(infor);
	}

}
