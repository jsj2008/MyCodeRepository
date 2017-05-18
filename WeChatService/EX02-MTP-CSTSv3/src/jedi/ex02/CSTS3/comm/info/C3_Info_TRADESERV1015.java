package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_PriceWarning;
import jedi.v7.trade.comm.infor.Info_TRADESERV1015;


public class C3_Info_TRADESERV1015 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1015";

	public static final String priceWarning = "1";

	public C3_Info_TRADESERV1015(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1015 data) throws Exception {
		super.parseFromSysData(data);
		C3_PriceWarning priceWarning = new C3_PriceWarning();
		priceWarning.parseFromSysData(data.getPriceWarning());
		setPriceWarning(priceWarning);
	}


	public C3_PriceWarning getPriceWarning() {
		try {
			C3_PriceWarning data=getEntryObject(C3_Info_TRADESERV1015.priceWarning);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceWarning(C3_PriceWarning priceWarning) {
		setEntry(C3_Info_TRADESERV1015.priceWarning, priceWarning);
	}


}