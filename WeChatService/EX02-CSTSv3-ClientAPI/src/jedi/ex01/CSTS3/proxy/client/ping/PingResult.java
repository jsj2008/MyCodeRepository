package jedi.ex01.CSTS3.proxy.client.ping;

import java.text.NumberFormat;

public class PingResult {
	private boolean isNetTimeout=false;

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

	public boolean isNetTimeout() {
		return isNetTimeout;
	}

	public void setNetTimeout(boolean isNetTimeout) {
		this.isNetTimeout = isNetTimeout;
	}
	
	public String toString(){
		NumberFormat nf=NumberFormat.getPercentInstance();
		StringBuffer sb=new StringBuffer();
		sb.append("[Ping] Is timeout :");
		sb.append(isNetTimeout);
		sb.append(" , ping= ");
		sb.append(ping);
		sb.append(", ave ping= ");
		sb.append(avePing);
		sb.append(",lost per= ");
		sb.append(nf.format(lostPerc));
		return sb.toString();
	}
}
