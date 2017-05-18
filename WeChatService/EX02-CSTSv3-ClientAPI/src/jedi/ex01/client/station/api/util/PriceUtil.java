package jedi.ex01.client.station.api.util;

import java.util.HashMap;
import java.util.Iterator;

import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.client.station.api.doc.DataDoc;

public class PriceUtil {
	// HashMap<accountID,HashMap<Instrument,Double>>
	private static HashMap askPriceShiftMap = new HashMap();

	public static double getShiftedAskPrice(double ask, long account,
			String instrument) {
		synchronized (askPriceShiftMap) {
			Long accountID = new Long(account);
			HashMap map2 = null;
			if (askPriceShiftMap.containsKey(accountID)) {
				map2 = (HashMap) askPriceShiftMap.get(accountID);
			} else {
				map2 = new HashMap();
				askPriceShiftMap.put(accountID, map2);
			}
			if (map2.containsKey(instrument)) {
				Double shift = (Double) map2.get(instrument);
				return ask + shift.doubleValue();
			} else {
				Double shift = getShift(accountID, instrument);
				map2.put(instrument, shift);
				return ask + shift.doubleValue();
			}
		}
	}

	private static Double getShift(Long accountID, String instrument) {
		synchronized (askPriceShiftMap) {
			Instrument instrumentNode=DataDoc.getInstance().getInstrument(instrument);
//			AccountStore accountStore = DataDoc.getInstance().getAccountStore();
//			InstrumentsGroupCfg igc = InstrumentDoc.getInstrumentDoc()
//					.getInstrumentGroupCfg(accountStore.getGroupName(),
//							instrument);
//			InstrumentsAccountCfg iac = InstrumentDoc.getInstrumentDoc()
//					.getInstrumentAccountCfg(accountID, instrument);
			double shift = 0;
//			if (igc != null) {
			if(instrumentNode.getGroupName()!=null){
				shift += instrumentNode.getGroup_spread2Add();
			}
//			}
//			if (iac != null) {
			if(instrumentNode.getAccount()>0){
				shift += instrumentNode.getAccount_spread2Add();
			}
//			}
			return new Double(Math.pow(10,-1*instrumentNode.getDigits())*shift);
		}
	}

	/**
	 * 清空shift，如果instrument是null，则对应的account下全部清空
	 * 
	 * @param accountID
	 * @param instrument
	 */
	public static void clearShift(long account, String instrument) {
		synchronized (askPriceShiftMap) {
			Long accountID = new Long(account);
			if (instrument == null) {
				askPriceShiftMap.remove(accountID);
			} else {
				HashMap map2 = (HashMap) askPriceShiftMap.get(accountID);
				if (map2 != null) {
					map2.remove(instrument);
				}
			}
		}
	}

	public static void clearShift(String instrument) {
		synchronized (askPriceShiftMap) {
			if(instrument==null){
				askPriceShiftMap.clear();
				return;
			}
			Iterator it = (Iterator) askPriceShiftMap.values().iterator();
			while (it.hasNext()) {
				HashMap map2 = (HashMap) it.next();
				map2.remove(instrument);
			}
		}
	}
	
	public static void clearShift(){
		clearShift(null);
	}
}
