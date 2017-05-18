package jedi.ex01.client.station.api.event;

import java.util.LinkedList;
import java.util.List;

public class API_IDEvent_Spanwser implements Runnable {
	private boolean isDestroy = false;
	private Thread eventThread = null;
	private API_IDEvent_EnquirerContainer container = new API_IDEvent_EnquirerContainer();

	private LinkedList<API_IDEvent> eventList = new LinkedList<API_IDEvent>();

	public void init() {
		isDestroy = false;
		eventThread = new Thread(this);
		eventThread.start();
	}

	public void destroy() {
		isDestroy = true;
		if (eventThread != null) {
			eventThread.interrupt();
		}
	}

	public void addListener(API_IDEventListener listener, String eventName) {
		container.addListener(listener, eventName);
	}

	public void removeListener(API_IDEventListener listener, String eventName) {
		container.removeListener(listener, eventName);
	}

	public void removeListener(API_IDEventListener listener) {
		container.removeListener(listener);
	}

	public void fireEventChanged(API_IDEvent event) {
		synchronized (eventList) {
			eventList.addFirst(event);
			eventList.notifyAll();
		}
	}

	private void _notifyEvent(API_IDEvent event) {
		List<API_IDEventListener> list = container.getEnquiredListeners(event
				.getEventName());
		for (API_IDEventListener listener : list) {
			try {
//				listener.onStationEvent(event);
				API_IDEventThreadPool.getInstance().notifyEvent(listener, event);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void run() {
		while (!isDestroy) {
			API_IDEvent event = null;
			synchronized (eventList) {
				if (!eventList.isEmpty()) {
					event = eventList.removeLast();
				}
			}
			if (event != null) {
				_notifyEvent(event);
			} else {
				synchronized (eventList) {
					try {
						eventList.wait(5000);
					} catch (Exception e) {
					}
				}
			}
		}
	}
}
