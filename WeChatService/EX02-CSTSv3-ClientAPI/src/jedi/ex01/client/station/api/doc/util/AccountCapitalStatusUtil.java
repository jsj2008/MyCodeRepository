package jedi.ex01.client.station.api.doc.util;

import jedi.ex01.CSTS3.comm.struct.GroupConfig;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.CSTS3.proxy.comm.AccountCapitalStatus;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.DataDoc;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
//////////               AccountCapitalStatus                              //////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
//var_E;//账户的Equity，包含Margin2，扣除所有的冻结资金，同时如果砍仓计算手续费的话，还要扣除手续费
//var_E0;//账户的Equity ，E，不包含Margin2
//var_M2;//Margin2
//var_M_O;//开仓保证金占用
//var_M_c1;//MarginCall1 保证金占用
//var_M_c2;//MarginCall2 保证金占用
//var_M_L;//砍仓保证金占用
//var_M0_O;//开仓保证金中，自有资金至少需要多少
//var_M0_c1;//MarginCall1保证金中，自有资金至少需要多少
//var_M0_c2;//MarginCall2保证金中，自有资金至少需要多少
//var_M0_L;//砍仓保证金中，自有资金至少需要多少
//var_E0_L;//var_M0_L
//var_E0_O;//var_M0_O
//var_E0_c1;//var_M0_c1
//var_E0_c2;//var_M0_c2
//var_delta_E0_O;//自由资金可用保证金（自由净值-开仓保证金中自由资金最小量）
//var_delta_E0_c1;//自由资金可用保证金（自由净值-保证金中自由资金最小量）
//var_delta_E0_c2;//自由资金可用保证金（自由净值-保证金中自由资金最小量）
//var_delta_E0_L;//自由资金可用保证金（自由净值-砍仓保证金中自由资金最小量）
//var_delta_E_1;//目前是0
//var_delta_E_2;//开仓保证金
//var_risk_O_1;
//var_risk_C1_1;
//var_risk_C2_1;
//var_risk_L_1;
//var_risk_O_2;
//var_risk_C1_2;
//var_risk_C2_2;
//var_risk_L_2;
//var_maxMarginSum;
//var_usableMargin_4open;
//var_withdrawableMoney;
//var_risk1_Level;
//var_risk2_Level;
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

public class AccountCapitalStatusUtil {
	public static AccountCapitalStatus caculateAccountCapticalStatus(AccountStore as, TTrade4CFD[] tradeVector,
			double otherFreezeMoney) throws Exception {
		GroupConfig gc = DataDoc.getInstance().getGroup();
		double p = gc.getMargin2Partion();
		AccountCapitalStatus status = new AccountCapitalStatus();
		status.setVar_E(_getE0(as, tradeVector, otherFreezeMoney));

		status.setVar_E0(status.getVar_E() - as.getC_margin2());
		status.setVar_M2(as.getC_margin2());
		status.setVar_M_O(as.getC_openMarginUsed());
		status.setVar_M_c1(as.getC_marginCall1Used());
		status.setVar_M_c2(as.getC_marginCall2Used());
		status.setVar_M_L(as.getC_liquidationMarginUsed());
		status.setVar_M0_O(Math.max(status.getVar_M_O() - status.getVar_M2(), status.getVar_M_O() * (1.0 - p)));
		status.setVar_M0_c1(Math.max(status.getVar_M_c1() - status.getVar_M2(), status.getVar_M_c1() * (1.0 - p)));
		status.setVar_M0_c2(Math.max(status.getVar_M_c2() - status.getVar_M2(), status.getVar_M_c2() * (1.0 - p)));
		status.setVar_M0_L(Math.max(status.getVar_M_L() - status.getVar_M2(), status.getVar_M_L() * (1.0 - p)));

		status.setVar_E0_L(status.getVar_M0_L());
		status.setVar_E0_O(status.getVar_M0_O());
		status.setVar_E0_c1(status.getVar_M0_c1());
		status.setVar_E0_c2(status.getVar_M0_c2());

		status.setVar_delta_E0_O(status.getVar_E0() - status.getVar_E0_O());
		status.setVar_delta_E0_c1(status.getVar_E0() - status.getVar_E0_c1());
		status.setVar_delta_E0_c2(status.getVar_E0() - status.getVar_E0_c2());
		status.setVar_delta_E0_L(status.getVar_E0() - status.getVar_E0_L());
		// status.setVar_delta_E_1(_getDeltaE(as, tradeVector));
		status.setVar_delta_E_2(as.getC_openMarginUsed());

		status.setVar_risk_O_1(caculateRisk(status.getVar_M_O(), status.getVar_delta_E_1(), status.getVar_delta_E0_O()));
		status.setVar_risk_C1_1(caculateRisk(status.getVar_M_c1(), status.getVar_delta_E_1(), status.getVar_delta_E0_c1()));
		status.setVar_risk_C2_1(caculateRisk(status.getVar_M_c2(), status.getVar_delta_E_1(), status.getVar_delta_E0_c2()));
		status.setVar_risk_L_1(caculateRisk(status.getVar_M_L(), status.getVar_delta_E_1(), status.getVar_delta_E0_L()));

		status.setVar_risk_O_2(caculateRisk(status.getVar_M_O(), status.getVar_delta_E_2(), status.getVar_delta_E0_O()));
		status.setVar_risk_C1_2(caculateRisk(status.getVar_M_c1(), status.getVar_delta_E_2(), status.getVar_delta_E0_c1()));
		status.setVar_risk_C2_2(caculateRisk(status.getVar_M_c2(), status.getVar_delta_E_2(), status.getVar_delta_E0_c2()));
		// 如果砍仓保证金设置为0，则用此方法
		if (as.getC_liquidationMarginUsed() < 0.00001 && as.getC_openMarginUsed() > 0.1) {
			status.setVar_risk_L_2(caculateRiskL2IfLiquidationMarginIs0(status.getVar_E0(), as.getC_openMarginUsed()));
		} else {
			status.setVar_risk_L_2(caculateRisk(status.getVar_M_L(), status.getVar_delta_E_2(), status.getVar_delta_E0_L()));
		}
		status.setVar_maxMarginSum(_getMaxMarginSum(status.getVar_E0(), gc.getMargin2Partion(), status.getVar_M2()));
		status.setVar_usableMargin_4open(status.getVar_maxMarginSum() - status.getVar_M_O());
		status.setVar_withdrawableMoney(status.getVar_E0() - status.getVar_E0_O());
		status.setVar_risk1_Level(caculateRiskLevel(status.getVar_risk_O_1(), status.getVar_risk_L_1()));
		status.setVar_risk2_Level(caculateRiskLevel(status.getVar_risk_O_2(), status.getVar_risk_L_2()));
		return status;
	}

	private static double _getMaxMarginSum(double e0, double p, double margin2) {
		double p0 = 1 - p;
		double e0_1 = e0 + margin2;
		if (p0 < 0.00001) {
			return e0_1;
		}
		return Math.min(e0 / p0, e0_1);
	}

	private static double _getE0(AccountStore as, TTrade4CFD[] tradeVector, double otherFreezeMoney) {
		double accountUseableEquity = as.getC_equity() - Math.abs(as.getC_freeze()) - Math.abs(otherFreezeMoney);
		if (DataDoc.getInstance().getSystemConfig().getIsMarginUsedIncludeComm() == MTP4CommDataInterface.TRUE) {
			accountUseableEquity -= Math.abs(as.getC_closeCommission());
		}
		return accountUseableEquity;
	}

	private static double caculateRiskL2IfLiquidationMarginIs0(double userEquity, double openMarginUsed) {
		if (openMarginUsed < 0.0001) {
			return 0;
		}
		if (userEquity < 0) {
			return 1;
		}
		double m = openMarginUsed / 2;
		if (userEquity > m) {
			return 0;
		}
		double g = m - userEquity;
		if (g < 0.0001) {
			return 0;
		}
		return g / m;
	}

	private static double caculateRisk(double marginUsed, double deltaE, double deltaE0) {
		if (marginUsed < 0.000001) {
			return 0;
		}
		if (deltaE < 0.000001) {
			return 0;
		}
		if (deltaE0 < 0.00000001) {
			return 1;
		}

		if (deltaE0 > deltaE - 0.000001) {
			return 0;
		}
		double gap = deltaE - deltaE0;
		return gap / deltaE;
	}

	private static int caculateRiskLevel(double risk_o, double risk_l) {
		int r1 = _caculateRiskLevelForO(risk_o);
		int r2 = _caculateRiskLevelForL(risk_l);
		return Math.max(r1, r2);
	}

	private static int _caculateRiskLevelForO(double risk) {
		if (risk <= 0.1) {
			return AccountCapitalStatus.RISK_LEVEL_SAFE;
		}
		if (risk <= 0.8) {
			return AccountCapitalStatus.RISK_LEVEL_LOW;
		}
		return AccountCapitalStatus.RISK_LEVEL_MID;
	}

	private static int _caculateRiskLevelForL(double risk) {
		if (risk <= 0) {
			return AccountCapitalStatus.RISK_LEVEL_SAFE;
		}
		if (risk <= 0.2) {
			return AccountCapitalStatus.RISK_LEVEL_LOW;
		}
		if (risk <= 0.6) {
			return AccountCapitalStatus.RISK_LEVEL_MID;
		}
		return AccountCapitalStatus.RISK_LEVEL_HIGH;
	}
}
