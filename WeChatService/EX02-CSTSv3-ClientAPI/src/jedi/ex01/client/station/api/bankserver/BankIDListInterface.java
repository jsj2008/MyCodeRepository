package jedi.ex01.client.station.api.bankserver;

/**
 * �?��是一家银行一个ID，即使这个银行有多种接口，最好是单独在GATEWAY里定义，不要在SERVER里定义�?
 * 
 * @author admin
 * 
 */
public interface BankIDListInterface {

	/**
	 * 银行占位符，不代表任何银�?
	 */
	String BANK_NONE = "NONE";
	/**
	 * 华夏银行
	 */
	String BANK_HXB = "HXB";
	/**
	 * 华夏超级网银
	 */
	String BANK_HXSB = "HXSB";
	/**
	 * 农业银行
	 */
	String BANK_ABCHINA = "ABC";
	/**
	 * 建设银行
	 */
	String BANK_CCB = "CCB";
	/**
	 * 国付�?
	 */
	String BANK_GOPAY = "GOPAY";
	/**
	 * 通联代收付�?网关
	 */
	String BANK_AIP = "AIP";
	/**
	 * 中国银行
	 */
	String BANK_BOC = "BOC";
	/**
	 * 广州银联
	 */
	String BANK_ELINK = "ELINK";
	/**
	 * 工商银行
	 */
	String BANK_ICBC = "ICBC";
	/**
	 * 兴业银行
	 */
	String BANK_CIB = "CIB";
	/**
	 * 联动优势
	 */
	String BANK_UMP = "UMP";
	/**
	 * 易极�?
	 */
	String BANK_YJF = "YJF";
	/**
	 * 易极付（资金存管模式�?
	 */
	String BANK_YIJI = "YIJI";
	/**
	 * 人工转账
	 */
	String BANK_MANUAL = "MANUAL";
	/**
	 * 光大银行
	 */
	String BANK_CEB = "CEB";
	/**
	 * 湖北银联
	 */
	String BANK_ELINK_HB = "ELINK_HB";

	/**
	 * 盛付�?+ 通联
	 */
	String BANK_SHENGPAY_AIP = "SHENGPAY_AIP";

	/**
	 * 中信银行
	 */
	String BANK_CITIC = "CITIC";

	/**
	 * 上海银联
	 */
	String BANK_ELINK_SH = "ELINK_SH";
	/**
	 * 虚拟银行
	 */
	String BANK_VIRTUAL = "VIRTUAL";
	/**
	 * 嘉联支付
	 */
	String BANK_JL = "JL";
	/**
	 * 平安银行
	 */
	String BANK_PINGAN = "PINGAN";
	/**
	 * 银行列表数组
	 */
	String[] BANK_VEC = { BANK_HXB, BANK_HXSB, BANK_ABCHINA, BANK_CCB, BANK_GOPAY, BANK_AIP, BANK_BOC, BANK_ELINK,
			BANK_ICBC, BANK_CIB, BANK_UMP, BANK_YJF, BANK_YIJI, BANK_MANUAL, BANK_CEB, BANK_ELINK_HB,
			BANK_SHENGPAY_AIP, BANK_CITIC, BANK_ELINK_SH, BANK_VIRTUAL,BANK_JL,BANK_PINGAN };

}
