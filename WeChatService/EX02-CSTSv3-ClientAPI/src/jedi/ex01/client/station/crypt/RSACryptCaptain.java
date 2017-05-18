package jedi.ex01.client.station.crypt;

import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

public class RSACryptCaptain {
	private static boolean hasKeyInited = false;
	private static PublicKey publicKey;
	private static PrivateKey privateKey;

	private static PublicKey parsePublicKey(byte[] keyBytes) throws Exception {
		X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		PublicKey publicKey = keyFactory.generatePublic(keySpec);
		return publicKey;
	}

	private static PrivateKey parsePrivateKey(byte[] keyBytes) throws Exception {
		PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
		return privateKey;
	}

	private static byte[] formatKeyBuff(Key key) throws Exception {
		return key.getEncoded();
	}

	private static boolean checkKeys(PublicKey temppubkey, PrivateKey tempprikey) throws Exception {
		byte buf[] = new byte[] { 01, 02, 03, 04, 05 };
		Cipher cipher = Cipher.getInstance("RSA");// Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.ENCRYPT_MODE, temppubkey);
		byte[] enBytes = cipher.doFinal(buf);
		cipher.init(Cipher.DECRYPT_MODE, tempprikey);
		byte[] deBytes = cipher.doFinal(enBytes);
		if (buf.length != deBytes.length) {
			return false;
		}
		for (int i = 0; i < buf.length; i++) {
			if (buf[i] != deBytes[i]) {
				return false;
			}
		}
		return true;
	}

	public static synchronized boolean setKeys(byte[][] keyData) throws Exception {
		byte pubKeyBuf[] = keyData[0];
		byte priKeyBuf[] = keyData[1];
		PublicKey temppubkey = parsePublicKey(pubKeyBuf);
		PrivateKey tempprikey = parsePrivateKey(priKeyBuf);
		if (checkKeys(temppubkey, tempprikey)) {
			publicKey = temppubkey;
			privateKey = tempprikey;
			hasKeyInited = true;
			return true;
		} else {
			return false;
		}
	}

	public static synchronized byte[][] getKeys() throws Exception {
		if (!hasKeyInited) {
			throw new Exception("RSA Key not initialized yet!");
		}
		byte[][] data = new byte[2][];
		data[0] = formatKeyBuff(publicKey);
		data[1] = formatKeyBuff(privateKey);
		return data;
	}

	public static synchronized void tryGenKeys() throws Exception {
		if (hasKeyInited) {
			return;
		}
		genNewKeys();
	}

	public static synchronized void genNewKeys() throws Exception {
		KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
		keyPairGen.initialize(1024);
		KeyPair keyPair = keyPairGen.generateKeyPair();
		publicKey = (RSAPublicKey) keyPair.getPublic();
		privateKey = (RSAPrivateKey) keyPair.getPrivate();
		hasKeyInited = true;
	}

	public static boolean isHasKeyInited() {
		return hasKeyInited;
	}

	public static PublicKey getPublicKey() {
		return publicKey;
	}

	public static PrivateKey getPrivateKey() {
		return privateKey;
	}
}
