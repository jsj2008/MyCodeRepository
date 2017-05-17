package server.DB;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class DBOperatorFather {
	private DBConnectionOffer __dbConnOffer = null;

	void init(DBConnectionOffer connOffer) {
		__dbConnOffer = connOffer;
	}

	protected Connection getDBConnection() throws SQLException {
		return __dbConnOffer.getConnection();
	}

	public static Timestamp timeTrans(Date time) {
		if (time == null) {
			return null;
		} else {
			Timestamp ts = new Timestamp(time.getTime());
			return ts;
		}
	}

	/**
	 * ͨ�ò�ѯ��䣨��ѯ���У�
	 * 
	 * @param <V>
	 * @param sql
	 * @param mapping
	 * @param args
	 * @return Ĭ�Ϸ���ArrayList
	 * @throws Exception
	 */
	protected <V> List<V> doQueryForList(String sql, RowMapping<V> mapping, Object... args) throws Exception {
		List<V> list = new LinkedList<V>();
		doQueryForListWithContainer(list, sql, mapping, args);
		return list;
	}

	/**
	 * ͨ�ò�ѯ��䣨��ѯ���У�
	 * 
	 * @param <V>
	 * @param container
	 * @param sql
	 * @param mapping
	 * @param args
	 * @throws Exception
	 */
	protected <V> void doQueryForListWithContainer(List<V> container, String sql, RowMapping<V> mapping, Object... args) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getDBConnection();
			pstmt = conn.prepareStatement(sql);
			setArgus(pstmt, args);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				V value = mapping.mapping(rs);
				if (value != null) {
					container.add(value);
				}
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}
			}
		}
	}
	/**
	 * ����PreparedStatement����
	 * 
	 * @param pstmt
	 * @param args
	 * @throws SQLException
	 */
	protected static void setArgus(PreparedStatement pstmt, Object[] args) throws SQLException {
		if (args == null) {
			return;
		}

		int index = 1;
		for (Object o : args) {
			if (o == null) {
				pstmt.setNull(index++, Types.VARCHAR);
			} else if (o instanceof String) {
				pstmt.setString(index++, (String) o);
			} else if (o instanceof Integer) {
				pstmt.setInt(index++, (Integer) o);
			} else if (o instanceof Long) {
				pstmt.setLong(index++, (Long) o);
			} else if (o instanceof Double) {
				pstmt.setDouble(index++, (Double) o);
			} else if (o instanceof Date) {
				Date time = (Date) o;
				Timestamp t = new Timestamp(time.getTime());
				pstmt.setTimestamp(index++, t);
			} else if (o instanceof Boolean) {
				pstmt.setBoolean(index++, (Boolean) o);
			} else if (o instanceof Float) {
				pstmt.setFloat(index++, (Float) o);
			} else if (o instanceof Enum<?>) {
				pstmt.setString(index++, o.toString());
			} else if (o instanceof BigDecimal) {
				pstmt.setBigDecimal(index++, (BigDecimal) o);
			} else if (o instanceof Short) {
				pstmt.setShort(index++, (Short) o);
			} else if (o instanceof Byte) {
				pstmt.setByte(index, (Byte) o);
			} else {
				pstmt.setObject(index++, o);
			}
		}
	}
	public static interface RowMapping<V> {
		/**
		 * 
		 * @param rs
		 * @return null��ʾ����Ҫ�ý��
		 * @throws SQLException
		 */
		V mapping(ResultSet rs) throws SQLException;
	}
	
	/**
	 * ͨ�ø������
	 * 
	 * @param sql
	 * @param args
	 * @return
	 * @throws Exception
	 */
	protected int doUpdate(String sql, Object... args) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getDBConnection();
			pstmt = conn.prepareStatement(sql);
			setArgus(pstmt, args);
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}
			}
		}
	}
	
	/**
	 * ͨ�ò�ѯ��䣨��ѯ���У�
	 * 
	 * @param <V>
	 * @param sql
	 * @param map
	 * @param args
	 * @return
	 * @throws Exception
	 */
	protected <V> V doQueryForObject(String sql, RowMapping<V> mapping, Object... args)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getDBConnection();
			pstmt = conn.prepareStatement(sql);
			setArgus(pstmt, args);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				return mapping.mapping(rs);
			} else {
				return null;
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}
			}
		}
	}

}
