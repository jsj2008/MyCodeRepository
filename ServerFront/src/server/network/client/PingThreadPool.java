package server.network.client;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class PingThreadPool {

	private static PingThreadPool instance = new PingThreadPool();

	private PingThreadPool() {
		super();
	}

	public static PingThreadPool getInstance() {
		return instance;
	}

	private ThreadPoolExecutor threadPool = new ThreadPoolExecutor(10, 200, 10, TimeUnit.SECONDS,
			new ArrayBlockingQueue<Runnable>(3), new ThreadPoolExecutor.CallerRunsPolicy());
	
	public void execute(Runnable exe){
		threadPool.execute(exe);
	}

}
