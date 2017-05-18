package jedi.ex01.client.station.api.event;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class API_IDEvent_EnquirerContainer {
	private HashMap<String, LinkedList<API_IDEventListener>> listenerListMapByEventName = new HashMap<String, LinkedList<API_IDEventListener>>();
	private HashMap<API_IDEventListener, API_IDEvent_Enquirer> eventEnquirerMapByListener = new HashMap<API_IDEventListener, API_IDEvent_Enquirer>();
	private Object containerLock = new Object();

	public List<API_IDEventListener> getEnquiredListeners(String eventName) {
		synchronized (containerLock) {
			if (listenerListMapByEventName.containsKey(eventName)) {
				return Collections.unmodifiableList(listenerListMapByEventName
						.get(eventName));
			} else {
				return new LinkedList<API_IDEventListener>();
			}
		}
	}

	public void addListener(API_IDEventListener listener, String eventName) {
		synchronized (containerLock) {
			API_IDEvent_Enquirer see = null;
			if (eventEnquirerMapByListener.containsKey(listener)) {
				see = eventEnquirerMapByListener.get(listener);
			} else {
				see = new API_IDEvent_Enquirer(listener);
				eventEnquirerMapByListener.put(listener, see);
			}
			if (!see.containsEvent(eventName)) {
				see.addEventName(eventName);
				LinkedList<API_IDEventListener> listenerList = null;
				if (listenerListMapByEventName.containsKey(eventName)) {
					listenerList = listenerListMapByEventName.get(eventName);
				} else {
					listenerList = new LinkedList<API_IDEventListener>();
					listenerListMapByEventName.put(eventName, listenerList);
				}
				listenerList.add(listener);
			}
		}
	}

	public void removeListener(API_IDEventListener listener, String eventName) {
		synchronized (containerLock) {
			if (!eventEnquirerMapByListener.containsKey(listener)) {
				return;
			}
			API_IDEvent_Enquirer see = eventEnquirerMapByListener.get(listener);
			if (!see.containsEvent(eventName)) {
				return;
			}
			see.removeEventName(eventName);
			listenerListMapByEventName.get(eventName).remove(listener);
			if (see.eventSize() == 0) {
				removeListener(listener);
			}
		}
	}

	public void removeListener(API_IDEventListener listener) {
		synchronized (containerLock) {
			if (!eventEnquirerMapByListener.containsKey(listener)) {
				return;
			}
			API_IDEvent_Enquirer see = eventEnquirerMapByListener
					.remove(listener);
			List<String> eventList = see.getEventNameList();
			Iterator<String> it = eventList.iterator();
			while (it.hasNext()) {
				String eventName = it.next();
				listenerListMapByEventName.get(eventName).remove(listener);
			}
		}
	}

}
