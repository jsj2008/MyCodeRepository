package proxy;

import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.Socket;

import comm.KickBySysNode;
import comm.KickOutNode;

public class ProxyTest implements DataListener {
	private DealerProxy proxy = new DealerProxy();

	public void test() {
		try {
			Socket socket = new Socket(Proxy.NO_PROXY);
			InetSocketAddress address = new InetSocketAddress("192.168.0.17", 20220);
			socket.connect(address);
			proxy.init(socket, this, null);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		proxy.destroy();
	}

	public static void main(String[] args) {
		ProxyTest t = new ProxyTest();
		t.test();
	}

	// public void onInforRec(FundInforFather info) {
	// }
	//
	// public void onKickedOut(KickOutNode kicknode) {
	// }

	public void onNetLost() {
	}

	// public void onQuoteRec(QuoteData[] quote) {
	// }

	public void onKickBySysNode(KickBySysNode kickNode) {
	}

	public void onPing(long ping, long avePing, double lostPerc) {
	}

	public void onOtherData(Object obj) {
	}

	@Override
	public void onKickedOut(KickOutNode kicknode) {
		// TODO Auto-generated method stub
		
	}

}
