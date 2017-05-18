package jedi.ex01.client.station.api.event;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

public class API_IDEvent_Enquirer {
	private API_IDEventListener listener;
	private HashSet<String> enquiredEventNameSet = new HashSet<String>();

	public API_IDEvent_Enquirer(API_IDEventListener listener) {
		this.listener = listener;
	}

	public API_IDEventListener getListener() {
		return listener;
	}

	public void addEventName(String eventName) {
		synchronized (enquiredEventNameSet) {
			this.enquiredEventNameSet.add(eventName);
		}
	}

	public void removeEventName(String eventName) {
		synchronized (enquiredEventNameSet) {
			this.enquiredEventNameSet.remove(eventName);
		}
	}

	public boolean containsEvent(String eventName) {
		synchronized (enquiredEventNameSet) {
			return enquiredEventNameSet.contains(eventName);
		}
	}

	public int eventSize() {
		synchronized (enquiredEventNameSet) {
			return enquiredEventNameSet.size();
		}
	}

	public List<String> getEventNameList() {
		synchronized (enquiredEventNameSet) {
			ArrayList<String> list = new ArrayList<String>(enquiredEventNameSet
					.size());
			Iterator<String> it = enquiredEventNameSet.iterator();
			while (it.hasNext()) {
				list.add(it.next());
			}
			return list;
		}
	}
}
