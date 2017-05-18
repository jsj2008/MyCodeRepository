package jedi.ex01.CSTS3.proxy.client;

import java.net.Socket;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.jsondata.KickOutNode;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.CSTS3.comm.struct.QuoteSizeData;

public class ProxyTest implements DataListener{
	
	public static void main(String[] args) {
		try {
			CSTSProxy proxy = new CSTSProxy();
			ProxyTest test=new ProxyTest();
			Socket socket=new Socket("127.0.0.1",21238);
			if (!proxy.init(socket, test)) {
				return;
			}
			System.out.println("inited !");
			System.in.read();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void onInforRec(InfoFather info) {
		// TODO Auto-generated method stub
		
	}

	public void onKickedOut(KickOutNode kicknode) {
		// TODO Auto-generated method stub
		
	}

	public void onKickedOutBySys() {
		// TODO Auto-generated method stub
		
	}

	public void onNetLost() {
		// TODO Auto-generated method stub
		
	}

	public void onPing(long ping, long avePing, double lostPerc) {
		// TODO Auto-generated method stub
		
	}

	public void onPingTimeOut() {
		// TODO Auto-generated method stub
		
	}

	public void onQuoteRec(QuoteData[] quote) {
		// TODO Auto-generated method stub
		
	}

	public void onVolumnRec(QuoteSizeData[] quoteSize) {
		// TODO Auto-generated method stub
		
	}

}
