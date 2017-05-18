package jedi.ex01.client.station.api.doc.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import jedi.ex01.CSTS3.comm.struct.MoneyAccount;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.client.station.api.doc.DataDoc;

public class AccountDigestUtil {
	private AccountDigestUtil() {

	}

	public static boolean isAccountDigestMatch(String digest) {
		try {
			String info = getAccountInfo();
			byte digestBuff[] = getDigestBuff(info);
			return isDigestMatch(digestBuff, digest);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	private static boolean isDigestMatch(byte digestBuff[], String digest) {
		try {
			String digest1 = parseBuff2String(digestBuff, 36, false);
			if (digest1.equalsIgnoreCase(digest)) {
				return true;
			}
			String digest2 = parseBuff2String(digestBuff, 36, true);
			if (digest2.equalsIgnoreCase(digest)) {
				return true;
			}
			String digest3 = parseBuff2String(digestBuff, 16, true);
			if (digest3.equalsIgnoreCase(digest)) {
				return true;
			}
			String digest4 = parseBuff2String(digestBuff, 16, false);
			if (digest4.equalsIgnoreCase(digest)) {
				return true;
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static byte[] getAccountDigestBuf(long acid) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return md.digest(getAccountDigest().getBytes());
	}

	public static String getAccountDigest() {
		return getAccountDigest(36, false);
	}

	public static String getAccountDigest(int radix, boolean unsign) {
		try {
			String info = getAccountInfo();
			byte buf[] = getDigestBuff(info);
			return parseBuff2String(buf, radix, unsign);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static String getAccountInfo() {
		AccountStore account = DataDoc.getInstance().getAccountStore();
		List<TTrade4CFD> tradeList = DataDoc.getInstance().getTradeList();
		List<TOrders4CFD> orderList = DataDoc.getInstance().getOrderList();
		TTrade4CFD[] tradeVec = null;
		TOrders4CFD[] orderVec = null;
		if (tradeList != null) {
			tradeVec = (TTrade4CFD[]) tradeList.toArray(new TTrade4CFD[0]);
			Arrays.sort(tradeVec, new Comparator<TTrade4CFD>() {
				public int compare(TTrade4CFD o1, TTrade4CFD o2) {
					TTrade4CFD t1 = (TTrade4CFD) o1;
					TTrade4CFD t2 = (TTrade4CFD) o2;
					if (t1.getTicket() > t2.getTicket()) {
						return 1;
					} else if (t1.getTicket() < t2.getTicket()) {
						return -1;
					} else {
						return t1.getSplitNo() > t2.getSplitNo() ? 1 : -1;
					}
				}
			});
		}
		if (orderList != null) {
			orderVec = (TOrders4CFD[]) orderList.toArray(new TOrders4CFD[0]);
			Arrays.sort(orderVec, new Comparator<TOrders4CFD>() {
				public int compare(TOrders4CFD o1, TOrders4CFD o2) {
					TOrders4CFD t1 = (TOrders4CFD) o1;
					TOrders4CFD t2 = (TOrders4CFD) o2;
					if (t1.getOrderID() > t2.getOrderID()) {
						return 1;
					} else if (t1.getOrderID() < t2.getOrderID()) {
						return -1;
					} else {
						return t1.getOsplitNo() > t2.getOsplitNo() ? 1 : -1;
					}
				}
			});
		}
		String info = getAccountInfo(account, tradeVec, orderVec);
		return info;
	}

	public static String getAccountInfo(AccountStore account, TTrade4CFD[] tradeList, TOrders4CFD[] orderList) {
		StringBuffer sb = new StringBuffer();
		MoneyAccount[] moneyAccounts = account.getMoneyAccounts();
		Arrays.sort(moneyAccounts, new Comparator<MoneyAccount>() {
			public int compare(MoneyAccount o1, MoneyAccount o2) {
				MoneyAccount ma1 = (MoneyAccount) o1;
				MoneyAccount ma2 = (MoneyAccount) o2;
				return ma1.getCurrencyName().compareTo(ma2.getCurrencyName());
			}
		});
		sb.append("$account=");
		sb.append(account.getAccountID());
		sb.append(",");
		for (int i = 0; i < moneyAccounts.length; i++) {
			MoneyAccount tempmac = moneyAccounts[i];
			double tempmoney = tempmac.getBeginBalance() + tempmac.getCommision() + tempmac.getDeposit() + tempmac.getMargin2()
					+ tempmac.getRollover() + tempmac.getTradePL() + tempmac.getTransfer() + tempmac.getWithdraw()
					+ tempmac.getAdjust() + tempmac.getCharge() + tempmac.getOther();
			if (Math.abs(tempmoney) > 0.01) {
				sb.append(tempmac.getCurrencyName() + "=" + formatDouble(tempmoney) + ",");
			}
		}
		sb.append("@");
		if (tradeList != null) {
			sb.append("trade=");
			sb.append(tradeList.length);
			sb.append(",");
			for (int i = 0; i < tradeList.length; i++) {
				TTrade4CFD trade = tradeList[i];
				sb.append(trade.getTicket() + "_" + trade.getSplitNo());
				sb.append("#");
			}
		}
		sb.append("@");
		if (orderList != null) {
			sb.append("order=");
			sb.append(orderList.length);
			sb.append(",");
			for (int i = 0; i < orderList.length; i++) {
				TOrders4CFD order = orderList[i];
				sb.append(order.getOrderID() + "_" + order.getOsplitNo());
				sb.append("#");
			}
		}
		return sb.toString();
	}

	private static byte[] getDigestBuff(String str) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte buf[] = md.digest(str.getBytes());
		return buf;
	}

	private static String parseBuff2String(byte[] buf, int radix, boolean unsign) {
		if (unsign) {
			String result = "";
			for (byte b : buf) {
				String hex = Integer.toString(b & 0xFF, radix);
				result = result + hex.toUpperCase();
			}
			return result;
		} else {
			BigInteger bi = new BigInteger(buf);
			return bi.toString(radix);
		}
	}

	private static String formatDouble(double data) {
		DecimalFormat format = new DecimalFormat("0.0000");
		return format.format(data);
	}
}
