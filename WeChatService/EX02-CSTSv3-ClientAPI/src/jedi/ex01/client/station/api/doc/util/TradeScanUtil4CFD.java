package jedi.ex01.client.station.api.doc.util;

import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.BalanceUtil;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.InstrumentUtil;
import jedi.ex01.client.station.api.doc.PriceSnapShot;

public class TradeScanUtil4CFD {

	/**
	 * 修整Trade4CFD，添加浮动盈亏，并计算4个保证金占用值
	 * 
	 * @param trade
	 * @param shot
	 */
	public static void fixTrade4CFD(TTrade4CFD trade, PriceSnapShot shot) {
		if (!trade.getInstrument().equals(shot.getInstrument())) {
			trade.set_hasBeenFixed(false);
			return;
		}
		// 得到商品
		Instrument instrument = DataDoc.getInstance().getInstrument(trade.getInstrument());
		// 帐号
		// Long accountID = new Long(trade.getAccount());
		// 该商品的数量
		double amount = trade.getLots() * (double) instrument.getAmountPerLot();
		// 计算对应货币的盈亏
		double realPL = shot.caculateRealPL(amount, trade.getOpenPrice(), trade.getBuySell());

		// 先得到4种保证金的占用比例
		double margin_open_per = instrument.getOpenMarginPercentage();
		double margin_MC1_per = instrument.getMarginCall1Percentage();
		double margin_MC2_per = instrument.getMarginCall2Percentage();
		double margin_Liq_per = instrument.getLiquidationMarginPercentage();

		if (instrument.getGroupName() != null) {
			if (instrument.getGroup_openMarginPercentage() >= 0
					&& instrument.getGroup_openMarginPercentage() != MTP4CommDataInterface.DEFAULT) {
				margin_open_per = instrument.getGroup_openMarginPercentage();
			}
			if (instrument.getGroup_marginCall1Percentage() >= 0
					&& instrument.getGroup_marginCall1Percentage() != MTP4CommDataInterface.DEFAULT) {
				margin_MC1_per = instrument.getGroup_marginCall1Percentage();
			}
			if (instrument.getGroup_marginCall2Percentage() >= 0
					&& instrument.getGroup_marginCall2Percentage() != MTP4CommDataInterface.DEFAULT) {
				margin_MC2_per = instrument.getGroup_marginCall2Percentage();
			}
			if (instrument.getGroup_liquidationMarginPercentage() >= 0
					&& instrument.getGroup_liquidationMarginPercentage() != MTP4CommDataInterface.DEFAULT) {
				margin_Liq_per = instrument.getGroup_liquidationMarginPercentage();
			}
		}
		if (instrument.getAccount() > 0) {
			if (instrument.getAccount_openMarginPercentage() >= 0
					&& instrument.getAccount_openMarginPercentage() != MTP4CommDataInterface.DEFAULT) {
				margin_open_per = instrument.getAccount_openMarginPercentage();
			}
			if (instrument.getAccount_marginCall1Percentage() >= 0
					&& instrument.getAccount_marginCall1Percentage() != MTP4CommDataInterface.DEFAULT) {
				margin_MC1_per = instrument.getAccount_marginCall1Percentage();
			}
			if (instrument.getAccount_marginCall2Percentage() >= 0
					&& instrument.getAccount_marginCall2Percentage() != MTP4CommDataInterface.DEFAULT) {
				margin_MC2_per = instrument.getAccount_marginCall2Percentage();
			}
			if (instrument.getAccount_liquidationMarginPercentage() >= 0
					&& instrument.getAccount_liquidationMarginPercentage() != MTP4CommDataInterface.DEFAULT) {
				margin_Liq_per = instrument.getAccount_liquidationMarginPercentage();
			}
		}
		// 计算1:1交易所需的资金
		double totalMargin = 0;
		double priceToCalMargin = 0;
		if (DataDoc.getInstance().getSystemConfig().getMarginType() == MTP4CommDataInterface.MARGINTYPE_PERCENTAGE_BY_OPENPRICE) {
			priceToCalMargin = trade.getOpenPrice();
		} else if (DataDoc.getInstance().getSystemConfig().getMarginType() == MTP4CommDataInterface.MARGINTYPE_PERCENTAGE_BY_MKTPRICE) {
			if (trade.getBuySell() == MTP4CommDataInterface.BUY) {
				priceToCalMargin = shot.getAsk();
			} else {
				priceToCalMargin = shot.getBid();
			}
		} else {
			priceToCalMargin = shot.getAsk();
		}
		totalMargin = trade.getLots() * instrument.getAmountPerLot() * priceToCalMargin;
		trade.set_totalMargin(totalMargin);
		// 计算margin，并记录fix后的数据
		// modified by Sean ,2012/02/27,Margin type added
		if (instrument.getMarginType() == MTP4CommDataInterface.INSTRUMENT_MARGINTYPE_PERCENTAGE) {
			trade.set_marginOccupied4OpenTrade(totalMargin * margin_open_per);
			trade.set_marginOccupied4MarginCall1(totalMargin * margin_MC1_per);
			trade.set_marginOccupied4MarginCall2(totalMargin * margin_MC2_per);
			trade.set_marginOccupied4Liquidation(totalMargin * margin_Liq_per);
		} else if (instrument.getMarginType() == MTP4CommDataInterface.INSTRUMENT_MARGINTYPE_FIXED) {
			trade.set_marginOccupied4OpenTrade(trade.getLots() * margin_open_per);
			trade.set_marginOccupied4MarginCall1(trade.getLots() * margin_MC1_per);
			trade.set_marginOccupied4MarginCall2(trade.getLots() * margin_MC2_per);
			trade.set_marginOccupied4Liquidation(trade.getLots() * margin_Liq_per);
		}
		trade.set_floatPL(realPL);
		try {
			trade.set_closeCommissionInAccountCurrency(_canculateTTradeCloseCommission(trade, shot));
		} catch (Exception e) {
			e.printStackTrace();
			trade.set_hasBeenFixed(false);
			return;
		}
		trade.set_hasBeenFixed(true);
	}

	public static void fixTrade4CFD(TTrade4CFD trade) {
		try {
			InstrumentUtil util = new InstrumentUtil(trade.getInstrument());
			PriceSnapShot shot = util.getPriceSnapShot();
			fixTrade4CFD(trade, shot);
		} catch (Exception e) {
			return;
		}
	}

	private static double _canculateTTradeCloseCommission(TTrade4CFD trade, PriceSnapShot snapShot) throws Exception {
		double lotInTrade = trade.getLots();
		Instrument instrument = DataDoc.getInstance().getInstrument(trade.getInstrument());
		double sub_CloseCommision_system = 0;
		double sub_CloseCommision_group = 0;
		double sub_CloseCommision_account = 0;
		AccountStore as = DataDoc.getInstance().getAccountStore();
		String commisionCurrency = instrument.getCurrencyName();
		if (instrument.getCommCaculateStyle() == MTP4CommDataInterface.COMMISION_CACULATE_STYLE_MONEYPERCENTAGE) {
			double feeSeed = -lotInTrade
					* instrument.getAmountPerLot()
					* snapShot.getTradePrice(trade.getBuySell() == MTP4CommDataInterface.BUY ? MTP4CommDataInterface.SELL
							: MTP4CommDataInterface.BUY);
			sub_CloseCommision_system = Math.min(-instrument.getMinimumCommision4PerCalulate(),
					feeSeed * instrument.getCloseCommision());
			if (instrument.getGroup_closeCommision2Add() > 0) {
				sub_CloseCommision_group = Math.min(-instrument.getMinimumCommision4PerCalulate(),
						feeSeed * instrument.getGroup_closeCommision2Add());
			}
			if (instrument.getAccount_closeCommision2Add() > 0) {
				sub_CloseCommision_account = Math.min(-instrument.getMinimumCommision4PerCalulate(),
						feeSeed * instrument.getAccount_closeCommision2Add());
			}
		} else if (instrument.getCommCaculateStyle() == MTP4CommDataInterface.COMMISION_CACULATE_STYLE_MONEYPERLOT) {
			commisionCurrency = DataDoc.getInstance().getSystemConfig().getBatchCurrency();
			double feeSeed = -lotInTrade;
			sub_CloseCommision_system = feeSeed * instrument.getCloseCommision();
			if (instrument.getGroup_closeCommision2Add() > 0) {
				sub_CloseCommision_group = feeSeed * instrument.getGroup_closeCommision2Add();
			}
			if (instrument.getAccount_closeCommision2Add() > 0) {
				sub_CloseCommision_account = feeSeed * instrument.getAccount_closeCommision2Add();
			}
		} else if (instrument.getCommCaculateStyle() == MTP4CommDataInterface.COMMISION_CACULATE_STYLE_BYPRICEGAP) {
			sub_CloseCommision_system = -lotInTrade * instrument.getAmountPerLot() * instrument.getCloseCommision()
					* Math.pow(10, -instrument.getDigits());
			if (instrument.getGroup_closeCommision2Add() > 0) {
				sub_CloseCommision_group = -lotInTrade * instrument.getAmountPerLot() * instrument.getGroup_closeCommision2Add()
						* Math.pow(10, -instrument.getDigits());
			}
			if (instrument.getAccount_closeCommision2Add() > 0) {
				sub_CloseCommision_account = -lotInTrade * instrument.getAmountPerLot()
						* instrument.getAccount_closeCommision2Add() * Math.pow(10, -instrument.getDigits());
			}
		}
		BalanceUtil balanceUtil = BalanceUtil.newInstance(commisionCurrency, as.getBasicCurrency());
		return balanceUtil.getBalanceMoney(sub_CloseCommision_account + sub_CloseCommision_group + sub_CloseCommision_system);
	}

}
