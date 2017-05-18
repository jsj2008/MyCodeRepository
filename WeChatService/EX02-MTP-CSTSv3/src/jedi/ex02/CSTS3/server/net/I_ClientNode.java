package jedi.ex02.CSTS3.server.net;

import java.util.HashSet;

import allone.json.AbstractJsonData;

public interface I_ClientNode {
	
	public void dealWithInData(AbstractJsonData data);
	
	public void addObjectToSend(Object obj);
	
	public int getType();
	
	public long getFirstLoginTime();
	
	public void onDestroy();
	
	public void destroy();
	
	public String getAeid();
	
	public String[] getFixedIPAddress();
	
	public String getIpAddress();
	
	public long getLoginTime();
	
	public String get_hashID();
	
	public int getMaxOnlineNum();
	
	public HashSet<String> getGroupSet();
	
	public void kickedOut(final String kickerIPAddress);

}
