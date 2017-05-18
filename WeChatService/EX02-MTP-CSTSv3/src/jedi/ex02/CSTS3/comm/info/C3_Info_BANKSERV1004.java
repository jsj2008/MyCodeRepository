package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_BankOrder;
import jedi.v7.bankserver.comm.infor.dealer.INFO_BankServ1004;
import jedi.v7.bankserver.comm.struct.BankOrder;
import jedi.v7.comm.datastruct.information.InforFather;

/***
 * 用户存取款结果通知
 * 
 * @author zhanglei
 * a // 并没有什么用 通知dealer的
 */

public class C3_Info_BANKSERV1004 extends C3_InfoFather {

	public static final String jsonId = "Info_BANKSERV1004";

	public static final String bankOrder = "1";

	public C3_Info_BANKSERV1004(InforFather info) {
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(INFO_BankServ1004 data) throws Exception {
		super.parseFromSysData(data);
		C3_BankOrder bankOrder = new C3_BankOrder();
		BankOrder order = data.getOrder();
		bankOrder.parseFromSysData(order);
		setBankOrder(bankOrder);
	}

	public C3_BankOrder getBankOrder() {
		try {
			C3_BankOrder data = getEntryObject(C3_Info_BANKSERV1004.bankOrder);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankOrder(C3_BankOrder bankOrder) {
		setEntry(C3_Info_BANKSERV1004.bankOrder, bankOrder);
	}

}
