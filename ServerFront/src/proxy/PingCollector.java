package proxy;

import java.util.HashMap;
import java.util.LinkedList;

import comm.DealerPing;

public class PingCollector {

	private static final int RECNUM = 30;
	private static final int MAXPING = 6000;
	private static final int NETLOSTPING = 4000;
	private static final long MAXTIMEGAP = 30 * 10 * 1000;
	private DealerPing ping = null;
	private LinkedList<Long> recList = new LinkedList<Long>();
	private HashMap<Long, DealerPing> pingMap = new HashMap<Long, DealerPing>();

	public DealerPing createPing() {
		DealerPing tempping = new DealerPing();
		synchronized (recList) {
			pingMap.put(tempping.getStartTime(), tempping);
		}
		return tempping;
	}

	public void returnPing(DealerPing ping) {
		ping.pingReturned();
		this.ping = ping;
		synchronized (recList) {
			if (recList.size() > RECNUM) {
				recList.removeLast();
			}
			recList.addFirst(ping.getPing());
			pingMap.remove(ping.getStartTime());
		}
	}

	private PingResult getPingResult() {
		PingResult pr = new PingResult();
		if (ping != null) {
			pr.setPing(ping.getPing());
		} else {
			pr.setPing(-1);
		}
		int totalNum = 0;
		int totalPing = 0;
		int totalLost = 0;
		synchronized (recList) {
			for (long tempp : recList) {
				totalNum++;
				totalPing += tempp;
				if (tempp > NETLOSTPING) {
					totalLost++;
				}
			}
			Long temptimevec[] = (Long[]) pingMap.keySet().toArray(new Long[0]);
			long currentTime = System.currentTimeMillis();
			for (long temptime : temptimevec) {
				if (currentTime - temptime > MAXTIMEGAP) {
					pingMap.remove(temptime);
				} else if (currentTime - temptime > NETLOSTPING) {
					totalNum++;
					totalPing += MAXPING;
					totalLost++;
				}
			}
		}
		if (totalNum != 0) {
			pr.setAvePing(totalPing / totalNum);
			pr.setLostPerc((double) totalLost / (double) totalNum);
		}
		return pr;
	}

	public PingResult removePing() {
		PingResult pr = getPingResult();
		ping = null;
		return pr;
	}

	public PingResult getPing() {
		return getPingResult();
	}

	public static void main(String args[]) {
		long l1 = 100;
		long l2 = 1;
		System.out.println((double) l2 / (double) l1);
	}
}
