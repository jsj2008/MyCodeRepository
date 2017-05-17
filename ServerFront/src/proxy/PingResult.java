package proxy;

public class PingResult {
	private long ping;
	private long avePing;
	private double lostPerc;
	public long getPing() {
		return ping;
	}
	public void setPing(long ping) {
		this.ping = ping;
	}
	public long getAvePing() {
		return avePing;
	}
	public void setAvePing(long avePing) {
		this.avePing = avePing;
	}
	public double getLostPerc() {
		return lostPerc;
	}
	public void setLostPerc(double lostPerc) {
		this.lostPerc = lostPerc;
	}
}
