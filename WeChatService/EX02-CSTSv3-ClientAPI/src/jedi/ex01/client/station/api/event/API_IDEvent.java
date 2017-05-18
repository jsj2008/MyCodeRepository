package jedi.ex01.client.station.api.event;

public class API_IDEvent implements API_IDEvent_NameInterface {
	private String eventSourceID = "";
	private String eventName;
	private Object[] eventData;
	private boolean eventResult = true;

	public API_IDEvent() {
		this("");
	}

	public API_IDEvent(String eventName) {
		this(eventName, null, true, "");
	}

	public API_IDEvent(String eventName, Object[] eventData,
			boolean eventResult, String eventSourceID) {
		super();
		this.eventSourceID = eventSourceID;
		this.eventName = eventName;
		this.eventData = eventData;
		this.eventResult = eventResult;
	}

	public boolean isEventResult() {
		return eventResult;
	}

	public void setEventResult(boolean eventResult) {
		this.eventResult = eventResult;
	}

	public String getEventSourceID() {
		return eventSourceID;
	}

	public void setEventSourceID(String eventSourceID) {
		this.eventSourceID = eventSourceID;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public Object[] getEventData() {
		return eventData;
	}

	public void setEventData(Object[] eventData) {
		this.eventData = eventData;
	}
}
