package jedi.ex01.CSTS3.proxy.client.ping;

import java.util.LinkedList;

import jedi.ex01.CSTS3.comm.jsondata.CSTSPing;

public class PingCaptain implements Runnable {

	private static long TIMEOUTPING = 3000;

	private static int RECMAXNUM = 30;
	private static long PINGGAP = 3000;
	private static int PINGLOSTTIMES = 3;

	/**
	 * @param timeoutPing
	 *            ， ping大于，则认为ping超时
	 * @param pingGap
	 *            多长时间发起一次ping
	 * @param pingLostNumber
	 *            ping超时多少次，则断线
	 * @param recNum
	 *            记录ping的数量，用以计算ping的均值
	 */
	public static void setParams(long timeoutPing, long pingGap, int pingLostNumber, int recNum) {
		PingCaptain.TIMEOUTPING = timeoutPing;
		PingCaptain.RECMAXNUM = recNum;
		PingCaptain.PINGGAP = pingGap;
		PingCaptain.PINGLOSTTIMES = pingLostNumber;
	}

	public static long getTIMEOUTPING() {
		return TIMEOUTPING;
	}

	private static PingCaptain currentInstance = null;

	public static PingCaptain getCurrentInstance() {
		return currentInstance;
	}

	private PingDealerable pingDealer;
	private boolean isDestroy = false;
	private Thread pingThread = null;
	private LinkedList<PingPack> finishedPingList = new LinkedList<PingPack>();
	private LinkedList<PingPack> recentPingList = new LinkedList<PingPack>();
	private PingPack currentPingPack;

	public PingCaptain(PingDealerable pingDealer) {
		this.pingDealer = pingDealer;
		currentInstance = this;
	}

	public void init() {
		if (pingThread == null) {
			isDestroy = false;
			pingThread = new Thread(this);
			pingThread.start();
		}
	}

	public void destroy() {
		isDestroy = true;
		if (pingThread != null) {
			pingThread.interrupt();
			pingThread = null;
			synchronized (finishedPingList) {
				finishedPingList.clear();
			}
			recentPingList.clear();
			currentPingPack = null;
		}
	}

	public void run() {
		while (!isDestroy) {
			long timeUsed = doPing();
			long leftTime = PINGGAP - timeUsed;
			if (leftTime > 100) {
				try {
					Thread.sleep(leftTime);
				} catch (Exception e) {
				}
			}
		}
	}

	public void clearTimeoutRecords() {
		this.recentPingList.clear();
	}

	private long doPing() {
		long startTime = System.currentTimeMillis();
		CSTSPing ping = new CSTSPing();
		currentPingPack = new PingPack(ping);
		if (!pingDealer.sendPing(ping)) {
			currentPingPack = null;
		} else {
			currentPingPack.doWait();
			onPingFinished(currentPingPack);
			currentPingPack = null;
		}
		long endTime = System.currentTimeMillis();
		return endTime - startTime;
	}

	public void onPingReturn(CSTSPing ping) {
		if (currentPingPack == null) {
			return;
		}
		if (currentPingPack.getKey().equals(ping.getID())) {
			currentPingPack.pingReturn(ping);
		}
	}

	private void onPingFinished(PingPack pingPack) {
		if (!pingPack.isToIgnore()) {
			synchronized (finishedPingList) {
				finishedPingList.addFirst(pingPack);
				while (finishedPingList.size() > RECMAXNUM) {
					finishedPingList.removeLast();
				}
				recentPingList.addFirst(pingPack);
				while (recentPingList.size() > PINGLOSTTIMES) {
					recentPingList.removeLast();
				}
			}
		}
		notifyListener(getPingResult());
	}

	private void notifyListener(PingResult result) {
		// System.out.println(result);
		this.pingDealer.onPingResult(result);
	}

	private PingResult getPingResult() {
		PingResult pingResult = new PingResult();
		synchronized (finishedPingList) {
			if (finishedPingList.size() == 0) {
				pingResult.setNetTimeout(false);
				return pingResult;
			}
			PingPack firstpingpack = finishedPingList.getFirst();
			long curPing = firstpingpack.getPing();
			int totalNum = 0;
			int totalPing = 0;
			int totalLost = 0;
			int timeouttimesinfistpart = 0;
			for (PingPack pingPack : finishedPingList) {
				totalNum++;
				totalPing += pingPack.getPing();
				if (pingPack.isTimeout()) {
					totalLost++;
				}
			}
			int index = 0;
			for (PingPack pingPack : recentPingList) {
				if (pingPack.isTimeout()) {
					timeouttimesinfistpart++;
				}
				index++;
				if (index >= PINGLOSTTIMES) {
					break;
				}
			}
			pingResult.setNetTimeout(timeouttimesinfistpart >= PINGLOSTTIMES);
			if (totalNum != 0) {
				pingResult.setAvePing(totalPing / totalNum);
				pingResult.setLostPerc((double) totalLost / (double) totalNum);
			}
			pingResult.setPing(curPing);
		}
		return pingResult;
	}

	public void clear() {
		if (currentPingPack != null) {
			currentPingPack.ignore();
		}
		synchronized (finishedPingList) {
			this.finishedPingList.clear();
		}
	}

	public String getDebugInfo() {
		synchronized (finishedPingList) {
			StringBuffer sb = new StringBuffer();
			sb.append("-----------------");
			sb.append("\r\n");
			sb.append("Ping list number:");
			sb.append(finishedPingList.size());
			sb.append("\r\n");
			sb.append("-----------------");
			sb.append("\r\n");
			for (PingPack pingPack : finishedPingList) {
				sb.append("Ping: ");
				sb.append(pingPack.getPing());
				if (pingPack.isTimeout()) {
					sb.append(" [Timeout]");
				}
				sb.append("  key=");
				sb.append(pingPack.getKey());
				sb.append("\r\n");
			}
			sb.append("-----------------");
			sb.append("\r\n");
			return sb.toString();
		}
	}
}
