package jedi.ex01.CSTS3.proxy.comm;

import java.util.ArrayList;
import java.util.HashMap;

import jedi.ex01.CSTS3.comm.struct.AccountStrategy;
import jedi.ex01.CSTS3.comm.struct.MoneyAccount;

public class AccountStore implements Cloneable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5144831860318106290L;
	private AccountStrategy strategy = null;
	private double C_balance;
	private double C_floatPL;
	private double C_floatRollover;
	private double C_equity;
	private double C_openMarginUsed;
	private double C_marginCall1Used;
	private double C_marginCall2Used;
	private double C_liquidationMarginUsed;
	private double C_totleLots;
	private double C_margin2;
	private double C_freeze;
//	private double C_usableMargin;
	private double C_closeCommission;
	private double C_openCommission;
	private transient AccountCapitalStatus C_accountCapitalStatus;
	private transient boolean _hasBeenFixed = false;
	private transient double C_marginOccupied4OpenTradeLocked;

	/**
	 * HashMap<currency,MoneyAccount>
	 */
	private HashMap moneyAccountMap = new HashMap();
	private ArrayList moneyAccountArray = new ArrayList();
		
	public AccountStore(AccountStrategy strategy) {
		setStrategy(strategy);
	}

	public Object clone() throws CloneNotSupportedException {
		AccountStore store = (AccountStore) super.clone();
		store.moneyAccountArray = new ArrayList();
		store.moneyAccountMap = new HashMap();
		MoneyAccount[] mas = new MoneyAccount[moneyAccountArray.size()];
		for (int i = 0; i < moneyAccountArray.size(); i++) {
			MoneyAccount tempma = (MoneyAccount) moneyAccountArray.get(i);
			mas[i] = (MoneyAccount) tempma.clone();
		}
		store.resetMoneyAccounts(mas);
		return store;
	}

	public void setStrategy(AccountStrategy strategy) {
		this.strategy = strategy;
	}

	public long getAccountID() {
		return strategy.getAccount();
	}

	public String getAeid() {
		return strategy.getAeid();
	}

	public String getGroupName() {
		return strategy.getGroupName();
	}

	public String getBasicCurrency() {
		return strategy.getBasicCurrency();
	}

	public AccountStrategy getStrategy() {
		return strategy;
	}

	/**
	 * Reset account,remove all and add all
	 * 
	 * @param accounts
	 */
	public void resetMoneyAccounts(MoneyAccount[] accounts) {
		synchronized (moneyAccountMap) {
			moneyAccountMap.clear();
			moneyAccountArray.clear();
			for (int i = 0; i < accounts.length; i++) {
				MoneyAccount ac = accounts[i];
				if (ac.getAccount() == this.getAccountID()) {
					if (ac.getCurrencyName() == null) {
						throw new NullPointerException();
					}
					moneyAccountMap.put(ac.getCurrencyName(), ac);
					moneyAccountArray.add(ac);
				}
			}
		}
	}

	public void setMoneyAccount(MoneyAccount account) {
		removeMoneyAccount(account.getCurrencyName());
		synchronized (moneyAccountMap) {
			if (account.getCurrencyName() == null) {
				throw new NullPointerException();
			}
			moneyAccountMap.put(account.getCurrencyName(), account);
			moneyAccountArray.add(account);
		}
	}

	public MoneyAccount removeMoneyAccount(String currency) {
		synchronized (moneyAccountMap) {
			moneyAccountMap.remove(currency);
			for (int i = 0; i < moneyAccountArray.size(); i++) {
				MoneyAccount ac = (MoneyAccount) moneyAccountArray.get(i);
				if (ac.getCurrencyName().equals(currency)) {
					return (MoneyAccount) moneyAccountArray.remove(i);
				}
			}
		}
		return null;
	}

	public MoneyAccount getMoneyAccount(String currency) {
		synchronized (moneyAccountMap) {
			if (!moneyAccountMap.containsKey(currency)) {
				MoneyAccount mac = new MoneyAccount();
				mac.setAccount(this.getAccountID());
				mac.setCurrencyName(currency);
				if (mac.getCurrencyName() == null) {
					throw new NullPointerException();
				}
				this.setMoneyAccount(mac);
			}
			return (MoneyAccount) moneyAccountMap.get(currency);
		}
	}

	public MoneyAccount[] getMoneyAccounts() {
		synchronized (moneyAccountMap) {
			return (MoneyAccount[]) moneyAccountArray
					.toArray(new MoneyAccount[0]);
		}
	}

	public double getC_balance() {
		return C_balance;
	}

	public void setC_balance(double c_balance) {
		C_balance = c_balance;
	}

	public double getC_floatPL() {
		return C_floatPL;
	}

	public void setC_floatPL(double c_floatpl) {
		C_floatPL = c_floatpl;
	}

	public double getC_floatRollover() {
		return C_floatRollover;
	}

	public void setC_floatRollover(double rollover) {
		C_floatRollover = rollover;
	}

	public double getC_equity() {
		return C_equity;
	}

	public void setC_equity(double c_equity) {
		C_equity = c_equity;
	}

	public double getC_openMarginUsed() {
		return C_openMarginUsed;
	}

	public void setC_openMarginUsed(double marginUsed) {
		C_openMarginUsed = marginUsed;
	}

	public double getC_marginCall1Used() {
		return C_marginCall1Used;
	}

	public void setC_marginCall1Used(double call1Used) {
		C_marginCall1Used = call1Used;
	}

	public double getC_marginCall2Used() {
		return C_marginCall2Used;
	}

	public void setC_marginCall2Used(double call2Used) {
		C_marginCall2Used = call2Used;
	}

	public double getC_liquidationMarginUsed() {
		return C_liquidationMarginUsed;
	}

	public void setC_liquidationMarginUsed(double marginUsed) {
		C_liquidationMarginUsed = marginUsed;
	}

	public double getC_totleLots() {
		return C_totleLots;
	}

	public void setC_totleLots(double lots) {
		C_totleLots = lots;
	}

	public boolean is_hasBeenFixed() {
		return _hasBeenFixed;
	}

	public void set_hasBeenFixed(boolean beenFixed) {
		_hasBeenFixed = beenFixed;
	}

	public double getC_margin2() {
		return C_margin2;
	}

	public void setC_margin2(double c_margin2) {
		C_margin2 = c_margin2;
	}

	public double getC_freeze() {
		return C_freeze;
	}

	public void setC_freeze(double c_freeze) {
		C_freeze = c_freeze;
	}

	// public double getC_usableMargin() {
	// return C_usableMargin;
	// }
	//
	// public void setC_usableMargin(double margin) {
	// C_usableMargin = margin;
	// }

	public double getC_closeCommission() {
		return C_closeCommission;
	}

	public void setC_closeCommission(double commission) {
		C_closeCommission = commission;
	}

	public AccountCapitalStatus getC_accountCapitalStatus() {
		return C_accountCapitalStatus;
	}

	public void setC_accountCapitalStatus(AccountCapitalStatus capitalStatus) {
		C_accountCapitalStatus = capitalStatus;
	}

	public double getC_openCommission() {
		return C_openCommission;
	}

	public void setC_openCommission(double commission) {
		C_openCommission = commission;
	}

	public double getC_marginOccupied4OpenTradeLocked() {
		return C_marginOccupied4OpenTradeLocked;
	}

	public void setC_marginOccupied4OpenTradeLocked(double c_marginOccupied4OpenTradeLocked) {
		C_marginOccupied4OpenTradeLocked = c_marginOccupied4OpenTradeLocked;
	}


}
