package server.trade;

import server.DB.dao.UserDao;

import comm.db.User;
import comm.message.IPFather;
import comm.message.IP_Client1001;
import comm.message.OPFather;
import comm.message.OP_Client1001;

public class TradeClient1001 extends TradeFather {

	@Override
	protected OPFather doTrade(IPFather _ip) {

		IP_Client1001 ip = (IP_Client1001) _ip;
		OP_Client1001 op = new OP_Client1001(ip);
		op.setSucceed(true);

		try {
			UserDao userDao = getDBOperator(UserDao.class);
			User user = userDao.query("test");
			System.out.println();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return op;
	}

}
