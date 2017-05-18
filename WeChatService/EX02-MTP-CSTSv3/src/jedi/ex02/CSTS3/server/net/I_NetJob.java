package jedi.ex02.CSTS3.server.net;

import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteSizeData;
import allone.crypto.AES.AESSecretKey;
import allone.json.AbstractJsonData;

public interface I_NetJob {
	
	public void init(I_ClientNode clientNode);

	public void sendJsonData(AbstractJsonData data,boolean needToBeSealed,boolean needEncrypt,boolean Immediately);
	
	public void sendQuote(C3_QuoteData quote);
	
	public void sendVolumn(C3_QuoteSizeData quote);
	
	public String getIpAddress();
	
	public int getPort();
	
	public AESSecretKey getCryptSecretKey();
	
	public void destroy();

}
