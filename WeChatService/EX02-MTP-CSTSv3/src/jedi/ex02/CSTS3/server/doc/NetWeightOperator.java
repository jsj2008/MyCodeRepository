package jedi.ex02.CSTS3.server.doc;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;

import jedi.ex02.CSTS3.server.StaticContext;

public class NetWeightOperator extends Thread {
	private boolean isDestroy = false;
	private boolean isTotalCal = false;
	private File dirFile = null;
	private File maxOnlineNumFile = null;
	private File selfOnlineNumFile = null;
	private String servID;
	private int total_lastTotalOnlineNum;
	private int total_lastSelfOnlineNum;
	private int total_lastMaxOnlineNum;

	public void init() {
		isDestroy = false;
		String dir = StaticContext.getCSConfigCaptain().getNetWeightDir();
		System.out.println("CSTS net weight path is " + dir);
		if (dir == null) {
			isTotalCal = false;
		} else {
			dirFile = new File(dir);
			String maxOnlineNumFilePath = dirFile.getAbsolutePath()
					+ File.separator + "MAXONLINENUM.cfg";
			maxOnlineNumFile = new File(maxOnlineNumFilePath);
			if (!maxOnlineNumFile.exists() || !maxOnlineNumFile.canRead()) {
				System.out.println("CSTS maxOnlineNumFile "
						+ maxOnlineNumFile.exists() + ","
						+ maxOnlineNumFile.canRead());
				isTotalCal = false;
			} else {
				isTotalCal = true;
				servID = StaticContext.getCSConfigCaptain().getCADTSIp() + "_"
						+ StaticContext.getCSConfigCaptain().getCADTSCmdPort()
						+ "_" + StaticContext.getCSConfigCaptain().getCstsName();
				selfOnlineNumFile = new File(dirFile.getAbsolutePath()
						+ File.separator + servID + ".data");
				start();
			}
		}
	}

	public void destroy() {
		isDestroy = true;
		this.interrupt();
	}

	public void run() {
		while (!isDestroy) {
			if (isTotalCal) {
				doJob();
			}
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
			}
		}
	}

	private void doJob() {
		storeOnlineNum();
		total_lastSelfOnlineNum = getSelfOnlineNum();
		total_lastMaxOnlineNum = readMaxOnlineNum();
		total_lastTotalOnlineNum = Math.max(total_lastSelfOnlineNum,
				readTotalOnlineNum());
	}

	private int readMaxOnlineNum() {
		FileInputStream fis = null;
		int num = 100;
		try {
			fis = new FileInputStream(maxOnlineNumFile);
			BufferedReader br = new BufferedReader(new InputStreamReader(fis));
			String str = br.readLine();
			num = Integer.parseInt(str.trim());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		}
		return num;
	}

	private int readTotalOnlineNum() {
		File fileVec[] = this.dirFile.listFiles(new FileFilter() {
			public boolean accept(File f) {
				return f.getName().endsWith(".data");
			}
		});
		int totalNum = 0;
		for (int i = 0; i < fileVec.length; i++) {
			totalNum += readOnlineNumFile(fileVec[i]);
		}
		return totalNum;
	}

	private int readOnlineNumFile(File f) {
		FileInputStream fis = null;
		int num = 0;
		long time = 0;
		try {
			fis = new FileInputStream(f);
			BufferedReader br = new BufferedReader(new InputStreamReader(fis));
			String str1 = br.readLine();
			String str2 = br.readLine();
			time = Long.parseLong(str1.trim());
			num = Integer.parseInt(str2.trim());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		}
		long timeGap = System.currentTimeMillis() - time;
		if (timeGap < 0 || timeGap > 3 * 1000) {
			return 0;
		}
		return num;
	}

	private void storeOnlineNum() {
		long time = System.currentTimeMillis();
		int num = getSelfOnlineNum();
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(selfOnlineNumFile);
			StringBuffer sb = new StringBuffer();
			sb.append(time);
			sb.append("\r\n");
			sb.append(num);
			fos.write(sb.toString().getBytes());
			fos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (Exception e) {
				}
			}
		}
	}

	private int getSelfOnlineNum() {
		int cnum = StaticContext.getCSTSDoc().getOnlineUserNum();
		int totalnum = cnum;
		return totalnum;
	}

	private int calWeight(int onlineUser, int maxUser) {
		if (maxUser <= 1) {
			return 300;
		}
		double d = (double) onlineUser / maxUser;
		return (int) (d * 100.0);
	}

	public int getNetWeight() {
		if (isTotalCal) {
			int selfOnlineNumGap = getSelfOnlineNum() - total_lastSelfOnlineNum;
			int totalOnlineNum = Math.max(0, total_lastTotalOnlineNum
					+ selfOnlineNumGap);
			return calWeight(totalOnlineNum, total_lastMaxOnlineNum);
		} else {
			int onlineNum = getSelfOnlineNum();
			int maxUserNum = StaticContext.getCSConfigCaptain().getMaxUser();
			return calWeight(onlineNum, maxUserNum);
		}
	}
}
