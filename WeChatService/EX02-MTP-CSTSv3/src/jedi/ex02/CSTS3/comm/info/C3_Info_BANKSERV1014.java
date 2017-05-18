package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_BankRequestOrder;
import jedi.v7.bankserver.comm.infor.dealer.INFO_BankServ1014;
import jedi.v7.bankserver.comm.struct.BankRequestOrder;
import jedi.v7.comm.datastruct.information.InforFather;

public class C3_Info_BANKSERV1014 extends C3_InfoFather {
	public static final String jsonId = "Info_BANKSERV1014";

	public static final String bankRequestOrder = "1";

	public C3_Info_BANKSERV1014(InforFather info) {
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(INFO_BankServ1014 data) throws Exception {
		super.parseFromSysData(data);
		C3_BankRequestOrder bankRequestOrder = new C3_BankRequestOrder();
		BankRequestOrder order = data.getRequestOrder();
		bankRequestOrder.parseFromSysData(order);
		setBankRequestOrder(bankRequestOrder);
	}

	public C3_BankRequestOrder getRequestOrder() {
		try {
			C3_BankRequestOrder data = getEntryObject(C3_Info_BANKSERV1014.bankRequestOrder);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankRequestOrder(C3_BankRequestOrder bankRequestOrder) {
		setEntry(C3_Info_BANKSERV1014.bankRequestOrder, bankRequestOrder);
	}
}
