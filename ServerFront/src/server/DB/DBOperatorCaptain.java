package server.DB;

import java.util.HashMap;

public class DBOperatorCaptain {
	private HashMap<String, DBOperatorFather> operatorMap = new HashMap<String, DBOperatorFather>();
	private DBConnectionOffer offer = new DBConnectionOffer();
	private boolean destroy;

	public DBOperatorCaptain() {
	}

	public boolean init() {
		if (!offer.init()) {
			return false;
		}
		destroy = false;
//		new DBScaner().start();
		return true;
	}

	public void destroy() {
		destroy = true;
		offer.destroy();
	}

//	public void scanDB() {
//		Connection con = null;
//		Statement stmt = null;
//		ResultSet rst = null;
//		try {
//			con = offer.getConnection();
//			stmt = con.createStatement();
//			rst = stmt.executeQuery("select 123 from dual");
//			// StaticContext.getMonitorCaptain().getProxy().sendTDBConnectionStatus(true,"");
//		} catch (Exception e) {
//			// StaticContext.getMonitorCaptain().getProxy().sendTDBConnectionStatus(false,
//			// e.getMessage());
//		} finally {
//			try {
//				if (rst != null) {
//					rst.close();
//				}
//			} catch (Exception e1) {
//			}
//			try {
//				if (stmt != null) {
//					stmt.close();
//				}
//			} catch (Exception e) {
//			}
//			try {
//				if (con != null) {
//					con.close();
//				}
//			} catch (Exception e) {
//			}
//		}
//	}

	public DBOperatorFather getDBOperator(String id) throws Exception {
		DBOperatorFather dbOper = (DBOperatorFather) operatorMap.get(id);
		if (dbOper == null) {
			String className = getClass().getPackage().getName() + ".opt.DBOperator" + id;
			try {
				dbOper = (DBOperatorFather) Class.forName(className).newInstance();
				dbOper.init(offer);
				operatorMap.put(id, dbOper);
			} catch (Exception e) {
				System.out.println("Init DB operator for " + id + " failed!");
				throw e;
			}
		}
		return dbOper;
	}

	@SuppressWarnings("unchecked")
	public <T extends DBOperatorFather> T getDBOperator(Class<T> cls) throws Exception {
		synchronized (operatorMap) {
			String clsName = cls.getName();
			DBOperatorFather dbf = operatorMap.get(clsName);
			if (dbf == null) {
				try {
					dbf = (DBOperatorFather) cls.newInstance();
					dbf.init(offer);
					operatorMap.put(clsName, dbf);
				} catch (Exception e) {
					System.out.println("Init DB operator for " + cls.getName() + " failed!");
					throw e;
				}
			}
			return (T) dbf;
		}
	}

	public boolean isDestroy() {
		return destroy;
	}
}

// class DBScaner extends Thread {
//
// @Override
// public void run() {
// while (!ServerContext.getDBOperatorCaptain().isDestroy()) {
// ServerContext.getDBOperatorCaptain().scanDB();
// try {
// sleep(30 * 1000);
// } catch (InterruptedException e) {
// }
// }
// }
//
// }
