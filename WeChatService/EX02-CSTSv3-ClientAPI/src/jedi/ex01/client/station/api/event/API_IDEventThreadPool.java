package jedi.ex01.client.station.api.event;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;


public class API_IDEventThreadPool {

	private static API_IDEventThreadPool instance = new API_IDEventThreadPool();

	private API_IDEventThreadPool() {
		super();
	}

	public static API_IDEventThreadPool getInstance() {
		return instance;
	}

	private ThreadPoolExecutor threadPool = new ThreadPoolExecutor(5, 20, 30, TimeUnit.SECONDS,
			new ArrayBlockingQueue<Runnable>(1), new ThreadPoolExecutor.CallerRunsPolicy());
	
	public void execute(Runnable exe){
		threadPool.execute(exe);
	}
	
	public void notifyEvent(API_IDEventListener listener,API_IDEvent event){
		execute(new _API_IDEventRunnable(event,listener));
	}

}

class _API_IDEventRunnable implements Runnable{
	
	private API_IDEventListener listener;
	private API_IDEvent event;
	
	_API_IDEventRunnable(API_IDEvent event, API_IDEventListener listener) {
		super();
		this.event = event;
		this.listener = listener;
	}

	public void run() {
		this.listener.onStationEvent(event);
	}
	
}
