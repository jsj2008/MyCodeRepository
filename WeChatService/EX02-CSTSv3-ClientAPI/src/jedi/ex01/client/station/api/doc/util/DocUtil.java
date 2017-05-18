package jedi.ex01.client.station.api.doc.util;

import java.util.HashSet;

import jedi.ex01.CSTS3.comm.struct.GroupConfig;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.TradeTypeConfig;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.BalanceUtil;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;

public class DocUtil {

	private static HashSet<String> marketClosedInstrument = new HashSet<String>();

	public static void setClosedInstruments(String[] instruments) {
		synchronized (marketClosedInstrument) {
			marketClosedInstrument.clear();
			for (int i = 0; i < instruments.length; i++) {
				marketClosedInstrument.add(instruments[i]);
			}
		}
	}

	public static boolean isTradableQuote(String instrument) {
		if (!DocCaptain.isInited()) {
			return false;
		}
		if (DataDoc.getInstance().getSystemConfig().getCloseStatus() != MTP4CommDataInterface.CLOSESTATUS_OPEN) {
			return false;
		}
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);
		if (instrumentNode == null) {
			return false;
		}
		if (instrumentNode.getIsDead() == MTP4CommDataInterface.TRUE
				|| instrumentNode.getTradeable() == MTP4CommDataInterface.FALSE
				|| instrumentNode.getGroup_tradeable() == MTP4CommDataInterface.FALSE
				|| instrumentNode.getAccount_tradeable() == MTP4CommDataInterface.FALSE) {
			return false;
		}
		// TradeTypeConfig tradeType =
		// DataDoc.getInstance().getCfdTradeTypeConfig();
		// if (tradeType == null || tradeType.getIsTradeable() ==
		// MTP4CommDataInterface.FALSE) {
		// return false;
		// }
		GroupConfig groupCfg = DataDoc.getInstance().getGroup();
		if (groupCfg == null
				|| groupCfg.getIsTradeable() == MTP4CommDataInterface.FALSE) {
			return false;
		}
		AccountStore accountStore = DataDoc.getInstance().getAccountStore();
		if (accountStore == null
				|| accountStore.getStrategy().getIsDead() == MTP4CommDataInterface.TRUE
				|| accountStore.getStrategy().getIsTradeable() == MTP4CommDataInterface.FALSE) {
			return false;
		}
		return true;
	}

	/**
	 * 得到某一个用户，指定商品的最大开仓Lot数
	 * 
	 * @param group
	 * @param account
	 * @param instrument
	 * @return
	 */
	public static int getMaxLots(String instrument) {
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);
		if (instrumentNode == null) {
			return -1;
		}
		if (instrumentNode.getAccount_maxLots() > 0) {
			return instrumentNode.getAccount_maxLots();
		}
		if (instrumentNode.getGroup_maxLots() > 0) {
			return instrumentNode.getGroup_maxLots();
		}
		return instrumentNode.getMaxLots();
	}

	/**
	 * 得到某一个用户最小开仓量
	 * 
	 * @param group
	 * @param account
	 * @param instrument
	 * @return
	 */
	public static double getMinLots(String instrument) {
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);
		if (instrumentNode == null) {
			return -1;
		}
		if (instrumentNode.getAccount_minLots() > 0) {
			return instrumentNode.getAccount_minLots();
		}
		if (instrumentNode.getGroup_minLots() > 0) {
			return instrumentNode.getGroup_minLots();
		}
		return instrumentNode.getMinLots();
	}

	public static double exchangeToBalanceMoney(String instrumentCurrency,
			double money, String balanceCurrency) {
		if (instrumentCurrency.equals(balanceCurrency)) {
			return money;
		}
		BalanceUtil util;
		try {
			util = BalanceUtil.newInstance(instrumentCurrency, balanceCurrency);
			return util.getBalanceMoney(money);
		} catch (Exception e) {
			e.printStackTrace();
			return money;
		}

	}

	public static boolean isLotsLegal(String instrument, double lots) {
		double maxLots = getMaxLots(instrument);
		if (lots - maxLots > 0.00001) {
			return false;
		}
		double minLots = getMinLots(instrument);
		int tempi = (int) ((lots + 0.00001) / minLots);
		double left = Math.abs(lots - tempi * minLots);
		if (left < 0.00001) {
			return true;
		} else if (Math.abs(left - minLots) < 0.00001) {
			return true;
		} else {
			return false;
		}
	}

	public static double formatPrice(double oriPrice, String instrument) {
		Instrument inst = DataDoc.getInstance().getInstrument(instrument);
		return formatPrice(oriPrice, inst);
	}

	public static double formatPrice(double oriPrice, Instrument instrument) {
		if (instrument == null) {
			return oriPrice;
		}
		return DataUtil.roundDouble(oriPrice, instrument.getDigits()
				+ instrument.getExtraDigit());
	}

	public static boolean isInstrumentVisable(String group, Long account,
			String instrument) {
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);
		if (instrumentNode == null)
			return false;
		if (instrumentNode.getIsVisable() == MTP4CommDataInterface.FALSE)
			return false;
		// InstrumentsGroupCfg igc =
		// DataDoc.getInstance().getInstrumentGroupCfg(group, instrument);
		if (instrumentNode.getGroup_isVisable() == MTP4CommDataInterface.FALSE)
			return false;
		// InstrumentsAccountCfg icc =
		// DataDoc.getInstance().getInstrumentAccountCfg(account, instrument);
		return instrumentNode.getAccount_isVisable() != MTP4CommDataInterface.FALSE;
	}

	public static double getOpenMarginPercentage(String group, Long account,
			String instrument) {

		// double perc = 0.0D;
		Instrument inst = DataDoc.getInstance().getInstrument(instrument);

		if (inst.getAccount() > 0) {
			if (inst.getAccount_openMarginPercentage() >= 0) {
				return inst.getAccount_openMarginPercentage();
			}
		}
		if (inst.getGroupName() != null) {
			if (inst.getGroup_openMarginPercentage() >= 0) {
				return inst.getGroup_openMarginPercentage();
			}
		}
		// perc = inst.getAccount_openMarginPercentage();
		// if (perc > 9.9999999999999995E-007D)
		// return perc;
		//
		// perc = inst.getGroup_openMarginPercentage();
		// if (perc > 9.9999999999999995E-007D)
		// return perc;

		return inst.getOpenMarginPercentage();
	}

	public static boolean isTradableIgnoreQuoteTimeout(String group,
			Long account, String instrument) {

		if (!DocCaptain.isInited())
			return false;

		if (DataDoc.getInstance().getSystemConfig().getCloseStatus() != 1)
			return false;

		// if
		// (!DataDoc.getInstance().isQuoteTradableIgnoreQuoteEnable(instrument))

		// return false;

		// TradeTypeConfig tradeType =
		// DataDoc.getInstance().getCfdTradeTypeConfig();
		//
		// if (tradeType == null || tradeType.getIsTradeable() == 0)
		//
		// return false;

		GroupConfig groupConfig = DataDoc.getInstance().getGroup();
		if (groupConfig.getIsTradeable() == MTP4CommDataInterface.FALSE)

			return false;

		AccountStore accountStore = DataDoc.getInstance().getAccountStore();

		if (accountStore == null || accountStore.getStrategy().getIsDead() == 1
				|| accountStore.getStrategy().getIsTradeable() == 0)

			return false;

		Instrument inst = DataDoc.getInstance().getInstrument(instrument);

		if (inst.getTradeable() == MTP4CommDataInterface.FALSE
				|| inst.getGroup_tradeable() == MTP4CommDataInterface.FALSE
				|| inst.getAccount_tradeable() == MTP4CommDataInterface.FALSE)
			return false;

		return true;
	}

	/**
	 * @param instrument
	 * @return
	 */
	public static boolean isMarketOpen(String instrument) {
		if (!DocCaptain.isInited()) {
			return false;
		}
		if (DataDoc.getInstance().getSystemConfig().getCloseStatus() != MTP4CommDataInterface.CLOSESTATUS_OPEN) {
			return false;
		}
		// TradeTypeConfig tradeType =
		// DataDoc.getInstance().getCfdTradeTypeConfig();
		// if (tradeType == null || tradeType.getIsTradeable() ==
		// MTP4CommDataInterface.FALSE) {
		// return false;
		// }
		// if (marketClosedInstrument.contains(instrument)) {
		// return false;
		// }
		return true;
	}

	public static boolean isMKTTradeable(String group, Long account,
			String instrument) {

		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);

		if (instrumentNode == null)
			return false;

		if (instrumentNode.getMktTradeable() == MTP4CommDataInterface.FALSE)
			return false;

		if (instrumentNode.getGroup_mktTradeable() == MTP4CommDataInterface.FALSE)
			return false;

		return instrumentNode.getAccount_mktTradeable() != MTP4CommDataInterface.FALSE;
	}

}
