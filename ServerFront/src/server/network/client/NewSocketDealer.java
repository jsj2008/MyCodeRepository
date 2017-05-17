package server.network.client;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ObjectInputStream;
import java.math.BigInteger;
import java.net.Socket;
import java.security.KeyFactory;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;

import allone.crypto.AES.AESKeyGen;
import allone.crypto.AES.AESSecretKey;

import comm.fix.FixDataUtil;
import comm.fix.FixIoUtil;

public class NewSocketDealer extends Thread {
	private final static byte[] precheckbuf = { 0x01, 0xa, 0x2, 0xb, (byte) 0xcd };
	private static byte[] pingBuf;
	private final static int type_dealer = 2;
	private final static int type_ping = 30;
	private final static int type_ping_request = 5;
	private Socket socket;
	private BufferedInputStream bis;
	private BufferedOutputStream bos;
	private AESSecretKey cryptKey;

	public NewSocketDealer(Socket socket) {
		this.socket = socket;
	}

	public void run() {
		int type;
		String dealerGUID = null;
		try {
			initNet();
			check();
			type = getType();
			if (type == type_ping) {
				responseForPing();
				return;
			}
			if (type == type_dealer) {
				initCrypt();
				dealerGUID = this.readDealerGUID();
			}
		} catch (Exception e) {
			e.printStackTrace();
			clearNet();
			return;
		}
		if (type == type_dealer) {
			System.out.println("FundDSTS-NewSocket: " + dealerGUID);
			new ClientNode(cryptKey, socket, bis, bos, dealerGUID);
		} else {
			clearNet();
		}
	}

	private void initNet() throws Exception {
		socket.setTcpNoDelay(true);
		socket.setKeepAlive(true);
		socket.setSoLinger(true, 5000);
		socket.setSoTimeout(3000 * 1000);
		bis = new BufferedInputStream(socket.getInputStream());
		bos = new BufferedOutputStream(socket.getOutputStream());
	}

	private void check() throws Exception {
		byte buf[] = new byte[precheckbuf.length];
		if (bis.read(buf) == -1) {
			throw new Exception("New client connection check failed!(ip=" + socket.getInetAddress().getHostAddress() + ")");
		}
		System.out.println("New client connected,checking.....(ip=" + socket.getInetAddress().getHostAddress() + ")");
		for (int i = 0; i < buf.length; i++) {
			if (buf[i] != precheckbuf[i]) {
				throw new Exception("New client connection check failed!(ip=" + socket.getInetAddress().getHostAddress() + ")");
			}
		}
	}

	private int getType() throws Exception {
		return bis.read();
	}

	private void initCrypt() throws Exception {
		byte lengthBuf[] = FixIoUtil.readBuffer(bis, 8);
		int length = Integer.valueOf(new String(lengthBuf).trim());
		byte buf[] = FixIoUtil.readBuffer(bis, length - 8);
		String ss = new String(buf);
		String km[] = ss.split(";");

		KeyFactory keyFac = KeyFactory.getInstance("RSA");
		RSAPublicKeySpec pubKeySpec = new RSAPublicKeySpec(new BigInteger(km[0], 16), new BigInteger(km[1], 16));
		RSAPublicKey key = (RSAPublicKey) keyFac.generatePublic(pubKeySpec);

		cryptKey = AESKeyGen.genAESKey();

		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.ENCRYPT_MODE, key);
		byte[] enBuf = cipher.doFinal(cryptKey.getKey().getEncoded());

		byte[] lengthBuff = FixDataUtil.formatInt(enBuf.length + 8, 8);
		bos.write(lengthBuff);
		bos.write(enBuf);
		bos.flush();
	}

	private String readDealerGUID() throws Exception {
		ObjectInputStream ois = new ObjectInputStream(bis);
		String guid = (String) ois.readObject();
		return guid;
	}

	private void clearNet() {
		if (bis != null) {
			try {
				bis.close();
				bis = null;
			} catch (Exception e) {
			}
		}
		if (bos != null) {
			try {
				bos.close();
				bos = null;
			} catch (Exception e) {
			}
		}
		if (socket != null) {
			try {
				socket.close();
				socket = null;
			} catch (Exception e) {
			}
		}
	}

	private void responseForPing() {
		try {
			if (pingBuf == null) {
				byte buf[] = new byte[1024 * 2];
				for (int i = 0; i < buf.length; i++) {
					buf[i] = (byte) 0xa0;
				}
				pingBuf = buf;
			}
			for (int i = 0; i < 4; i++) {
				int req = bis.read();
				if (req == type_ping_request) {
					bos.write(pingBuf);
					bos.flush();
				}
			}
		} catch (Exception e) {
		} finally {
			this.clearNet();
		}
	}
}
