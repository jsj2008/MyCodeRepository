package server.start;


public class ServerCaptain {
	private static String configPath;
	private static boolean isDestroy = false;

	public static void setConfigPath(String cfgPath) {
		ServerCaptain.configPath = cfgPath;
	}

	public static boolean initCaptain() {

		if (!initCfgCaptain(ServerCaptain.configPath)) {
			return false;
		}

		if (!ServerContext.getDBOperatorCaptain().init()) {
			return false;
		}
		
		if (!ServerContext.getNetCaptain().init()) {
			return false;
		}
		
//		try {
//			UserDao dao = ServerContext.getDBOperatorCaptain().getDBOperator(UserDao.class);
//			User[] datas = dao.queryAll();
//			System.out.println();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

		return true;
	}

	public static boolean destroy() {
		isDestroy = true;
		return true;
	}

	private static boolean initCfgCaptain(String cfgPath) {
		return ServerContext.getConfigCaptain().init(cfgPath);
	}

}
