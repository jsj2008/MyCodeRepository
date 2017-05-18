package jedi.ex01.CSTS3.proxy.comm;

public interface MTP4CommDataInterface {
	/***************************************************************************
	 * int����ֵ��Ĭ��ֵ
	 **************************************************************************/
	int DEFAULT = -1;
	/** ********************************** */
	/** ********************************** */

	/***************************************************************************
	 * ϵͳ������״̬
	 **************************************************************************/
	int CLOSESTATUS_OPEN = 1;
	int CLOSESTATUS_CLOSE = -1;
	int CLOSESTATUS_CLOSING = 0;

	/***************************************************************************
	 * True��False��int��ʾ
	 **************************************************************************/
	int TRUE = 1;
	int FALSE = 0;

	/***************************************************************************
	 * ���ݿ���list���͵ķָ���
	 **************************************************************************/
	String LIST_SEPERATOR = ";";

	/***************************************************************************
	 * �����ո�ʽ��pattern
	 **************************************************************************/
	String PATTERN_TRADEDAY = "yyyy-MM-dd";

	/***************************************************************************
	 * Ӷ����㷽ʽ
	 **************************************************************************/
	int COMMISION_CACULATE_STYLE_MONEYPERLOT = 0;// ÿlot��ȡ�̶�����
	int COMMISION_CACULATE_STYLE_MONEYPERCENTAGE = 1;// ʵ�ʽ����ȡ�̶�����
	int COMMISION_CACULATE_STYLE_BYPRICEGAP = 2;// �Ե�ʽ��ȡ

	/***************************************************************************
	 * ��ͨί�е��ɽ��۹���
	 **************************************************************************/
	int NORMALORDER_PRICESTYLE_ORDERPRICE = 0;// ��ͨί�е��ɽ���Ϊ�û�ָ���۸�
	int NORMALORDER_PRICESTYLE_MKTPRICE = 1;// ��ͨί�е��ɽ���Ϊ��ʱ�г���

	/***************************************************************************
	 * ��ɫ����
	 **************************************************************************/
	int ROLETYPE_SYSTEM = 0;
	int ROLETYPE_DEALER = 1;
	int ROLETYPE_ADMIN = 2;
	int ROLETYPE_UPTRADER = 3;

	int ROLETYPE_USER = 10;
	int ROLETYPE_IB = 11;
	int ROLETYPE_USER_WEB = 12;
	int ROLETYPE_USER_PHONE = 13;
	int ROLETYPE_FUND = 16;

	int ROLETYPE_DEALER_ADMIN = 21;
	int ROLETYPE_DEALER_UPTRADER = 22;
	int ROLETYPE_ADMIN_UPTRADER = 23;
	int ROLETYPE_DEALER_ADMIN_UPTRADER = 24;

	/***************************************************************************
	 * CommandQueue��������
	 **************************************************************************/
	int COMMAND_EXCUTETYPE_CANCEL = 0;
	int COMMAND_EXCUTETYPE_EXCUTED = 1;

	/***************************************************************************
	 * �ʻ�������ʽ����Ϊ���ʻ��ʽ�ķ�ʽ
	 **************************************************************************/
	int ACCOUNT_BALANCE_WAY_REALTIME = 0;
	int ACCOUNT_BALANCE_WAY_DAILY = 1;
	int ACCOUNT_BALANCE_WAY_WEEKLY = 2;
	int ACCOUNT_BALANCE_WAY_MONTHLY = 3;
	int ACCOUNT_BALANCE_WAY_NEVER = 4;

	/***************************************************************************
	 * AccountStream4IB�У��ʽ�仯��Դ
	 **************************************************************************/
	int ACCOUNTSTREAM4IB_MONEYTYPE_BYPOINTS = 0;
	int ACCOUNTSTREAM4IB_MONEYTYPE_BYCOMMISION = 1;

	/***************************************************************************
	 * ���룬����
	 **************************************************************************/
	int BUY = 1;
	int SELL = 0;

	// /*********************************
	// * order��״̬
	// *********************************/
	// int ORDERSTATUS_WAIT=0;
	// int ORDERSTATUS_ACTIVE=1;

	/***************************************************************************
	 * order�����
	 **************************************************************************/
	int ORDERTYPE_MKT = 0;
	int ORDERTYPE_CLOSE_PART_OF_1_TRADE_MKT = 1;
	int ORDERTYPE_NORMAL = 2;
	int ORDERTYPE_CLOSE_N_FIXED_TRADES_MKT = 3;
	int ORDERTYPE_CLOSE_1_FIXED_TRADE_ORDER = 4;
	int ORDERTYPE_HEDGE = 5;
	int ORDERTYPE_LIQUIDATION=6;

	/***************************************************************************
	 * OrderHis reason
	 **************************************************************************/
	int ORDERCLOSEREASON_SUCCEED_QUOTESCAN = 1;
	int ORDERCLOSEREASON_SUCCEED_USERTRADE = 2;
	int ORDERCLOSEREASON_SUCCEED_PHONEORDERTRADE = 3;
	int ORDERCLOSEREASON_SUCCEED_DEALERTRADE = 4;
	int ORDERCLOSEREASON_SUCCEED_DEALERAFFIRM = 5;
	int ORDERCLOSEREASON_SUCCEED_FUNDTRADE = 6;

	int ORDERCLOSEREASON_MODIFY_ByUSER = 11;
	int ORDERCLOSEREASON_MODIFY_ByPHONEORDER = 12;
	int ORDERCLOSEREASON_MODIFY_ByDEALER = 13;
	int ORDERCLOSEREASON_MODIFY_ByFUND = 14;

	int ORDERCLOSEREASON_CANCEL_ByUSER = 21;
	int ORDERCLOSEREASON_CANCEL_ByPHONEORDER = 22;
	int ORDERCLOSEREASON_CANCEL_ByDEALER = 23;
	int ORDERCLOSEREASON_CANCEL_ByTimeOut = 24;
	int ORDERCLOSEREASON_CANCEL_corPositionClosed = 25;
	int ORDERCLOSEREASON_CANCEL_ByFund = 26;

	int ORDERCLOSEREASON_FAILED_OUTOFNOPL = -1;
	int ORDERCLOSEREASON_FAILED_OUTOFPOSITIONLIMIT = -2;
	int ORDERCLOSEREASON_FAILED_MARGINNOTENOUGH = -3;
	int ORDERCLOSEREASON_FAILED_OTHER = -4;
	int ORDERCLOSEREASON_FAILED_PRESELLERR = -5;
	/** ***************************************** */
	/** ***************************************** */

	/***************************************************************************
	 * Order Scan way
	 **************************************************************************/
	int ORDERSCANWAY_COMPAREPRICE = 0;
	int ORDERSCANWAY_PRICETHROUGH = 1;

	/***************************************************************************
	 * order���׵�����
	 **************************************************************************/
	int TRADETYPE_MKT = 0;
	int TRADETYPE_LIMIT = 1;
	int TRADETYPE_STOP = 2;
	int TRADETYPE_MODIFY = -1;
	int TRADETYPE_DELETE = -2;
	int TRADETYPE_FAILED = -3;

	/***************************************************************************
	 * �û����ͣ����ˡ���Ȼ��
	 **************************************************************************/
	int USERTYPE_NORMAL = 1;
	int USERTYPE_CORPORATE = 2;

	/***************************************************************************
	 * �ʻ��ı��¼��ˮ��ԭ��
	 **************************************************************************/
	int ACCOUNTSTREAMTYPE_DEPOSIT = 1;
	int ACCOUNTSTREAMTYPE_WITHDRAW = 2;
	int ACCOUNTSTREAMTYPE_CHARGE = 3;
	int ACCOUNTSTREAMTYPE_ADJUST = 4;
	int ACCOUNTSTREAMTYPE_ROLLOVER = 5;
	int ACCOUNTSTREAMTYPE_COMMISION = 6;
	int ACCOUNTSTREAMTYPE_TRADE = 7;
	int ACCOUNTSTREAMTYPE_TRANSFER = 8;
	int ACCOUNTSTREAMTYPE_IBCHARGE = 9;
	int ACCOUNTSTREAMTYPE_LIQUIDATION = 10;
	int ACCOUNTSTREAMTYPE_MARGIN2 = 11;
	int ACCOUNTSTREAMTYPE_PROMPT = 12;
	int ACCOUNTSTREAMTYPE_FUNDDEPOSIT = 13;
	int ACCOUNTSTREAMTYPE_FUNDWITHDRAW = 14;
	int ACCOUNTSTREAMTYPE_FUNDDIVIDEND = 15;

	/***************************************************************************
	 * �ʻ���ˮ������
	 **************************************************************************/
	int ACCOUNTSTREAM_TTYPE_BATCH = 1;
	int ACCOUNTSTREAM_TTYPE_NORMAL = 2;

	/***************************************************************************
	 * ��λ�رյ�ԭ��
	 **************************************************************************/
	int PSITIONCLOSEREASON_TRADED = 0;
	int PSITIONCLOSEREASON_LIQUIDATION = 1;
	int PSITIONCLOSEREASON_PROMPT = 2;

	/***************************************************************************
	 * margin call �ļ���
	 **************************************************************************/
	int MARGINCALL_LEVEL_1 = 1;
	int MARGINCALL_LEVEL_2 = 2;
	int MARGINCALL_LEVEL_LIQUIDATION = -1;

	/***************************************************************************
	 * OBUDBU
	 **************************************************************************/
	int OBUDBU_OBU = 1;
	int OBUDBU_DBU = 2;

	/***************************************************************************
	 * margin call�ķ�ʽ
	 **************************************************************************/
	int MARGINCALLWAY_NONE = 0;
	int MARGINCALLWAY_CELLPHONEMESSAGE = 1;
	int MARGINCALLWAY_MAIL = 2;
	int MARGINCALLWAY_MAILANDMESSAGE = 3;

	/***************************************************************************
	 * Ĭ��dealer������
	 **************************************************************************/
	String DEALER_SYSTEM = "SYSTEM";

	/***************************************************************************
	 * �������͵�����
	 **************************************************************************/
	String TRADETYPENAME_CFD = "CFD";

	/***************************************************************************
	 * �û���֤���
	 **************************************************************************/
	int USERIDENTIFY_RESULT_SUCCEED = 0;
	int USERIDENTIFY_RESULT_ERR_USER_NOT_FOUND = -1;
	int USERIDENTIFY_RESULT_ERR_PASSWORD_ERR = -2;
	int USERIDENTIFY_RESULT_ERR_USER_LOCKED = -3;
	int USERIDENTIFY_RESULT_ERR_PASSWORD_EXPIRED = -4;
	int USERIDENTIFY_RESULT_ERR_IP_ERR = -5;
	int USERIDENTIFY_RESULT_ERR_UNKNOW = -15;
	int USERIDENTIFY_RESULT_ERR_NETERR = -20;
	int USERIDENTIFY_RESULT_ERR_CADTSERR = -21;

	/***************************************************************************
	 * Ԥ���۸�ȽϷ�ʽ
	 **************************************************************************/
	int ALERTPRICE_COMPAREWAY_BIGGER = 1;
	int ALERTPRICE_COMPAREWAY_SMALLER = 2;

	/***************************************************************************
	 * �۸�����
	 **************************************************************************/
	int PRICETYPE_BID = 1;
	int PRICETYPE_ASK = 2;
	int PRICETYPE_MIDDLE = 3;

	/***************************************************************************
	 * Message����������
	 **************************************************************************/
	int MESSAGE_RECEIVER_TYPE_ACCOUNT = 1;
	int MESSAGE_RECEIVER_TYPE_USER = 2;
	int MESSAGE_RECEIVER_TYPE_GROUP = 3;
	int MESSAGE_RECEIVER_TYPE_IB_SUBACCOUNTS = 4;
	int MESSAGE_RECEIVER_TYPE_ALL = 5;
	int MESSAGE_RECEIVER_TYPE_MESSGERECTYPE = 6;

	/***************************************************************************
	 * Option Right
	 **************************************************************************/
	String OPTION_RIGHT_PUT = "PUT";
	String OPTION_RIGHT_CALL = "CALL";

	/***************************************************************************
	 * SEC TYPE
	 **************************************************************************/
	String SECTYPE_FUTURE = "Future";
	String SECTYPE_OPTION = "Option";
	String SECTYPE_SPOT = "Spot";
	String SECTYPE_CASH = "CASH";

	/***************************************************************************
	 * User Operate type
	 **************************************************************************/
	int USER_OPERATE_TYPE_LOGIN = 0;
	int USER_OPERATE_TYPE_MARKETTRADE = 1;
	int USER_OPERATE_TYPE_ORDERTRADE = 2;
	int USER_OPERATE_TYPE_HEDGETRADE = 3;
	int USER_OPERATE_TYPE_MODIFYORDER = 4;
	int USER_OPERATE_TYPE_DELETEORDER = 5;
	int USER_OPERATE_TYPE_CHANGEPASSWORD = 10;
	int USER_OPERATE_TYPE_CHANGEBALANCEWAY = 11;

	/***************************************************************************
	 * Quote Spread type
	 **************************************************************************/
	int QUOTE_SPREAD_TYPE_NOCHANGE = 0;
	int QUOTE_SPREAD_TYPE_GIVEN = 1;
	int QUOTE_SPREAD_TYPE_ADDTOBID = 2;
	int QUOTE_SPREAD_TYPE_ADDTOASK = 3;
	int QUOTE_SPREAD_TYPE_ADDTOBOTHSIDES = 4;
	int QUOTE_SPREAD_TYPE_RANDOMSPLIT = 5;
	int QUOTE_SPREAD_TYPE_MID2PRICE =6;

	/***************************************************************************
	 * Other client config type
	 **************************************************************************/
	int OTHER_CLIENT_CONFIG_TYPE_LINK = 1;
	int OTHER_CLIENT_CONFIG_TYPE_CONTENT = 2;
	int OTHER_CLIENT_CONFIG_TYPE_VALUE = 3;

	/***************************************************************************
	 * trade log type
	 **************************************************************************/
	int TRADELOG_TYPE_TRADE = 1;
	int TRADELOG_TYPE_ORDER = 2;
	int TRADELOG_TYPE_MARGINCALL = 3;
	int TRADELOG_TYPE_LOGIN = 4;

	/***************************************************************************
	 * trade log ACTION
	 **************************************************************************/
	int TRADELOG_ACTION_TRADE_MKT = 1;
	int TRADELOG_ACTION_TRADE_LIMIT = 2;
	int TRADELOG_ACTION_TRADE_STOP = 3;
	int TRADELOG_ACTION_TRADE_HEDGE = 4;
	int TRADELOG_ACTION_TRADE_FAILED = 5;
	int TRADELOG_ACTION_ORDER_OPEN = 11;
	int TRADELOG_ACTION_ORDER_MODIFY = 12;
	int TRADELOG_ACTION_ORDER_DELETE = 13;
	int TRADELOG_ACTION_ORDER_EXPIRED = 14;
	int TRADELOG_ACTION_ORDER_OPENFAILED = 15;
	int TRADELOG_ACTION_MARGINCALL_LEVEL1 = 21;
	int TRADELOG_ACTION_MARGINCALL_LEVEL2 = 22;
	int TRADELOG_ACTION_MARGINCALL_LEQUIDATION = 23;
	int TRADELOG_ACTION_LOGIN_SUCCEED = 31;
	int TRADELOG_ACTION_LOGIN_FAILED = 32;
	
	int FUND_ORDERPENDING_STATUS_WAIT=1;
	int FUND_ORDERPENDING_STATUS_TRADING=2;
	int FUND_ORDERPENDING_STATUS_SUSPEND=3;
	
	int FUND_PENDING_CLOSEREASON_SUCCED=1;
	int FUND_PENDING_CLOSEREASON_REJECT=2;
	int FUND_PENDING_CLOSEREASON_CANCEL=3;
	
	int FUND_PR_TYPE_PURCHASE=1;
	int FUND_PR_TYPE_REDEMPTION=2;
	
	int FUND_PR_ORDERTYPE_AMOUNT=1;
	int FUND_PR_ORDERTYPE_SHARES=2;
	
	int TTRADEUPTRADEMAP_ACTIONS_OPEN=1;
	int TTRADEUPTRADEMAP_ACTIONS_CLOSE=2;
	
	int TTRADEUPTRADEMAP_REASON_NORMAL=1;
	int TTRADEUPTRADEMAP_REASON_LEQUIDATION=2;
	
	int FUNDACCOUNTSTREAM_TYPE_PURCHASE_REQUISITION=1;
	int FUNDACCOUNTSTREAM_TYPE_REDEMPTION_REQUISITION=2;
	int FUNDACCOUNTSTREAM_TYPE_PURCHASE_FEE=3;
	int FUNDACCOUNTSTREAM_TYPE_REDEMPTION_FEE=4;
	int FUNDACCOUNTSTREAM_TYPE_PURCHASE_TOFUND=5;
	int FUNDACCOUNTSTREAM_TYPE_REDEMPTION_TOUSER=6;
	int FUNDACCOUNTSTREAM_TYPE_DIVIDEND_FROMFUND=7;
	int FUNDACCOUNTSTREAM_TYPE_DIVIDEND_TOUSER=8;
	int FUNDACCOUNTSTREAM_TYPE_DIVIDEND_PURCHASE_REQUISITION=9;
	int FUNDACCOUNTSTREAM_TYPE_DIVIDEND_PURCHASE_TOFUND=10;
	
	int FUNDOTHERINVESTACCOUNTSTREAM_TYPE_DEPOSIT=1;
	int FUNDOTHERINVESTACCOUNTSTREAM_TYPE_WITHDRAW=2;
	int FUNDOTHERINVESTACCOUNTSTREAM_TYPE_EQUITYCHANGE=3;

	int LIQUIDATION_TYPE_AUTO=0;
	int LIQUIDATION_TYPE_BY_DEALER=1;
	
	int FUND_STATUS_WAIT=1;
	int FUND_STATUS_RUNNING=2;
	int FUND_STATUS_END=3;
	
	/***************************************************************************
	 * Withdraw Application
	 **************************************************************************/
	int WITHDRAW_APPLICATION_TYPE_DIPOSIT=1;
	int WITHDRAW_APPLICATION_TYPE_WITHDRAW=0;

	/***************************************************************************
	 * margin type
	 **************************************************************************/
	int MARGINTYPE_PERCENTAGE_BY_MKTPRICE=0;
	int MARGINTYPE_PERCENTAGE_BY_OPENPRICE=1;
	
	/***************************************************************************
	 * Withdraw Application
	 **************************************************************************/
	int INTERESTTYPE_PERCENTAGE=0;
	int INTERESTTYPE_NOCHARGE=1;
	int INTERESTTYPE_FIXED=2;
	
	/***************************************************************************
	 * �����ʻ��ı��¼��ˮ��ԭ��
	 **************************************************************************/
	int FUNDMONEYSTREAMTYPE_DEPOSIT = 1;
	int FUNDMONEYSTREAMTYPE_WITHDRAW = 2;
	int FUNDMONEYSTREAMTYPE_CHARGE = 3;
	int FUNDMONEYSTREAMTYPE_ADJUST = 4;
	int FUNDMONEYSTREAMTYPE_ROLLOVER = 5;
	int FUNDMONEYSTREAMTYPE_COMMISION = 6;
	int FUNDMONEYSTREAMTYPE_TRADE = 7;
	int FUNDMONEYSTREAMTYPE_TRANSFER = 8;
	int FUNDMONEYSTREAMTYPE_IBCHARGE = 9;
	int FUNDMONEYSTREAMTYPE_LIQUIDATION = 10;
	int FUNDMONEYSTREAMTYPE_MARGIN2 = 11;
	int FUNDMONEYSTREAMTYPE_PROMPT = 12;
	int FUNDMONEYSTREAMTYPE_FUNDDEPOSIT = 13;
	int FUNDMONEYSTREAMTYPE_FUNDWITHDRAW = 14; 
	int FUNDMONEYSTREAMTYPE_FUNDINVESTOUT=15;
	int FUNDMONEYSTREAMTYPE_FUNDINVESTBACK=16;
	int FUNDMONEYSTREAMTYPE_EXCHANGEFEES=17;
	int FUNDMONEYSTREAMTYPE_MANAGEMENTFEES=18;
	int FUNDMONEYSTREAMTYPE_FUNDDIVIDEND=19;

	/***************************************************************************
	 * ����ֺ�����
	 **************************************************************************/
	int FUNDDIVIDENDTYPE_CASH=0;
	int FUNDDIVIDENDTYPE_REINVESTMENT=1;
	
	/***************************************************************************
	 * ��������
	 **************************************************************************/
	String UPTRADEBANK_NO_UPTRADE="NO_UPTRADE";
	String UPTRADEBANK_SYSTEM="SYSTEM";
	

	/***************************************************************************
	 * ����ת������
	 **************************************************************************/
	String UPTRADE_FIX_PARAM_MAIN="MAIN";

	/***************************************************************************
	 * ����ת������
	 **************************************************************************/
	int EBANKSTREAM_TYPE_DEPOSIT=1;
	int EBANKSTREAM_TYPE_WITHDRAW=2;

	/***************************************************************************
	 * instrument margin type
	 **************************************************************************/
	int INSTRUMENT_MARGINTYPE_PERCENTAGE=0;
	int INSTRUMENT_MARGINTYPE_FIXED=1;
	
}
