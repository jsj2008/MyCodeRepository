package server.DB;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnectionOffer {
	protected DataSource ds;

	public boolean init() {
		ds = getDataSource();
		return ds != null;
	}

	public void destroy() {
	}

	public Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

	@SuppressWarnings("unchecked")
	private DataSource getDataSource() {
		try {
			InitialContext ic = new InitialContext();
			Enumeration enu = ic.getEnvironment().elements();
			if (enu.hasMoreElements()) {
			}
			DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/ServerFront");
			return ds;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
