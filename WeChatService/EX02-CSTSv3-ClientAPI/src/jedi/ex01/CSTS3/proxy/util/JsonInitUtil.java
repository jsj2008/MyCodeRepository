package jedi.ex01.CSTS3.proxy.util;

import java.util.TimeZone;

import allone.json.JsonFactory;

public class JsonInitUtil {

	public static boolean init() {

		// *****************出入金相关类***2016年8月2日14:53:15***************
		JsonFactory.initClass("IP_BankServ1001",
				jedi.ex01.CSTS3.comm.ipop.IP_BankServ1001.class);
		JsonFactory.initClass("OP_BankServ1001",
				jedi.ex01.CSTS3.comm.ipop.OP_BankServ1001.class);

		JsonFactory.initClass("IP_BankServ2001",
				jedi.ex01.CSTS3.comm.ipop.IP_BankServ2001.class);
		JsonFactory.initClass("OP_BankServ2001",
				jedi.ex01.CSTS3.comm.ipop.OP_BankServ2001.class);

		JsonFactory.initClass("IP_BankServ2012",
				jedi.ex01.CSTS3.comm.ipop.IP_BankServ2012.class);
		JsonFactory.initClass("OP_BankServ2012",
				jedi.ex01.CSTS3.comm.ipop.OP_BankServ2012.class);

		JsonFactory.initClass("IP_TRADESERV3001",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV3001.class);
		JsonFactory.initClass("OP_TRADESERV3001",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV3001.class);

		JsonFactory.initClass("IP_BankServ2011",
				jedi.ex01.CSTS3.comm.ipop.IP_BankServ2011.class);
		JsonFactory.initClass("OP_BankServ2011",
				jedi.ex01.CSTS3.comm.ipop.OP_BankServ2011.class);

		JsonFactory.initClass("35",
				jedi.ex01.CSTS3.comm.struct.UserBankProfile.class);
		JsonFactory.initClass("36",
				jedi.ex01.CSTS3.comm.struct.UserBankProfileStream.class);
		// *************************************************************

		JsonFactory.initClass("31", jedi.ex01.CSTS3.comm.struct.TikValue.class);
		JsonFactory.initClass("28",
				jedi.ex01.CSTS3.comm.struct.AccountFundDeposit.class);
		JsonFactory.initClass("22",
				jedi.ex01.CSTS3.comm.struct.TOrders4CFD.class);
		JsonFactory
				.initClass("18", jedi.ex01.CSTS3.comm.struct.QuoteData.class);
		JsonFactory.initClass("19",
				jedi.ex01.CSTS3.comm.struct.QuoteSizeData.class);
		JsonFactory.initClass("9",
				jedi.ex01.CSTS3.comm.struct.InstrumentType.class);
		JsonFactory.initClass("33",
				jedi.ex01.CSTS3.comm.struct.ClosedPositionsDetails.class);
		JsonFactory.initClass("32",
				jedi.ex01.CSTS3.comm.struct.MoneyAccountStream.class);
		JsonFactory.initClass("13",
				jedi.ex01.CSTS3.comm.struct.MarginCall.class);
		JsonFactory.initClass("6",
				jedi.ex01.CSTS3.comm.struct.GroupConfig.class);
		JsonFactory.initClass("4",
				jedi.ex01.CSTS3.comm.struct.BasicCurrency.class);
		JsonFactory.initClass("34",
				jedi.ex01.CSTS3.comm.struct.MoneyAccountStreamDetails.class);
		JsonFactory.initClass("1",
				jedi.ex01.CSTS3.comm.struct.AccountShortInfo.class);
		JsonFactory.initClass("20",
				jedi.ex01.CSTS3.comm.struct.SystemConfig.class);
		JsonFactory.initClass("30",
				jedi.ex01.CSTS3.comm.struct.HistoricData.class);
		JsonFactory.initClass("21",
				jedi.ex01.CSTS3.comm.struct.TOrderHis4CFD.class);
		JsonFactory
				.initClass("26", jedi.ex01.CSTS3.comm.struct.UserLogin.class);
		JsonFactory.initClass("10",
				jedi.ex01.CSTS3.comm.struct.InstTypeTree.class);
		JsonFactory.initClass("27",
				jedi.ex01.CSTS3.comm.struct.WithdrawApplication.class);
		JsonFactory.initClass("24",
				jedi.ex01.CSTS3.comm.struct.TSettled4CFD.class);
		JsonFactory.initClass("8",
				jedi.ex01.CSTS3.comm.struct.InstrumentLanguage.class);
		JsonFactory.initClass("16",
				jedi.ex01.CSTS3.comm.struct.OtherClientConfig.class);
		JsonFactory.initClass("15",
				jedi.ex01.CSTS3.comm.struct.MoneyAccount.class);
		JsonFactory.initClass("17",
				jedi.ex01.CSTS3.comm.struct.PriceWarning.class);
		JsonFactory.initClass("25",
				jedi.ex01.CSTS3.comm.struct.TTrade4CFD.class);
		JsonFactory.initClass("14",
				jedi.ex01.CSTS3.comm.struct.MessageToAccount.class);
		// JsonFactory.initClass("23",jedi.v7.CSTS3.comm.struct.TradeTypeConfig.class);
		JsonFactory.initClass("5",
				jedi.ex01.CSTS3.comm.struct.BatchRateGap.class);
		JsonFactory.initClass("29",
				jedi.ex01.CSTS3.comm.struct.FundAccountShares.class);
		JsonFactory.initClass("12", jedi.ex01.CSTS3.comm.struct.LangPack.class);
		JsonFactory.initClass("2",
				jedi.ex01.CSTS3.comm.struct.AccountStrategy.class);
		JsonFactory
				.initClass("7", jedi.ex01.CSTS3.comm.struct.Instrument.class);
		JsonFactory.initClass("11",
				jedi.ex01.CSTS3.comm.struct.InstTypeTreeLanguage.class);
		JsonFactory.initClass("3",
				jedi.ex01.CSTS3.comm.struct.BalanceRate.class);

		JsonFactory.initClass("QuoteSizeList",
				jedi.ex01.CSTS3.comm.jsondata.QuoteSizeList.class);
		JsonFactory.initClass("KickOutNode",
				jedi.ex01.CSTS3.comm.jsondata.KickOutNode.class);
		JsonFactory.initClass("QuoteRequest",
				jedi.ex01.CSTS3.comm.jsondata.QuoteRequest.class);
		JsonFactory.initClass("QuoteList",
				jedi.ex01.CSTS3.comm.jsondata.QuoteList.class);
		JsonFactory.initClass("EchoData",
				jedi.ex01.CSTS3.comm.jsondata.EchoData.class);
		JsonFactory.initClass("VolumnRequest",
				jedi.ex01.CSTS3.comm.jsondata.VolumnRequest.class);
		JsonFactory.initClass("KickBySysNode",
				jedi.ex01.CSTS3.comm.jsondata.KickBySysNode.class);
		JsonFactory.initClass("CSTSPing",
				jedi.ex01.CSTS3.comm.jsondata.CSTSPing.class);

		JsonFactory.initClass("Info_TRADESERV1008",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1008.class);
		JsonFactory.initClass("Info_TRADESERV1010",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1010.class);
		JsonFactory.initClass("Info_TRADESERV1006",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1006.class);
		JsonFactory.initClass("Info_TRADESERV1015",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1015.class);
		JsonFactory.initClass("Info_TRADESERV1007",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1007.class);
		JsonFactory.initClass("Info_TRADESERV1016",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1016.class);
		JsonFactory.initClass("Info_TRADESERV1004",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1004.class);
		JsonFactory.initClass("Info_TRADESERV1005",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1005.class);
		JsonFactory.initClass("Info_TRADESERV1011",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1011.class);
		JsonFactory.initClass("Info_TRADESERV1003",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1003.class);
		JsonFactory.initClass("Info_TRADESERV1012",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1012.class);
		JsonFactory.initClass("Info_TRADESERV1013",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1013.class);
		JsonFactory.initClass("Info_TRADESERV1014",
				jedi.ex01.CSTS3.comm.info.Info_TRADESERV1014.class);

		JsonFactory.initClass("OP_TRADESERV5101",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5101.class);
		JsonFactory.initClass("IP_TRADESERV5046",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5046.class);
		JsonFactory.initClass("OP_TRADESERV5102",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5102.class);
		JsonFactory.initClass("OP_TRADESERV5103",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5103.class);
		JsonFactory.initClass("IP_TRADESERV5040",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5040.class);
		JsonFactory.initClass("OP_TRADESERV5046",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5046.class);
		JsonFactory.initClass("OP_TRADESERV5104",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5104.class);
		JsonFactory.initClass("OP_TRADESERV5105",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5105.class);
		JsonFactory.initClass("OP_QG1001",
				jedi.ex01.CSTS3.comm.ipop.OP_QG1001.class);
		JsonFactory.initClass("OP_TRADESERV5106",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5106.class);
		JsonFactory.initClass("OP_TRADESERV5107",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5107.class);
		JsonFactory.initClass("IP_TRADESERV5041",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5041.class);
		JsonFactory.initClass("OP_TRADESERV5041",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5041.class);
		JsonFactory.initClass("IP_TRADESERV5001",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5001.class);
		JsonFactory.initClass("OP_TRADESERV5001",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5001.class);
		JsonFactory.initClass("OP_TRADESERV5040",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5040.class);
		JsonFactory.initClass("OP_TRADESERV5108",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5108.class);
		JsonFactory.initClass("IP_REPORT2901",
				jedi.ex01.CSTS3.comm.ipop.IP_REPORT2901.class);
		JsonFactory.initClass("OP_TRADESERV5010",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5010.class);
		JsonFactory.initClass("IP_REPORT2902",
				jedi.ex01.CSTS3.comm.ipop.IP_REPORT2902.class);
		JsonFactory.initClass("OP_TRADESERV5011",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5011.class);
		JsonFactory.initClass("OP_TRADESERV5111",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5111.class);
		JsonFactory.initClass("OP_Web1001",
				jedi.ex01.CSTS3.comm.ipop.OP_Web1001.class);
		JsonFactory.initClass("OP_TRADESERV5115",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5115.class);
		JsonFactory.initClass("OP_TRADESERV5116",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5116.class);
		JsonFactory.initClass("IP_QDB1002",
				jedi.ex01.CSTS3.comm.ipop.IP_QDB1002.class);
		JsonFactory.initClass("IP_REPORT2101",
				jedi.ex01.CSTS3.comm.ipop.IP_REPORT2101.class);
		JsonFactory.initClass("OP_TRADESERV5018",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5018.class);
		JsonFactory.initClass("IP_TRADESERV5012",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5012.class);
		JsonFactory.initClass("IP_QDB1003",
				jedi.ex01.CSTS3.comm.ipop.IP_QDB1003.class);
		JsonFactory.initClass("OP_TRADESERV5019",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5019.class);
		JsonFactory.initClass("IP_TRADESERV5013",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5013.class);
		JsonFactory.initClass("OP_QDB1004",
				jedi.ex01.CSTS3.comm.ipop.OP_QDB1004.class);
		JsonFactory.initClass("IP_QDB1004",
				jedi.ex01.CSTS3.comm.ipop.IP_QDB1004.class);
		JsonFactory.initClass("IP_TRADESERV5010",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5010.class);
		JsonFactory.initClass("IP_Web1001",
				jedi.ex01.CSTS3.comm.ipop.IP_Web1001.class);
		JsonFactory.initClass("OP_TRADESERV5016",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5016.class);
		JsonFactory.initClass("OP_TRADESERV5017",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5017.class);
		JsonFactory.initClass("IP_TRADESERV5011",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5011.class);
		JsonFactory.initClass("OP_QDB1002",
				jedi.ex01.CSTS3.comm.ipop.OP_QDB1002.class);
		JsonFactory.initClass("IP_TRADESERV5115",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5115.class);
		JsonFactory.initClass("OP_QDB1003",
				jedi.ex01.CSTS3.comm.ipop.OP_QDB1003.class);
		JsonFactory.initClass("IP_TRADESERV5116",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5116.class);
		JsonFactory.initClass("OP_TRADESERV5110",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5110.class);
		JsonFactory.initClass("OP_TRADESERV5015",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5015.class);
		JsonFactory.initClass("OP_TRADESERV5012",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5012.class);
		JsonFactory.initClass("OP_TRADESERV5013",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5013.class);
		JsonFactory.initClass("IP_TRADESERV5015",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5015.class);
		JsonFactory.initClass("OP_TRADESERV5061",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5061.class);
		JsonFactory.initClass("IP_TRADESERV5105",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5105.class);
		JsonFactory.initClass("OP_TRADESERV5062",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5062.class);
		JsonFactory.initClass("IP_TRADESERV5104",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5104.class);
		JsonFactory.initClass("IP_TRADESERV5017",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5017.class);
		JsonFactory.initClass("IP_TRADESERV5103",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5103.class);
		JsonFactory.initClass("IP_TRADESERV5016",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5016.class);
		JsonFactory.initClass("IP_TRADESERV5102",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5102.class);
		JsonFactory.initClass("IP_TRADESERV5019",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5019.class);
		JsonFactory.initClass("IP_TRADESERV5108",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5108.class);
		JsonFactory.initClass("IP_TRADESERV5018",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5018.class);
		JsonFactory.initClass("OP_REPORT2901",
				jedi.ex01.CSTS3.comm.ipop.OP_REPORT2901.class);
		JsonFactory.initClass("IP_TRADESERV5107",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5107.class);
		JsonFactory.initClass("OP_TRADESERV5063",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5063.class);
		JsonFactory.initClass("OP_REPORT2902",
				jedi.ex01.CSTS3.comm.ipop.OP_REPORT2902.class);
		JsonFactory.initClass("IP_TRADESERV5106",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5106.class);
		JsonFactory.initClass("OP_TRADESERV5024",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5024.class);
		JsonFactory.initClass("IP_TRADESERV5062",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5062.class);
		JsonFactory.initClass("IP_TRADESERV5061",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5061.class);
		JsonFactory.initClass("OP_TRADESERV5026",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5026.class);
		JsonFactory.initClass("OP_TRADESERV5025",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5025.class);
		JsonFactory.initClass("IP_TRADESERV5063",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5063.class);
		JsonFactory.initClass("OP_TRADESERV5029",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5029.class);
		JsonFactory.initClass("IP_TRADESERV5111",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5111.class);
		JsonFactory.initClass("IP_TRADESERV5022",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5022.class);
		JsonFactory.initClass("OP_TRADESERV5022",
				jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5022.class);
		JsonFactory.initClass("IP_TRADESERV5110",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5110.class);
		JsonFactory.initClass("IP_TRADESERV5024",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5024.class);
		JsonFactory.initClass("OP_REPORT2101",
				jedi.ex01.CSTS3.comm.ipop.OP_REPORT2101.class);
		JsonFactory.initClass("IP_TRADESERV5026",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5026.class);
		JsonFactory.initClass("IP_TRADESERV5025",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5025.class);
		JsonFactory.initClass("IP_TRADESERV5029",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5029.class);
		JsonFactory.initClass("IP_QG1001",
				jedi.ex01.CSTS3.comm.ipop.IP_QG1001.class);
		JsonFactory.initClass("IP_TRADESERV5101",
				jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5101.class);

		return true;
	}

	public static void main(String[] args) {
		TimeZone tz = TimeZone.getDefault();
		System.out.println(tz.getID());
	}

}
