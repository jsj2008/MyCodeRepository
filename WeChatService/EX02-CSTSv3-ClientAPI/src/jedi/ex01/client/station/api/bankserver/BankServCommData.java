package jedi.ex01.client.station.api.bankserver;

public interface BankServCommData {

	/**
	 * Gateway前缀
	 */
	String SERV_MTP4_BANKGATEWAY_PRE = "SERV_MTP4_BANKGATEWAY_";

	/**
	 * 来自MTP
	 */
	String ORIGIN_MTP = "MTP";
	/**
	 * 来自银行
	 */
	String ORIGIN_BANK = "BANK";

	// /**
	// * 来自VIP
	// *
	// * author: Wang.jingjing
	// */
	// String ORIGIN_VIP = "VIP";

	/**
	 * 来自交易�?
	 * 
	 * author: Wang.jingjing
	 */
	String ORIGIN_EX = "EX";
	/**
	 * 来自交易�?
	 * 
	 * author: Wang.jingjing
	 */
	String ORIGIN_FUND = "FUND";

	/**
	 * 来源：注册服�?
	 */
	String ORIGIN_REGS = "RS";

	/**
	 * 签约类型
	 */
	String SIGNUPTYPE_SIGNUP = "UP";
	/**
	 * 解约类型
	 */
	String SIGNUPTYPE_SIGNOFF = "OFF";
	/**
	 * 修改签约信息
	 */
	String SIGNUPTYPE_MODIFY = "MOD";
	/**
	 * 存款
	 */
	String ORDERTYPE_DEPOSIT = "A";
	/**
	 * 取款
	 */
	String ORDERTYPE_WITHDRAWAL = "B";
	/**
	 * 资金调整
	 */
	String ORDERTYPE_ADJUST = "C";

	// /**
	// * 普�?用户
	// */
	// int USERTYPE_NORMAL = 0;
	// /**
	// * 经纪会员影子账户
	// */
	// int USERTYPE_OWNER_MTP = 1;
	// /**
	// * 经纪会员佣金账户
	// */
	// int USERTYPE_COMMISSION_MTP = 2;
	//
	// /**
	// * 特级会员影子账户
	// */
	// int USERTYPE_OWNER_VIP = 3;
	// /**
	// * 特级会员佣金账户
	// */
	// int USERTYPE_COMMISSION_VIP = 4;
	// /**
	// * 交易�?��金账�?
	// */
	// int USERTYPE_COMMISSION_EX = 5;
	// /**
	// * MTP
	// */
	// int USERTYPE_MTP = 6;
	// /**
	// * EX
	// */
	// int USERTYPE_EX = 7;
	// /**
	// * Fund
	// */
	// int USERTYPE_FUND = 8;

	int SUCCEED = 1;
	int FAIL = 0;

	String DEPOSIT_URL = "DEPOSIT_URL";
	String CUST_SIGN_INFO = "CUST_SIGN_INFO";
	String USER_DN = "USER_DN";
	String STREAM_ID = "STREAM_ID";
	String CONTRACT_SIGN_ID = "CONTRACT_SIGN_ID";
	String SIGN_RESERVE1 = "SIGN_RESERVE1";
	String SIGN_RESERVE2 = "SIGN_RESERVE2";
	String YIJI_SIGNUP_URL = "url";

}
