package test;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Locale;

import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.proxy.client.CSTSProxy;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.ClientAPI;
import jedi.ex01.client.station.api.bankserver.BCTradeResult_DWCheck;
import jedi.ex01.client.station.api.bankserver.BCTradeResult_UserBankProfile;
import jedi.ex01.client.station.api.bankserver.BankServCommData;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.util.DocUtil;
import jedi.ex01.client.station.api.event.API_IDEvent;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEventListener;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;
import jedi.ex01.client.station.api.trade.TradeAPI;

public class LoginTest {
	private final String xmlFile = "login.obj.xml";
	private final String userName = "T001";
	private final String passwords = "888888";

	public void prepare() {

		API_IDEventCaptain.getInstance().addListener(new API_IDEventListener() {

			public void onStationEvent(API_IDEvent event) {
				Object[] values = (Object[]) event.getEventData();
				for (Object value : values) {
					if (value instanceof QuoteData) {
						QuoteData quote = (QuoteData) value;
						//
						System.out.println(quote.getInstrument() + " | "
								+ quote.getBid() + " | " + quote.getAsk());
					}
				}
			}
		}, API_IDEvent_NameInterface.DATA_ON_NewQuote);

		API_IDEventCaptain.getInstance().addListener(new API_IDEventListener() {

			@Override
			public void onStationEvent(API_IDEvent event) {
				Object[] values = event.getEventData();
				for (Object value : values) {
					System.out.println(value);
				}
				System.out.println("------------------");
			}
		}, API_IDEvent_NameInterface.DATA_ON_Trade_Changed);
	}

	public boolean init() {
		long t1 = System.currentTimeMillis();
		try {
			String xml = readFile(xmlFile);
			// System.out.println(xml);
			ClientAPI.prepareAddressCaptain4XML(xml);
			ClientAPI.getInstance().prepareCSTSList(true, userName, passwords,
					false);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		long t2 = System.currentTimeMillis();
		System.out.println("-------------init used " + (t2 - t1));
		return true;
	}

	public boolean login() {
		long t1 = System.currentTimeMillis();
		try {
			int result = ClientAPI.getInstance().loginToBestAddress();
			System.out.println(result);
			if (result != MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED) {
				return false;
			}
			System.out.println(ClientAPI.getInstance().getCurrentAddress()
					.getIp()
					+ ":"
					+ ClientAPI.getInstance().getCurrentAddress().getPort()
					+ " result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		long t2 = System.currentTimeMillis();
		System.out.println("--------------login used " + (t2 - t1));
		return true;
	}

	public boolean initDoc() {
		long t1 = System.currentTimeMillis();
		try {
			boolean flag = ClientAPI.getInstance().initDoc(Locale.CHINA,
					new String[0]);
			if (!flag) {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		long t2 = System.currentTimeMillis();
		System.out.println("----------------init doc used " + (t2 - t1));
		return true;
	}

	public void test() {
		prepare();
		if (!init()) {
			System.out.println("init failed");
			return;
		}
		if (!login()) {
			System.out.println("login failed");
			return;
		}
		if (!initDoc()) {
			System.out.println("initDoc failed");
			return;
		}
		System.out
				.println("#####################################################3");
	}

	public String readFile(String filePath) throws Exception {
		FileReader in = null;
		try {
			StringBuffer sb = new StringBuffer();
			in = new FileReader(filePath);
			BufferedReader r = new BufferedReader(in);
			String line = null;
			while ((line = r.readLine()) != null) {
				sb.append(line);
				sb.append("\r\n");
			}
			return sb.toString();
		} finally {
			if (in != null) {
				in.close();
			}
		}

	}

	public static void main(String args[]) {
		CSTSProxy.debug = true;
		LoginTest test = new LoginTest();
		test.test();
		AccountStore asAccountStore = DataDoc.getInstance().getAccountStore();
		System.out.println("鍙栧緱鐨勮处鍙蜂负" + asAccountStore.getAccountID());

		BCTradeResult_UserBankProfile bactrsult = TradeAPI.getInstance()
				.getUserBankProfile(asAccountStore.getAccountID());

		// System.out.println("鏍规嵁璐﹀彿鑾峰彇绛剧害閾惰淇℃伅杩斿洖鐨勫�涓�=" + "閾惰璐﹀彿"
		// + bactrsult.getProfile().getAccount() + "==" + "閿欒浠ｇ爜:"
		// + bactrsult.getErrCode() + "==" + "杩斿洖鐨勬祦姘村彿涓�"
		// + bactrsult.getStream().getStreamID() + " --- "
		// + bactrsult.getErrMessage());

		// 鑾峰彇娴佹按鍙�
		BCTradeResult_DWCheck dwcheck = TradeAPI.getInstance().dwCheck(
				bactrsult.getProfile().getBankID(),
				asAccountStore.getAccountID(),
				BankServCommData.ORDERTYPE_DEPOSIT);

		// System.out.println("鎷垮埌鐨勬祦姘村彿涓� == " + dwcheck.getStreamId());
		// 鍑哄叆閲戠殑绫诲瀷濡備笅
		// isDeposit() ? BankServCommData.ORDERTYPE_DEPOSIT
		// : BankServCommData.ORDERTYPE_WITHDRAWAL

		// 瀛樻涔熷氨鏄叆閲�
		// BCTradeResult_Deposit bctr_deposit = TradeAPI.getInstance().deposit(
		// dwcheck.getStreamId(), bactrsult.getProfile().getBankID(),
		// "T001", "888888", asAccountStore.getAccountID(), 0.1, null,
		// null);
		//
		// System.out.println("鍏ラ噾鐨勮繑鍥炲�==" + "閿欒浠ｇ爜涓�" +
		// bctr_deposit.getErrMessage()
		// + "==鍙栧緱鍏ラ噾鐨剈rl涓�" + bctr_deposit.getDepositUrl() + "==鍏ラ噾鏄惁鎴愬姛:"
		// + bctr_deposit.isSucceed());

		// 鍙栨涔熷氨鏄嚭閲�
		// BCTradeResult bcresult =
		// TradeAPI.getInstance().withdrawal(dwcheck.getStreamId(),
		// bactrsult.getProfile().getBankID(),
		// "T001", "888888", asAccountStore.getAccountID(), 0.01, null, null);
		//
		// System.out.println("鍑洪噾鐨勮繑鍥為敊璇唬鐮佷负:" + bcresult.getErrMessage() +
		// "鍑洪噾鏄惁鎴愬姛:" + bcresult.isSucceed());

		// TradeAPI.getInstance().doOpenNormalOrderCFDTrade("EUR/USD", true, 1,
		// 1.1, 0, true, new long[0], null, 0, 0, false);
	}

	public static boolean isInstrumentVisable(Instrument instrument) {
		if (instrument == null
				|| instrument.getIsDead() == MTP4CommDataInterface.TRUE
				|| instrument.getIsVisable() == MTP4CommDataInterface.FALSE) {
			return false;
		}
		AccountStore store = DataDoc.getInstance().getAccountStore();
		if (store != null) {
			return DocUtil.isInstrumentVisable(store.getGroupName(),
					store.getAccountID(), instrument.getInstrument());
		}
		return false;
	}

	// public static void main(String[] args) {
	// System.out.println(TimeZone.getDefault());
	// }
}
