package allone.MTP.VerBank01.Ctrl.captain;

import allone.MTP.VerBank01.Ctrl.cadts.CADTSCaptain;
import allone.MTP.VerBank01.Ctrl.config.ConfigCaptain;
import allone.MTP.VerBank01.Ctrl.doc.DocCaptain;
import allone.MTP.VerBank01.Ctrl.info.InfoOperatorCaptain;
import allone.MTP.VerBank01.Ctrl.push.send.SendConfig;
import allone.MTP.VerBank01.Ctrl.trade.TradeCaptain;

public class StaticContext {

	private static boolean isDebug = false;
	private static boolean stillRunning = true;

	public static boolean isStillRunning() {
		return stillRunning;
	}

	public static void setStillRunning(boolean stillRunning) {
		StaticContext.stillRunning = stillRunning;
	}

	public static boolean isDebug() {
		return isDebug;
	}

	public static void setDebug(boolean isDebug) {
		StaticContext.isDebug = isDebug;
	}

	private static final TradeCaptain tradeCaptain = new TradeCaptain();

	public static TradeCaptain getTradeCaptain() {
		return tradeCaptain;
	}

	private static final ConfigCaptain configCaptain = new ConfigCaptain();

	public static ConfigCaptain getConfigCaptain() {
		return configCaptain;
	}

	private static final CADTSCaptain cadtsCaptain = new CADTSCaptain();

	public static CADTSCaptain getCadtsCaptain() {
		return cadtsCaptain;
	}

	private static final DocCaptain docCaptain = new DocCaptain();

	public static DocCaptain getDocCaptain() {
		return docCaptain;
	}

	private static final InfoOperatorCaptain infoOperatorCaptain = new InfoOperatorCaptain();

	public static InfoOperatorCaptain getInfoOperatorCaptain() {
		return infoOperatorCaptain;
	}

	private static final SendConfig sendConfig = new SendConfig();

	public static SendConfig getSendConfig() {
		return sendConfig;
	}
}
