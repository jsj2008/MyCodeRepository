package jedi.ex01.CSTS3.proxy.comm;

import java.io.Serializable;

public class AccountCapitalStatus implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1648030054384910711L;
	public final static int RISK_LEVEL_SAFE=0;
	public final static int RISK_LEVEL_LOW=1;
	public final static int RISK_LEVEL_MID=2;
	public final static int RISK_LEVEL_HIGH=3;
	
	private transient double var_E;
	private transient double var_E0;
	private transient double var_M2;
	private transient double var_M_O;
	private transient double var_M_c1;
	private transient double var_M_c2;
	private transient double var_M_L;
	private transient double var_M0_O;
	private transient double var_M0_c1;
	private transient double var_M0_c2;
	private transient double var_M0_L;
	private transient double var_E0_L;
	private transient double var_E0_O;
	private transient double var_E0_c1;
	private transient double var_E0_c2;
	private transient double var_delta_E0_O;
	private transient double var_delta_E0_c1;
	private transient double var_delta_E0_c2;
	private transient double var_delta_E0_L;
	private transient double var_delta_E_1;
	private transient double var_delta_E_2;

	private transient double var_risk_O_1;
	private transient double var_risk_C1_1;
	private transient double var_risk_C2_1;
	private transient double var_risk_L_1;
	private transient double var_risk_O_2;
	private transient double var_risk_C1_2;
	private transient double var_risk_C2_2;
	private transient double var_risk_L_2;
	
	private transient double var_maxMarginSum;
	private transient double var_usableMargin_4open;
	private transient double var_withdrawableMoney;
	
	private transient int var_risk1_Level;
	private transient int var_risk2_Level;

	public double getVar_E() {
		return var_E;
	}

	public void setVar_E(double var_E) {
		this.var_E = var_E;
	}

	public double getVar_E0() {
		return var_E0;
	}

	public void setVar_E0(double var_E0) {
		this.var_E0 = var_E0;
	}

	public double getVar_M2() {
		return var_M2;
	}

	public void setVar_M2(double var_M2) {
		this.var_M2 = var_M2;
	}

	public double getVar_M_O() {
		return var_M_O;
	}

	public void setVar_M_O(double var_M_O) {
		this.var_M_O = var_M_O;
	}

	public double getVar_M_c1() {
		return var_M_c1;
	}

	public void setVar_M_c1(double var_M_c1) {
		this.var_M_c1 = var_M_c1;
	}

	public double getVar_M_c2() {
		return var_M_c2;
	}

	public void setVar_M_c2(double var_M_c2) {
		this.var_M_c2 = var_M_c2;
	}

	public double getVar_M_L() {
		return var_M_L;
	}

	public void setVar_M_L(double var_M_L) {
		this.var_M_L = var_M_L;
	}

	public double getVar_M0_O() {
		return var_M0_O;
	}

	public void setVar_M0_O(double var_M0_O) {
		this.var_M0_O = var_M0_O;
	}

	public double getVar_M0_c1() {
		return var_M0_c1;
	}

	public void setVar_M0_c1(double var_M0_c1) {
		this.var_M0_c1 = var_M0_c1;
	}

	public double getVar_M0_c2() {
		return var_M0_c2;
	}

	public void setVar_M0_c2(double var_M0_c2) {
		this.var_M0_c2 = var_M0_c2;
	}

	public double getVar_M0_L() {
		return var_M0_L;
	}

	public void setVar_M0_L(double var_M0_L) {
		this.var_M0_L = var_M0_L;
	}

	public double getVar_E0_L() {
		return var_E0_L;
	}

	public void setVar_E0_L(double var_E0_L) {
		this.var_E0_L = var_E0_L;
	}

	public double getVar_E0_O() {
		return var_E0_O;
	}

	public void setVar_E0_O(double var_E0_O) {
		this.var_E0_O = var_E0_O;
	}

	public double getVar_E0_c1() {
		return var_E0_c1;
	}

	public void setVar_E0_c1(double var_E0_c1) {
		this.var_E0_c1 = var_E0_c1;
	}

	public double getVar_E0_c2() {
		return var_E0_c2;
	}

	public void setVar_E0_c2(double var_E0_c2) {
		this.var_E0_c2 = var_E0_c2;
	}

	public double getVar_delta_E0_O() {
		return var_delta_E0_O;
	}

	public void setVar_delta_E0_O(double var_delta_E0_O) {
		this.var_delta_E0_O = var_delta_E0_O;
	}

	public double getVar_delta_E0_c1() {
		return var_delta_E0_c1;
	}

	public void setVar_delta_E0_c1(double var_delta_E0_c1) {
		this.var_delta_E0_c1 = var_delta_E0_c1;
	}

	public double getVar_delta_E0_c2() {
		return var_delta_E0_c2;
	}

	public void setVar_delta_E0_c2(double var_delta_E0_c2) {
		this.var_delta_E0_c2 = var_delta_E0_c2;
	}

	public double getVar_delta_E0_L() {
		return var_delta_E0_L;
	}

	public void setVar_delta_E0_L(double var_delta_E0_L) {
		this.var_delta_E0_L = var_delta_E0_L;
	}

	public double getVar_delta_E_1() {
		return var_delta_E_1;
	}

	public void setVar_delta_E_1(double var_delta_E_1) {
		this.var_delta_E_1 = var_delta_E_1;
	}

	public double getVar_delta_E_2() {
		return var_delta_E_2;
	}

	public void setVar_delta_E_2(double var_delta_E_2) {
		this.var_delta_E_2 = var_delta_E_2;
	}

	public double getVar_risk_O_1() {
		return var_risk_O_1;
	}

	public void setVar_risk_O_1(double var_risk_O_1) {
		this.var_risk_O_1 = var_risk_O_1;
	}

	public double getVar_risk_C1_1() {
		return var_risk_C1_1;
	}

	public void setVar_risk_C1_1(double var_risk_C1_1) {
		this.var_risk_C1_1 = var_risk_C1_1;
	}

	public double getVar_risk_C2_1() {
		return var_risk_C2_1;
	}

	public void setVar_risk_C2_1(double var_risk_C2_1) {
		this.var_risk_C2_1 = var_risk_C2_1;
	}

	public double getVar_risk_L_1() {
		return var_risk_L_1;
	}

	public void setVar_risk_L_1(double var_risk_L_1) {
		this.var_risk_L_1 = var_risk_L_1;
	}

	public double getVar_risk_O_2() {
		return var_risk_O_2;
	}

	public void setVar_risk_O_2(double var_risk_O_2) {
		this.var_risk_O_2 = var_risk_O_2;
	}

	public double getVar_risk_C1_2() {
		return var_risk_C1_2;
	}

	public void setVar_risk_C1_2(double var_risk_C1_2) {
		this.var_risk_C1_2 = var_risk_C1_2;
	}

	public double getVar_risk_C2_2() {
		return var_risk_C2_2;
	}

	public void setVar_risk_C2_2(double var_risk_C2_2) {
		this.var_risk_C2_2 = var_risk_C2_2;
	}

	public double getVar_risk_L_2() {
		return var_risk_L_2;
	}

	public void setVar_risk_L_2(double var_risk_L_2) {
		this.var_risk_L_2 = var_risk_L_2;
	}

	public synchronized double getVar_usableMargin_4open() {
		return var_usableMargin_4open;
	}

	public synchronized void setVar_usableMargin_4open(double var_usableMargin_4open) {
		this.var_usableMargin_4open = var_usableMargin_4open;
	}

	public synchronized double getVar_withdrawableMoney() {
		return var_withdrawableMoney;
	}

	public synchronized void setVar_withdrawableMoney(double var_withdrawableMoney) {
		this.var_withdrawableMoney = var_withdrawableMoney;
	}

	public synchronized double getVar_maxMarginSum() {
		return var_maxMarginSum;
	}

	public synchronized void setVar_maxMarginSum(double var_maxMarginSum) {
		this.var_maxMarginSum = var_maxMarginSum;
	}

	public synchronized int getVar_risk1_Level() {
		return var_risk1_Level;
	}

	public synchronized void setVar_risk1_Level(int var_risk1_Level) {
		this.var_risk1_Level = var_risk1_Level;
	}

	public synchronized int getVar_risk2_Level() {
		return var_risk2_Level;
	}

	public synchronized void setVar_risk2_Level(int var_risk2_Level) {
		this.var_risk2_Level = var_risk2_Level;
	}
}