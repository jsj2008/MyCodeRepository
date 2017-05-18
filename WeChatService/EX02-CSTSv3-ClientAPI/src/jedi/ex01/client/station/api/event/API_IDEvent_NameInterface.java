package jedi.ex01.client.station.api.event;

public interface API_IDEvent_NameInterface {
	
//	String DATA_ON_TRADE_CHANGED = "DATA_ON_TRADE_CHANGED";
//	
	String NAME_TRADERETURN = "NAME_TRADERETURN";
//	
//	String NAME_ON_SYSTEMCONFIG_CHANGED = "NAME_ON_SYSTEMCONFIG_CHANGED";
	String NAME_ON_TSETTLED4CFD_CHANGED = "NAME_ON_TSETTLED4CFD_CHANGED";
	String NAME_ON_NET_LOST = "NAME_ON_NET_LOST";
//	String NAME_ON_DO_RECONNECT="NAME_ON_DO_RECONNECT";
//	String NAME_ON_LOGIN_RESULT="NAME_ON_LOGIN_RESULT";
//	String NAME_ON_CONNECTED="NAME_ON_CONNECTED";
//	String DEBUG_NET_TIMEOUT="DEBUG_NET_TIMEOUT";
//	String DEBUG_NEW_QUOTE="DEBUG_NEW_QUOTE";
//	String DEBUG_INFO="DEBUG_INFO";
//	
	String NAME_ON_DOC_INITED="NAME_ON_DOC_INITED";
//	String NAME_ON_QUOTELIST_INITED="NAME_ON_QUOTELIST_INITED";
	
	
	String OTHER_ON_SYSTEMOPEN = "OTHER_ON_SYSTEMOPEN";
	String OTHER_ON_SYSTEMCLOSE = "OTHER_ON_SYSTEMCLOSE";
	String OTHER_ON_MARGINCALL = "OTHER_ON_MARGINCALL";
	String OTHER_ON_LIQUIDATION = "OTHER_ON_LIQUIDATION";
	String OTHER_ON_KICKOUT = "OTHER_ON_KICKOUT";
	String OTHER_ON_KICK_BY_SYS = "OTHER_ON_KICK_BY_SYS";
	// String OTHER_ON_NETLOST = "OTHER_ON_NETLOST";
	String OTHER_ON_DOC_INITED = "OTHER_ON_DOC_INITED";
	String OTHER_ON_PING = "OTHER_ON_PING";

	String DATA_ON_AccountStategy_Changed = "DATA_ON_AccountStategy_Changed";
	String DATA_ON_MoneyAccount_Changed = "DATA_ON_MoneyAccount_Changed";
	String DATA_ON_InstrumentType_Changed = "DATA_ON_InstrumentType_Changed";
	String DATA_ON_Instrument_Changed = "DATA_ON_Instrument_Changed";
	String DATA_ON_Rollover_Changed = "DATA_ON_Rollover_Changed";
	String DATA_ON_TradeType_Changed = "DATA_ON_TradeType_Changed";
	String DATA_ON_InstrumentGroupCfg_Changed = "DATA_ON_InstrumentGroupCfg_Changed";
	String DATA_ON_InstrumentAccountCfg_Changed = "DATA_ON_InstrumentAccountCfg_Changed";
	String DATA_ON_Order_Changed = "DATA_ON_Order_Changed";
	String DATA_ON_Trade_Changed = "DATA_ON_Trade_Changed";
	String DATA_ON_NewQuote = "DATA_ON_NewQuote";
	String DATA_ON_SimpleNews = "DATA_ON_SimpleNews";
	String DATA_ON_AllData_Changed = "DATA_ON_AllData_Changed";
	String DATA_ON_TradeLogs = "DATA_ON_TradeLogs";
	String DATA_ON_Group_Changed = "DATA_ON_Group_Changed";
	String DATA_ON_SpikeQuote = "DATA_ON_SpikeQuote";
	String DATA_ON_MessageFromUser = "DATA_ON_MessageFromUser";
	String DATA_ON_InstTypeTree_Changed = "DATA_ON_InstTypeTree_Changed";
	String DATA_ON_InstTypeTreeLanguage_Changed = "DATA_ON_InstTypeTreeLanguage_Changed";
	String DATA_ON_InstrumentLanguage_Changed = "DATA_ON_InstrumentLanguage_Changed";
	String DATA_ON_User_Changed = "DATA_ON_User_Changed";
	String DATA_ON_MktOrderHasSendToMarket="DATA_ON_MktOrderHasSendToMarket";
	String DATA_ON_Order_Trade="DATA_ON_Order_Trade";
	String DATA_ON_Liquidation="DATA_ON_Liquidation";
	String DATA_ON_MessageReceive="DATA_ON_MessageReceive";
	String DATA_ON_PriceWarning_Reached="DATA_ON_PriceWarning_Reached";

	// String NAME_ON_SYSTEMCONFIG_CHANGED = "NAME_ON_SYSTEMCONFIG_CHANGED";
	// String NAME_ON_TSETTLED4CFD_CHANGED = "NAME_ON_TSETTLED4CFD_CHANGED";

	String OTHER_ON_NET_LOST = "OTHER_ON_NET_LOST";
	String NAME_ON_DO_RECONNECT = "NAME_ON_DO_RECONNECT";
	String NAME_ON_LOGIN_RESULT = "NAME_ON_LOGIN_RESULT";
	String NAME_ON_CONNECTED = "NAME_ON_CONNECTED";
	String DEBUG_NET_TIMEOUT = "DEBUG_NET_TIMEOUT";
	String DEBUG_NEW_QUOTE = "DEBUG_NEW_QUOTE";
	String DEBUG_INFO = "DEBUG_INFO";

	String NAME_ON_QUOTELIST_INITED = "NAME_ON_QUOTELIST_INITED";
}
