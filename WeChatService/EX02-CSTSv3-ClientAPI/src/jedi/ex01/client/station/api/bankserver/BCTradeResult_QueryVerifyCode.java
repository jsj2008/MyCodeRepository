package jedi.ex01.client.station.api.bankserver;

import jedi.v7.bankserver.comm.struct.CITICUserData;

/**
 * �������в�ѯУ���뷵�ؽ��ṹ
 * 
 * @author zhouyi
 * @createTime 2016-04-05
 */
public class BCTradeResult_QueryVerifyCode extends BCTradeResult {

	private CITICUserData userData;

	public CITICUserData getUserData() {
		return userData;
	}

	public void setUserData(CITICUserData userData) {
		this.userData = userData;
	}

}
