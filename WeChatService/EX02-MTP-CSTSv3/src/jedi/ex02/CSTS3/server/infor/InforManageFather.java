package jedi.ex02.CSTS3.server.infor;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.v7.comm.datastruct.information.InforFather;

public abstract class InforManageFather {

	public C3_InfoFather call_format(InforFather infor) {
		try {
			return formatInfor(infor);
		} catch (Exception e) {
			return null;
		}
	}

	protected abstract C3_InfoFather formatInfor(InforFather infor);

}
