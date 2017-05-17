package server.DB.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import server.DB.DBOperatorFather;

import comm.db.User;

public class UserDao extends DBOperatorFather {

	public int delete(String userName) throws Exception {
		int flag = 0;
		Connection con = null;
		PreparedStatement stmt = null;
		String sql = "delete from m_user where user_name=?";
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			stmt.setObject(1, userName);
			flag = stmt.executeUpdate();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return flag;
	}

	public int insert(User data) throws Exception {
		int flag = 0;
		Connection con = null;
		PreparedStatement stmt = null;
		String sql = insertSQL();
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			insertUtil(stmt, data);
			flag = stmt.executeUpdate();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return flag;
	}

	public int update(User data) throws Exception {
		int flag = 0;
		Connection con = null;
		PreparedStatement stmt = null;
		String sql = updateSQL();
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			updateUtil(stmt, data);
			flag = stmt.executeUpdate();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return flag;
	}

	public int insertOrUpdate(User data) throws Exception {
		int flag = 0;
		Connection con = null;
		PreparedStatement stmt = null;
		String sql = insertOrUpdateSQL();
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			insertOrUpdateUtil(stmt, data);
			flag = stmt.executeUpdate();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return flag;
	}

	public int insertOrUpdate(User[] dataVec) throws Exception {
		int flag = 0;
		Connection con = null;
		PreparedStatement stmt = null;
		String sql = insertOrUpdateSQL();
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			for (User data : dataVec) {
				insertOrUpdateUtil(stmt, data);
				stmt.addBatch();
			}
			stmt.executeBatch();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return flag;
	}

	public User[] queryAll() throws Exception {
		ArrayList<User> list = new ArrayList<User>();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		String sql = "select * from m_user";
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			rst = stmt.executeQuery();
			while (rst.next()) {
				User data = getData(rst);
				list.add(data);
			}
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return list.toArray(new User[0]);
	}

	public User query(String userName) throws Exception {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rst = null;
		String sql = "select * from m_user";
		sql += " where user_name=?";
		try {
			con = getDBConnection();
			stmt = con.prepareStatement(sql);
			stmt.setObject(1, userName);
			rst = stmt.executeQuery();
			while (rst.next()) {
				User data = getData(rst);
				return data;
			}
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return null;
	}

	public static User getData(ResultSet rst) throws Exception {
		User data = new User();
		data.setUserName(rst.getString("user_name"));
		data.setPassword(rst.getString("password"));
		return data;
	}

	public static void getData(ResultSet rst, User data) throws Exception {
		data.setUserName(rst.getString("user_name"));
		data.setPassword(rst.getString("password"));
	}

	public static void insertUtil(PreparedStatement stmt, User data) throws Exception {
		stmt.setObject(1, data.getUserName());
		stmt.setObject(2, data.getPassword());
	}

	public static String insertSQL() {
		return "insert into m_user(user_name,password) values (?,?)";

	}

	public static void updateUtil(PreparedStatement stmt, User data) throws Exception {
		stmt.setObject(1, data.getUserName());
		stmt.setObject(2, data.getPassword());
	}

	public static String updateSQL() {
		return "update m_user set user_name=?,password=? where user_name=?";
	}

	public static void insertOrUpdateUtil(PreparedStatement stmt, User data) throws Exception {
		stmt.setObject(1, data.getUserName());
		stmt.setObject(2, data.getPassword());
	}

	public static String insertOrUpdateSQL() {
		return "insert into m_user(user_name,password) values (?,?)  ON DUPLICATE KEY UPDATE user_name=?,password=?";
	}

}
