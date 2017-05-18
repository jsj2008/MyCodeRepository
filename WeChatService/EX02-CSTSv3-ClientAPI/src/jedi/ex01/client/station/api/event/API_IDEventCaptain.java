package jedi.ex01.client.station.api.event;

public class API_IDEventCaptain implements API_IDEvent_Invoker {
	private final static API_IDEventCaptain instance = new API_IDEventCaptain();

	public static API_IDEventCaptain getInstance() {
		return instance;
	}

	public static API_IDEvent_Invoker getIDEventInvoker() {
		return instance;
	}

	private boolean isInited = false;
	private API_IDEvent_Spanwser spanwser = new API_IDEvent_Spanwser();

	public synchronized void init() {
		if (isInited) {
			return;
		}
		spanwser.init();
		isInited = true;
	}

	public void destroy() {
		spanwser.destroy();
	}

	public void addListener(API_IDEventListener listener, String eventName) {
		spanwser.addListener(listener, eventName);
	}

	public void removeListener(API_IDEventListener listener, String eventName) {
		spanwser.removeListener(listener, eventName);
	}

	public void removeListener(API_IDEventListener listener) {
		spanwser.removeListener(listener);
	}

	public void fireEventChanged(API_IDEvent event) {
		if (!isInited) {
			init();
		}
		spanwser.fireEventChanged(event);
	}
	
	public static void fireEventChanged(boolean eventResult, String eventName, Object... eventData){
		getInstance().fireEventChanged(new API_IDEvent(eventName,eventData,eventResult,""));
	}

	public static void fireEventChanged(String eventName, Object... eventData){
		getInstance().fireEventChanged(new API_IDEvent(eventName,eventData,true,""));
	}
	
}
