package server.start;

import server.DB.DBOperatorCaptain;
import server.config.ConfigCaptain;
import server.network.client.NetCaptain;
import server.trade.TradeCaptain;

public class ServerContext {
	private static ConfigCaptain configCaptain = new ConfigCaptain();
	private static DBOperatorCaptain DBOperatorCaptain = new DBOperatorCaptain();
	private static TradeCaptain tradeCaptain = new TradeCaptain();
	private static NetCaptain netCaptain = new NetCaptain();

	public static ConfigCaptain getConfigCaptain() {
		return configCaptain;
	}

	public static DBOperatorCaptain getDBOperatorCaptain() {
		return DBOperatorCaptain;
	}

	public static TradeCaptain getTradeCaptain() {
		return tradeCaptain;
	}

	public static NetCaptain getNetCaptain() {
		return netCaptain;
	}
}
