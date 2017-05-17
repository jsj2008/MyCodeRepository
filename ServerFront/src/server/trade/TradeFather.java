package server.trade;

import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.Status;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;

import server.DB.DBOperatorFather;
import server.define.ErrCodeTable;
import server.start.ServerContext;

import comm.message.IPFather;
import comm.message.OPFather;

public abstract class TradeFather {

	private UserTransaction ut;

	private ThreadLocal<Boolean> currents = new ThreadLocal<Boolean>();

	protected void begin() throws SystemException, NotSupportedException {
		if (ut.getStatus() == Status.STATUS_NO_TRANSACTION) {
			ut.begin();
			currents.set(true);
		} else {
			currents.set(false);
		}
	}

	protected void commit() throws SecurityException, IllegalStateException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException {
		Boolean cur = currents.get();
		if (ut.getStatus() == Status.STATUS_ACTIVE && cur != null && cur) {
			ut.commit();
			currents.remove();
		}
	}

	protected void rollback() {
		try {
			// Boolean cur = currents.get();
			// if (ut.getStatus() == Status.STATUS_ACTIVE && cur != null && cur)
			// {
			ut.rollback();
			// currents.remove();
			// }
		} catch (IllegalStateException e) {
			// e.printStackTrace();
		} catch (SecurityException e) {
			// e.printStackTrace();
		} catch (SystemException e) {
			// e.printStackTrace();
		}
	}

	public void init(UserTransaction ut) {
		this.ut = ut;
	}

	public OPFather call_trade(IPFather ip) {
		try {
			return doTrade(ip);
		} catch (Exception e) {
			OPFather op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(ErrCodeTable.ERR_Unknown);
			op.setErrMessage("Unknow Err." + e.getMessage());
			e.printStackTrace();
			return op;
		} finally {
			rollback();
		}
	}

	protected abstract OPFather doTrade(IPFather _ip);

	protected <T extends DBOperatorFather> T getDBOperator(Class<T> cls) throws Exception {
		return ServerContext.getDBOperatorCaptain().getDBOperator(cls);
	}
}
