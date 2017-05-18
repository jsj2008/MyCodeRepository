package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl6001;
import allone.MTP.VerBank01.comm.datastruct.DB.GlDetails;

public class TradeCtrl6001Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		boolean init = StaticContext.getConfigCaptain().init("E:\\work\\project\\Ctrl\\WebRoot\\WEB-INF");
		System.out.println(init);
		
		GlDetails rd = new GlDetails();
		rd.setFD_DWTF_DATA("20120605");
		rd.setFD_DWTF_BRNO("899");
		rd.setFD_DWTF_EXCUR("CHF");
		rd.setFD_DWTF_ACNO("192105000");
		rd.setFD_DWTF_TXAMT(182540);
		rd.setFD_DWTF_DECIMAL(2);
		rd.setFD_DWTF_CRDB("D");
		rd.setFD_DWTF_RATE(28.0571471);
		rd.setFD_DWTF_TWDEQAMT(5121552);
		rd.setFD_DWTF_DESCPT("MTCnv");
		rd.setFD_DWTF_REFNO("111017589");
		
		IP_Ctrl6001 ip  = new IP_Ctrl6001();
		ip.setDbuDetails(new GlDetails[] {
				rd
		});
		
		new TradeCtrl6001().doTrade(ip);
	}

}
