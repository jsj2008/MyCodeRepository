package jedi.ex02.CSTS3.server.net;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.math.BigInteger;
import java.net.Socket;
import java.security.KeyFactory;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.text.DecimalFormat;

import javax.crypto.Cipher;

import jedi.ex02.CSTS3.comm.fix.FIXioUtil;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.debug.DebugLogCaptain;
import allone.CADTS.proxy.ping.PingResult;
import allone.Log.simpleLog.log.LogProxy;
import allone.crypto.AES.AESKeyGen;
import allone.crypto.AES.AESSecretKey;

public class NewSocketDealer extends Thread {
	private final static byte[] precheckbuf = { 97, 65, 108, 111, 110, 25 };
	private static byte[] speedCheckResponseBuf;
	private static byte[] pingBuf;
	private Socket socket;
	private String ipAddress;
	private BufferedInputStream bis;
	private BufferedOutputStream bos;
	private AESSecretKey cryptKey;

	public final static int type_java = 1;
	public final static int type_flex = 2;
	public final static int type_androind = 3;
	public final static int type_iphone = 4;
	public final static int type_checkSpeed = 10;
	public final static int type_ping = 30;
	public final static int type_ping_request = 5;

	public NewSocketDealer(Socket socket) {
		this.socket = socket;
		this.ipAddress = socket.getInetAddress().getHostAddress();
	}

	public void run() {
		try {
			int type;
			DebugLogCaptain.getInstance().log(ipAddress, "new connection init net");
			initNet();
			DebugLogCaptain.getInstance().log(ipAddress, "begin check");
			check();
			type = getType();
			// System.out.println("type = "+type);
			if (type == type_checkSpeed) {
				DebugLogCaptain.getInstance().log(ipAddress, "type_checkSpeed");
				responseForSpeedChecking();
				return;
			}
			if (type == type_ping) {
				DebugLogCaptain.getInstance().log(ipAddress, "type_ping");
				responseForPing();
				return;
			}
			if (type == type_java || type == type_flex || type == type_androind || type == type_iphone) {
				DebugLogCaptain.getInstance().log(ipAddress, "initCrypt");
				initCrypt();
			}
			NetJob_IO job = new NetJob_IO(cryptKey, socket, bis, bos);
			new ClientNode(job, type);
			DebugLogCaptain.getInstance().log(ipAddress, "init end");
		} catch (Exception e) {
			LogProxy.printException(e);
			DebugLogCaptain.getInstance().log(ipAddress, "Exception : " + e.getMessage());
			clearNet();
		} finally {
			DebugLogCaptain.getInstance().printLog();
		}
	}

	private void initNet() throws Exception {
		// socket.setTcpNoDelay(true);
		// socket.setKeepAlive(true);
		// socket.setSoLinger(true, 5000);
		socket.setSoTimeout(30 * 1000);
		bis = new BufferedInputStream(socket.getInputStream());
		bos = new BufferedOutputStream(socket.getOutputStream());
	}

	private int getType() throws Exception {
		return bis.read();
	}

	private void check() throws Exception {
		byte buf[] = new byte[precheckbuf.length];
		bis.read(buf);
		LogProxy.OutPrintln("New client connected,checking.....(ip=" + ipAddress + ")");
		for (int i = 0; i < buf.length; i++) {
			if (buf[i] != precheckbuf[i]) {
				throw new Exception("New client connection check failed!(ip=" + ipAddress + ")");
			}
		}
		// IP_CTRL1001 ip1001 = new IP_CTRL1001();
		// StaticContext.getCADTSCaptain().getCaptain().trade(ServCallNameTable.SERV_MTP4_CTRL,
		// ServCallNameTable.FUN_MTP4_TRADE, ServCallNameTable.DATA_MTP4_DATA,
		// ip1001, true, 10 * 1000);
		//
		// byte[] bytes = new byte[1024];
		// FIXioUtil.writeData(bytes, bos);
		// System.out.println("[send] 1024 byte");
	}

	private void initCrypt() throws Exception {
		// byte lengthBuf[] = new byte[8];
		// read(bis, lengthBuf);
		byte lengthBuf[] = FIXioUtil.readBuffer(bis, 8);
		// FIXioUtil.printBuffer(lengthBuf);//
		int length = Integer.valueOf(new String(lengthBuf).trim());
		// byte buf[] = new byte[length - 8];
		// read(bis, buf);
		byte buf[] = FIXioUtil.readBuffer(bis, length - 8);
		// FIXioUtil.printBuffer(buf);//
		String ss = new String(buf);
		String km[] = ss.split(";");

		KeyFactory keyFac = KeyFactory.getInstance("RSA");
		RSAPublicKeySpec pubKeySpec = new RSAPublicKeySpec(new BigInteger(km[0], 16), new BigInteger(km[1], 16));
		RSAPublicKey key = (RSAPublicKey) keyFac.generatePublic(pubKeySpec);
		cryptKey = AESKeyGen.genAESKey();

		// System.out.println("AES key:");
		// FIXioUtil.printBuffer(cryptKey.getKey().getEncoded());
		// Cipher cipher = Cipher.getInstance("RSA");
		// Cipher cipher = Cipher.getInstance("RSA/ECB/NoPadding");
		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.ENCRYPT_MODE, key);
		byte[] enBuf = cipher.doFinal(cryptKey.getKey().getEncoded());
		// byte[] enBuf=new byte[128];
		// for(int i=0;i<enBuf.length;i++) {
		// enBuf[i]=(byte)i;
		// }
		// FIXioUtil.printBuffer(enBuf);

		byte[] lengthBuff = formatInt(enBuf.length + 8, 8);
		bos.write(lengthBuff);
		bos.write(enBuf);
		bos.flush();

		// byte lengthBuf[] = new byte[8];
		// read(bis, lengthBuf);
		// int length = Integer.valueOf(new String(lengthBuf).trim());
		// byte buf[] = new byte[length - 8];
		// read(bis, buf);
		// String ss = new String(buf);
		// String km[] = ss.split(";");
		//
		// KeyFactory keyFac = KeyFactory.getInstance("RSA");
		// RSAPublicKeySpec pubKeySpec = new RSAPublicKeySpec(new
		// BigInteger(km[0], 16), new BigInteger(km[1],
		// 16));
		// RSAPublicKey key = (RSAPublicKey) keyFac.generatePublic(pubKeySpec);
		//
		// System.out.println("[read] rsa key!");
		//
		// cryptKey = AESKeyGen.genAESKey();
		//
		// Cipher cipher = Cipher.getInstance("RSA");
		// cipher.init(Cipher.ENCRYPT_MODE, key);
		// byte[] enBuf = cipher.doFinal(cryptKey.getKey().getEncoded());
		//
		// FIXioUtil.writeData(enBuf, bos);
		//
		// System.out.println("[send] aes key!");
	}

	private static byte[] formatInt(int number, int length) {
		DecimalFormat format = new DecimalFormat();
		format.setMaximumIntegerDigits(length);
		format.setMinimumIntegerDigits(length);
		format.setGroupingUsed(false);
		return format.format(number).getBytes();
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

	// private static void read(InputStream is, byte buf[]) throws IOException {
	// is.read(buf);
	// StringBuffer sb = new StringBuffer();
	// sb.append("--------------");
	// sb.append("\r\n");
	// sb.append("Read:");
	// sb.append(buf.length);
	// sb.append("\r\n");
	// sb.append(" [ ");
	// for (int i = 0; i < buf.length; i++) {
	// sb.append(buf[i]);
	// sb.append(",");
	// }
	// sb.append(" ] ");
	// sb.append("\r\n");
	// sb.append("--------------");
	// sb.append("\r\n");
	// sb.append(new String(buf));
	// // System.out.println(sb);
	// }

	private void responseForSpeedChecking() {
		try {
			if (speedCheckResponseBuf == null) {
				byte buf[] = new byte[128 * 3];
				for (int i = 0; i < buf.length; i++) {
					buf[i] = (byte) 0xa0;
				}
				speedCheckResponseBuf = buf;
			}
			PingResult result = StaticContext.getCADTSCaptain().getPingCaptain().getPingResult();
			if (result.isTimeout()) {
				return;
			} else {
				Thread.sleep(result.getPing());
			}
			byte weightBuf[] = getNetWeightBuf();
			byte tempbuf[] = new byte[speedCheckResponseBuf.length];
			System.arraycopy(speedCheckResponseBuf, 0, tempbuf, 0, speedCheckResponseBuf.length);
			System.arraycopy(weightBuf, 0, tempbuf, 0, weightBuf.length);
			bos.write(tempbuf);
			bos.flush();
		} catch (Exception e) {
		} finally {
			this.clearNet();
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
			byte weightBuf[] = getNetWeightBuf();
			byte tempbuf[] = new byte[pingBuf.length];
			System.arraycopy(pingBuf, 0, tempbuf, 0, pingBuf.length);
			System.arraycopy(weightBuf, 0, tempbuf, 0, weightBuf.length);
			for (int i = 0; i < 4; i++) {
				int req = bis.read();
				if (req == type_ping_request) {
					bos.write(tempbuf);
					bos.flush();
				}
			}
		} catch (Exception e) {
		} finally {
			this.clearNet();
		}
	}

	private byte[] getNetWeightBuf() {
		int weight = StaticContext.getCSTSDoc().getNetWeight();
		String weightStr = String.valueOf(weight);
		byte buf[] = weightStr.getBytes();
		byte res[] = new byte[10];
		for (int i = 0; i < res.length; i++) {
			res[i] = 0;
		}
		for (int i = 0; i < buf.length; i++) {
			res[i] = buf[i];
		}
		return res;
	}

}
