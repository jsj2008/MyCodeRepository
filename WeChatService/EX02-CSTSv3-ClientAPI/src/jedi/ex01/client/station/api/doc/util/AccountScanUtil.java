package jedi.ex01.client.station.api.doc.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import jedi.ex01.CSTS3.comm.struct.GroupConfig;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.MoneyAccount;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.CSTS3.proxy.comm.AccountCapitalStatus;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.BalanceUtil;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.PriceSnapShot;

public class AccountScanUtil {
	// –ﬁ∏¥’ ªß
	public static boolean fixAccount() {
		return fixAccount(false);
	}

	public static boolean fixAccount(boolean forceToScanTrade) {
		try {
			List<TTrade4CFD> tradeList = DataDoc.getInstance().getTradeList();
			return fixAccount(DataDoc.getInstance().getAccountStore(), (TTrade4CFD[]) tradeList.toArray(new TTrade4CFD[0]),
					null, forceToScanTrade);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static boolean fixAccount(AccountStore accountStore, TTrade4CFD[] tradeVector, HashMap priceSnapShotMap,
			boolean forceToScanTrade) {
		synchronized (DataDoc.getInstance().getQuoteLock()) {
			return __fixAccount(accountStore, tradeVector, priceSnapShotMap, forceToScanTrade);
		}
	}

	private static boolean __fixAccount(AccountStore accountStore, TTrade4CFD[] tradeVector, HashMap priceSnapShotMap,
			boolean forceToScanTrade) {
		synchronized (accountStore) {
			if (accountStore == null) {
				return false;
			}
			accountStore.setC_accountCapitalStatus(null);
			GroupConfig groupConfig = DataDoc.getInstance().getGroup();
			Long accountID = Long.valueOf(accountStore.getAccountID());
			boolean isUseFloatMargin2 = groupConfig.getIsFloatMargin2() == MTP4CommDataInterface.TRUE;
			double closeCommission = 0;
			double openCommission = 0;
			try {
				for (int i = 0; i < tradeVector.length; i++) {
					TTrade4CFD temptrade = tradeVector[i];
					if (forceToScanTrade || !temptrade.is_hasBeenFixed()) {
						if (priceSnapShotMap == null || !priceSnapShotMap.containsKey(temptrade.getInstrument())) {
							TradeScanUtil4CFD.fixTrade4CFD(temptrade);
						} else {
							TradeScanUtil4CFD.fixTrade4CFD(temptrade,
									(PriceSnapShot) priceSnapShotMap.get(temptrade.getInstrument()));
						}
					}
				}
				HashMap instrumentInfoMap = new HashMap();
				double totleLots = 0;
				for (int i = 0; i < tradeVector.length; i++) {
					TTrade4CFD trade = (TTrade4CFD) tradeVector[i];
					closeCommission += trade.get_closeCommissionInAccountCurrency();
					openCommission += DocUtil.exchangeToBalanceMoney(trade.getCommision_currency(),
							trade.getCommision_4Open(), accountStore.getBasicCurrency());
					__AccountInstrumentTradeInfoNode aiti = (__AccountInstrumentTradeInfoNode) instrumentInfoMap.get(trade
							.getInstrument());
					if (aiti == null) {
						aiti = new __AccountInstrumentTradeInfoNode();
						aiti.instrument = trade.getInstrument();
						instrumentInfoMap.put(trade.getInstrument(), aiti);
					}
					if (trade.getBuySell() == MTP4CommDataInterface.BUY) {
						aiti.C_openMarginUsed_buy += trade.get_marginOccupied4OpenTrade();
						aiti.C_marginCall1Used_buy += trade.get_marginOccupied4MarginCall1();
						aiti.C_marginCall2Used_buy += trade.get_marginOccupied4MarginCall2();
						aiti.C_liquidationMarginUsed_buy += trade.get_marginOccupied4Liquidation();
						aiti.lots_buy += trade.getLots();
					} else {
						aiti.C_openMarginUsed_sell += trade.get_marginOccupied4OpenTrade();
						aiti.C_marginCall1Used_sell += trade.get_marginOccupied4MarginCall1();
						aiti.C_marginCall2Used_sell += trade.get_marginOccupied4MarginCall2();
						aiti.C_liquidationMarginUsed_sell += trade.get_marginOccupied4Liquidation();
						aiti.lots_sell += trade.getLots();
					}
					aiti.floatPL += trade.get_floatPL();
					aiti.floatRollover += trade.getRollover();
				}
				MoneyAccount maccs[] = accountStore.getMoneyAccounts();
				for (int i = 0; i < maccs.length; i++) {
					MoneyAccount mac = maccs[i];
					mac.set_floatPL(0);
					mac.set_hasBeenFixed(false);
					mac.set_marginOccupied4Liquidation(0);
					mac.set_marginOccupied4MarginCall1(0);
					mac.set_marginOccupied4MarginCall2(0);
					mac.set_marginOccupied4OpenTrade(0);
					mac.set_marginOccupied4OpenTradeLocked(0);
					mac.set_rollover(0);
				}
				Iterator it = instrumentInfoMap.values().iterator();
				while (it.hasNext()) {
					__AccountInstrumentTradeInfoNode aiti = (__AccountInstrumentTradeInfoNode) it.next();
					Instrument instrument = DataDoc.getInstance().getInstrument(aiti.instrument);
					MoneyAccount mac = accountStore.getMoneyAccount(instrument.getCurrencyName());
					mac.set_floatPL(aiti.floatPL + mac.get_floatPL());
					mac.set_rollover(aiti.floatRollover + mac.get_rollover());
					mac.set_marginOccupied4Liquidation(__caculateMarginForOneInstrument(aiti.lots_buy, aiti.lots_sell,
							aiti.C_liquidationMarginUsed_buy, aiti.C_liquidationMarginUsed_sell)
							+ mac.get_marginOccupied4Liquidation());
					_Margin4LockInfoNode margin4LockInfoNode_open = __caculateMarginInfoForOneInstrument(aiti.lots_buy,
							aiti.lots_sell, aiti.C_openMarginUsed_buy, aiti.C_openMarginUsed_sell);
					mac.set_marginOccupied4OpenTrade(margin4LockInfoNode_open.getTotalMargin()
							+ mac.get_marginOccupied4OpenTrade());
					mac.set_marginOccupied4OpenTradeLocked(margin4LockInfoNode_open.lockedMargin
							+ mac.get_marginOccupied4OpenTradeLocked());
					mac.set_marginOccupied4MarginCall1(__caculateMarginForOneInstrument(aiti.lots_buy, aiti.lots_sell,
							aiti.C_marginCall1Used_buy, aiti.C_marginCall1Used_sell) + mac.get_marginOccupied4MarginCall1());
					mac.set_marginOccupied4MarginCall2(__caculateMarginForOneInstrument(aiti.lots_buy, aiti.lots_sell,
							aiti.C_marginCall2Used_buy, aiti.C_marginCall2Used_sell) + mac.get_marginOccupied4MarginCall2());
					mac.set_hasBeenFixed(true);
					totleLots += Math.max(aiti.lots_buy, aiti.lots_sell);
				}

				double C_ownBalance = 0;
				double C_balanceWithMargin2 = 0;
				double C_floatPL = 0;
				double C_floatRollover = 0;
				double C_equity = 0;
				double C_openMarginUsed = 0;
				double C_openMarginUsedLocked = 0;
				double C_marginCall1Used = 0;
				double C_marginCall2Used = 0;
				double C_liquidationMarginUsed = 0;
				double C_margin2 = 0;
				double C_freeze = 0;
				maccs = accountStore.getMoneyAccounts();
				for (int i = 0; i < maccs.length; i++) {
					MoneyAccount mac = maccs[i];
					double balance = 0;
					double ownBalance = 0;
					ownBalance = mac.getBeginBalance() + mac.getCharge() + mac.getAdjust() + mac.getCommision()
							+ mac.getDeposit() + mac.getRollover() + mac.getTradePL() + mac.getTransfer()
							+ mac.getWithdraw() + mac.getOther();
					balance = ownBalance + mac.getMargin2();
					C_balanceWithMargin2 += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(), balance,
							accountStore.getBasicCurrency());
					C_ownBalance += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(), ownBalance,
							accountStore.getBasicCurrency());
					C_margin2 += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(), mac.getMargin2(),
							accountStore.getBasicCurrency());
					C_floatPL += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(), mac.get_floatPL(),
							accountStore.getBasicCurrency());

					C_floatRollover += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(), mac.get_rollover(),
							accountStore.getBasicCurrency());

					C_openMarginUsed += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(),
							mac.get_marginOccupied4OpenTrade(), accountStore.getBasicCurrency());
					C_openMarginUsedLocked += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(),
							mac.get_marginOccupied4OpenTradeLocked(), accountStore.getBasicCurrency());
					C_marginCall1Used += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(),
							mac.get_marginOccupied4MarginCall1(), accountStore.getBasicCurrency());

					C_marginCall2Used += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(),
							mac.get_marginOccupied4MarginCall2(), accountStore.getBasicCurrency());

					C_liquidationMarginUsed += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(),
							mac.get_marginOccupied4Liquidation(), accountStore.getBasicCurrency());
					C_freeze += DocUtil.exchangeToBalanceMoney(mac.getCurrencyName(), mac.getFreeze(),
							accountStore.getBasicCurrency());
				}
				if (isUseFloatMargin2) {
					C_margin2 = (C_ownBalance + C_floatPL + C_floatRollover) * Math.max(0, groupConfig.getMargin2Times());
					C_balanceWithMargin2 = C_ownBalance + C_margin2;
				}
				C_equity = C_balanceWithMargin2 + C_floatPL + C_floatRollover;
				accountStore.setC_balance(C_balanceWithMargin2);
				accountStore.setC_floatPL(C_floatPL);
				accountStore.setC_floatRollover(C_floatRollover);
				accountStore.setC_equity(C_equity);
				accountStore.setC_margin2(C_margin2);
				accountStore.setC_openMarginUsed(C_openMarginUsed);
				accountStore.setC_marginOccupied4OpenTradeLocked(C_openMarginUsedLocked);
				accountStore.setC_marginCall1Used(C_marginCall1Used);
				accountStore.setC_marginCall2Used(C_marginCall2Used);
				accountStore.setC_liquidationMarginUsed(C_liquidationMarginUsed);
				accountStore.setC_totleLots(totleLots);
				accountStore.setC_freeze(C_freeze);
				accountStore.setC_closeCommission(closeCommission);
				accountStore.setC_openCommission(openCommission);
				accountStore.setC_accountCapitalStatus(AccountCapitalStatusUtil.caculateAccountCapticalStatus(accountStore,
						tradeVector, 0));
				accountStore.set_hasBeenFixed(true);
				return true;
			} catch (Exception e) {
				accountStore.set_hasBeenFixed(false);
				e.printStackTrace();
				return false;
			}
		}
		// }
	}

	private static _Margin4LockInfoNode __caculateMarginInfoForOneInstrument(double lotsBuy, double lotsSell,
			double marginBuy, double marginSell) {
		double scale = DataDoc.getInstance().getSystemConfig().getHedgedMarginScale();
		if (scale < 0.1) {
			scale = 1;
		}
		double lockedLots = Math.min(lotsBuy, lotsSell);
		double lockedMargin4Buy;
		if (lotsBuy < 0.001) {
			lockedMargin4Buy = 0;
		} else {
			lockedMargin4Buy = (lockedLots / lotsBuy) * marginBuy;
		}
		double lockedMargin4Sell;
		if (lotsSell < 0.001) {
			lockedMargin4Sell = 0;
		} else {
			lockedMargin4Sell = (lockedLots / lotsSell) * marginSell;
		}
		double leftMargin4Buy = marginBuy - lockedMargin4Buy;
		double leftMargin4Sell = marginSell - lockedMargin4Sell;
		_Margin4LockInfoNode mlin = new _Margin4LockInfoNode(leftMargin4Buy + leftMargin4Sell,
				(lockedMargin4Sell + lockedMargin4Buy) / 2.0 * scale);
		return mlin;

	}

	private static double __caculateMarginForOneInstrument(double lotsBuy, double lotsSell, double marginBuy,
			double marginSell) {
		_Margin4LockInfoNode node = __caculateMarginInfoForOneInstrument(lotsBuy, lotsSell, marginBuy, marginSell);
		return node.getTotalMargin();
	}

	public static boolean isMarginEnough_forLiquidation(AccountStore accountStore) {
		double risk = Math.max(accountStore.getC_accountCapitalStatus().getVar_risk_L_1(), accountStore
				.getC_accountCapitalStatus().getVar_risk_L_2());
		return risk < 1.0 - Double.MIN_VALUE;
	}

	public static boolean isMarginEnough_forMarginCall1(AccountStore accountStore) {
		double risk = Math.max(accountStore.getC_accountCapitalStatus().getVar_risk_C1_1(), accountStore
				.getC_accountCapitalStatus().getVar_risk_C1_2());
		return risk < 1.0 - 0.00000001;
	}

	public static boolean isMarginEnough_forMarginCall2(AccountStore accountStore) {
		double risk = Math.max(accountStore.getC_accountCapitalStatus().getVar_risk_C2_1(), accountStore
				.getC_accountCapitalStatus().getVar_risk_C2_2());
		return risk < 1.0 - 0.00000001;
	}

	public static boolean isMarginEnough_forOpen(TTrade4CFD temptrade, AccountStore accountStore, TTrade4CFD tradeVec[])
			throws Exception {
		double otherFreezeMoney = 0;
		if (temptrade != null
				&& DataDoc.getInstance().getSystemConfig().getIsMarginUsedIncludeComm() == MTP4CommDataInterface.TRUE) {
			BalanceUtil balanceUtil = BalanceUtil.newInstance(temptrade.getCommision_currency(),
					accountStore.getBasicCurrency());
			otherFreezeMoney = balanceUtil.getBalanceMoney(temptrade.getCommision_4Open());
		}
		AccountCapitalStatus acs = AccountCapitalStatusUtil.caculateAccountCapticalStatus(accountStore, tradeVec,
				otherFreezeMoney);
		double risk = Math.max(acs.getVar_risk_O_1(), acs.getVar_risk_O_2());
		return risk < 1.0 - 0.00000001;
	}
}

class __AccountInstrumentTradeInfoNode {
	String instrument;
	double C_openMarginUsed_buy;
	double C_marginCall1Used_buy;
	double C_marginCall2Used_buy;
	double C_liquidationMarginUsed_buy;
	double C_openMarginUsed_sell;
	double C_marginCall1Used_sell;
	double C_marginCall2Used_sell;
	double C_liquidationMarginUsed_sell;
	double floatPL;
	double floatRollover;
	double lots_buy;
	double lots_sell;
}

class _Margin4LockInfoNode {
	double unlockedMargin;
	double lockedMargin;

	_Margin4LockInfoNode(double unlockedMargin, double lockedMargin) {
		this.unlockedMargin = unlockedMargin;
		this.lockedMargin = lockedMargin;
	}

	double getTotalMargin() {
		return unlockedMargin + lockedMargin;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("Per=");
		sb.append(lockedMargin / (lockedMargin + unlockedMargin));
		sb.append(" ; ");
		sb.append("Locked=");
		sb.append(lockedMargin);
		sb.append(" ; ");
		sb.append("Unlocked=");
		sb.append(unlockedMargin);
		return sb.toString();
	}
}
