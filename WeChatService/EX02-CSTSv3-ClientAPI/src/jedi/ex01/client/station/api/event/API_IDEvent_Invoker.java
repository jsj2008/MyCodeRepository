package jedi.ex01.client.station.api.event;

public interface API_IDEvent_Invoker {
	public void addListener(API_IDEventListener listener, String eventName);

	public void removeListener(API_IDEventListener listener, String eventName);

	public void removeListener(API_IDEventListener listener);

	public void fireEventChanged(API_IDEvent event);
}
