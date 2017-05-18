package allone.MTP.VerBank01.Ctrl.ca.server;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.ca.CAErrCodeDesc;
import allone.MTP.VerBank01.Ctrl.ca.CASignException;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;

import com.formosoft.va.stub.FSVAFacade;

public class CAServerProxy {

	/**
	 * 验证签章
	 * @param signature
	 * @param data
	 * @throws CASignException
	 */
	public void verifySignData(String signature, String data) throws CASignException {
		String loginAcc = StaticContext.getConfigCaptain().getCaLoginAcct();
		String loginPswd = StaticContext.getConfigCaptain().getCaLoginPassword();
		String url = StaticContext.getConfigCaptain().getCaServletUrl();
		String loginMsg = StaticContext.getConfigCaptain().getCaLoginMessage();
		
		FSVAFacade facade = new FSVAFacade(loginAcc, loginPswd, url, loginMsg);
		int rtn = facade.FSVA_GetErrorCode();
		
		if (!CAErrCodeDesc.isSuccess(rtn)) {
			LogProxy.OutPrintln("connect ca failed. code=" + rtn + " loginacc=" + loginAcc
					+ " loginpswd=" + loginPswd + " url=" + url + " loginMsg="
					+ loginMsg);
			throw new CASignException(facade.FSVA_GetErrorMsg());
		}
		
		rtn = facade.FSVA_VerifySign(signature, data);
		if (!CAErrCodeDesc.isSuccess(rtn)) {
			LogProxy.OutPrintln("verify sign failed. code: " + rtn + " reason: " + facade.FSVA_GetErrorMsg());
			throw new CASignException(facade.FSVA_GetErrorMsg());
		}
	}
}
