package jedi.ex02.CSTS3.server;

import jedi.ex02.CSTS3.server.CADTS.CADTSCaptain;
import jedi.ex02.CSTS3.server.config.CSConfigCaptain;
import jedi.ex02.CSTS3.server.doc.CSTSDoc;
import jedi.ex02.CSTS3.server.infor.InforCaptain;
import jedi.ex02.CSTS3.server.monitor.MonitorCaptain;
import jedi.ex02.CSTS3.server.net.NetCaptain;
import jedi.ex02.CSTS3.server.quoteSource.QuoteSourceCaptain;
import jedi.ex02.CSTS3.server.trade.TradeCaptain;
import jedi.ex02.CSTS3.server.trade4client.ClientTradeCaptain;

public class StaticContext {
	private static CSConfigCaptain configCaptain = new CSConfigCaptain();
	private static CADTSCaptain cADTSCaptain = new CADTSCaptain();
	private static CSTSDoc cSTSDoc = new CSTSDoc();
	private static InforCaptain inforCaptain = new InforCaptain();
	private static TradeCaptain tradeCaptain = new TradeCaptain();
	private static NetCaptain netCaptain = new NetCaptain();
	//2015-7-27 niuqq add monitor
	private static MonitorCaptain monitorCaptain=new MonitorCaptain();
	private static ClientTradeCaptain clientTradeCaptain=new ClientTradeCaptain();
	
	private static QuoteSourceCaptain quoteSourceCaptain = QuoteSourceCaptain.getInstance();
	
	public static NetCaptain getNetCaptain() {
		return netCaptain;
	}

	public static CSTSDoc getCSTSDoc() {
		return cSTSDoc;
	}

	public static InforCaptain getInforCaptain() {
		return inforCaptain;
	}

	public static TradeCaptain getTradeCaptain() {
		return tradeCaptain;
	}

	public static CSConfigCaptain getCSConfigCaptain() {
		return configCaptain;
	}

	public static CADTSCaptain getCADTSCaptain() {
		return cADTSCaptain;
	}

	public static MonitorCaptain getMonitorCaptain() {
		return monitorCaptain;
	}

	public static ClientTradeCaptain getClientTradeCaptain() {
		return clientTradeCaptain;
	}

	public static QuoteSourceCaptain getQuoteSourceCaptain() {
		return quoteSourceCaptain;
	}
}
