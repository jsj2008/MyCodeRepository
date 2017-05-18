package jedi.ex01.client.station.api.bankserver;

import jedi.ex01.CSTS3.comm.ipop.OPFather;

public class BankServOPFather extends OPFather implements Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9052892393005746169L;

	//
	// public BankServOPFather(BankServIPFather ip) {
	// super(ip);
	// }

	public BankServOPFather() {
		super();
	}

	@Override
	public BankServOPFather clone() {
		try {
			return (BankServOPFather) super.clone();
		} catch (CloneNotSupportedException e) {
			return this;
		}
	}
}
