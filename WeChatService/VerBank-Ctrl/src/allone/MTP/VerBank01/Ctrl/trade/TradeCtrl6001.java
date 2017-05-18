package allone.MTP.VerBank01.Ctrl.trade;

import java.text.SimpleDateFormat;
import java.util.Date;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl6001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl6001;
import allone.MTP.VerBank01.Ctrl.config.ConfigCaptain;
import allone.MTP.VerBank01.Ctrl.gl.FileGenerator;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.datastruct.DB.GlDetails;

public class TradeCtrl6001 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl6001 ip = (IP_Ctrl6001) ipFather;
		OP_Ctrl6001 op = new OP_Ctrl6001(ip);

		try {
			ConfigCaptain cc = StaticContext.getConfigCaptain();
			GlDetails[] datas = ip.getDbuDetails();
			if (datas != null) {
				String filePath = cc.getGlDBUPath();
				String fileName = cc.getGlDBUFile();
				
				createFile(datas, filePath, fileName);
			}

			datas = ip.getObuDetails();
			if (datas != null) {
				String filePath = cc.getGlOBUPath();
				String fileName = cc.getGlOBUFile();
				
				createFile(datas, filePath, fileName);
			}
			
			op.setSucceed(true);
		} catch (Exception e) {
			LogProxy.printException(e);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_TradeFailed);
			op.setErrMessage("crate GL file failed. ex:" + e.getMessage());
		}
		
		return op;
	}

	private void createFile(GlDetails[] datas, String filePath, String fileName)
			throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat(StaticContext.getConfigCaptain().getGlTimeFormat());
		String now = sdf.format(new Date());
		String standardFileName = fileName.replaceFirst("\\{time\\}", now);
		
		FileGenerator fg = new FileGenerator();
		String fileData = fg.createFile(datas);
		fg.writeFile(fileData, filePath, standardFileName);
	}
	
}
