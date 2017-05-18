package allone.MTP.VerBank01.Ctrl.push.send;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class SendConfig {

	// iOS
	private InputStream iPadKeyStream;
	private InputStream iPhoneKeyStream;

	private String iPadKeyPwd;
	private String iPhoneKeyPwd;

	private boolean iPadIsDevelop;
	private boolean iPhoneIsDevelop;
	private int poolSize;

	// android
	private String aPadApiKey;
	private String aPhoneApiKey;

	public boolean init(String rootPath) {
		try {

			// iOS
			String iPadFilePath = rootPath + File.separator + "config" + File.separator + "IPadCertificate.p12";
			String iPhoneFilePath = rootPath + File.separator + "config" + File.separator + "IPhoneCertificate.p12";
			iPadKeyStream = new FileInputStream(iPadFilePath);
			iPhoneKeyStream = new FileInputStream(iPhoneFilePath);
//			iPadKeyStream.close();
//			iPhoneKeyStream.close();

			Properties pro = new Properties();
			FileInputStream fi = new FileInputStream(rootPath + File.separator + "config" + File.separator + "Certificate.properties");
			pro.load(fi);
			fi.close();

			iPadIsDevelop = pro.getProperty("iPadIsDevelop").equalsIgnoreCase("true");
			iPhoneIsDevelop = pro.getProperty("iPhoneIsDevelop").equalsIgnoreCase("true");

			iPadKeyPwd = pro.getProperty("iPadKeyPwd");
			iPhoneKeyPwd = pro.getProperty("iPhoneKeyPwd");

			poolSize = Integer.parseInt(pro.getProperty("poolSize"));

			// android
			aPadApiKey = pro.getProperty("APADAPIKEY");
			aPhoneApiKey = pro.getProperty("APHONEAPIKEY");

		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * @return the iPadKeyStream
	 */
	public InputStream getiPadKeyStream() {
		return iPadKeyStream;
	}

	/**
	 * @param iPadKeyStream
	 *            the iPadKeyStream to set
	 */
	public void setiPadKeyStream(InputStream iPadKeyStream) {
		this.iPadKeyStream = iPadKeyStream;
	}

	/**
	 * @return the iPhoneKeyStream
	 */
	public InputStream getiPhoneKeyStream() {
		return iPhoneKeyStream;
	}

	/**
	 * @param iPhoneKeyStream
	 *            the iPhoneKeyStream to set
	 */
	public void setiPhoneKeyStream(InputStream iPhoneKeyStream) {
		this.iPhoneKeyStream = iPhoneKeyStream;
	}

	/**
	 * @return the iPadKeyPwd
	 */
	public String getiPadKeyPwd() {
		return iPadKeyPwd;
	}

	/**
	 * @param iPadKeyPwd
	 *            the iPadKeyPwd to set
	 */
	public void setiPadKeyPwd(String iPadKeyPwd) {
		this.iPadKeyPwd = iPadKeyPwd;
	}

	/**
	 * @return the iPhoneKeyPwd
	 */
	public String getiPhoneKeyPwd() {
		return iPhoneKeyPwd;
	}

	/**
	 * @param iPhoneKeyPwd
	 *            the iPhoneKeyPwd to set
	 */
	public void setiPhoneKeyPwd(String iPhoneKeyPwd) {
		this.iPhoneKeyPwd = iPhoneKeyPwd;
	}

	/**
	 * @return the iPadIsDevelop
	 */
	public boolean isiPadIsDevelop() {
		return iPadIsDevelop;
	}

	/**
	 * @param iPadIsDevelop
	 *            the iPadIsDevelop to set
	 */
	public void setiPadIsDevelop(boolean iPadIsDevelop) {
		this.iPadIsDevelop = iPadIsDevelop;
	}

	/**
	 * @return the iPhoneIsDevelop
	 */
	public boolean isiPhoneIsDevelop() {
		return iPhoneIsDevelop;
	}

	/**
	 * @param iPhoneIsDevelop
	 *            the iPhoneIsDevelop to set
	 */
	public void setiPhoneIsDevelop(boolean iPhoneIsDevelop) {
		this.iPhoneIsDevelop = iPhoneIsDevelop;
	}

	/**
	 * @return the poolSize
	 */
	public int getPoolSize() {
		return poolSize;
	}

	/**
	 * @param poolSize
	 *            the poolSize to set
	 */
	public void setPoolSize(int poolSize) {
		this.poolSize = poolSize;
	}

	/**
	 * @return the aPadApiKey
	 */
	public String getaPadApiKey() {
		return aPadApiKey;
	}

	/**
	 * @param aPadApiKey
	 *            the aPadApiKey to set
	 */
	public void setaPadApiKey(String aPadApiKey) {
		this.aPadApiKey = aPadApiKey;
	}

	/**
	 * @return the aPhoneApiKey
	 */
	public String getaPhoneApiKey() {
		return aPhoneApiKey;
	}

	/**
	 * @param aPhoneApiKey
	 *            the aPhoneApiKey to set
	 */
	public void setaPhoneApiKey(String aPhoneApiKey) {
		this.aPhoneApiKey = aPhoneApiKey;
	}
}
