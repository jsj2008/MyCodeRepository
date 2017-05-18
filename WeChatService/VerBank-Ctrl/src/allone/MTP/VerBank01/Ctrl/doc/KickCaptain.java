package allone.MTP.VerBank01.Ctrl.doc;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.IP_CtrlCSTS2001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.IP_CtrlCSTS2003;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.OP_CtrlCSTS2001;
import allone.MTP.VerBank01.Ctrl.comm.structure.UserMsgNode;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class KickCaptain {

	private static KickCaptain instance = new KickCaptain();

	public static KickCaptain getInstance() {
		return instance;
	}

	private HashMap<String, LinkedList<UserMsgNode>> userMap = new HashMap<String, LinkedList<UserMsgNode>>();

	public void init() {
		destroy = false;
		new KickThread().start();
	}

	public void destroy() {
		destroy = true;
	}

	private boolean destroy = false;

	private void runKickUser() {
		while (!destroy) {
			synchronized (userMap) {
				userMap.clear();
				String cstsServNameVec[] = StaticContext.getConfigCaptain().getCstsNames();
				// LinkedList<UserMsgNode> list = new LinkedList<UserMsgNode>();
				for (int i = 0; i < cstsServNameVec.length; i++) {
					String cstsName = cstsServNameVec[i];
					IP_CtrlCSTS2001 ip2001 = new IP_CtrlCSTS2001();
					ip2001.setType(IP_CtrlCSTS2001.TYPE_ALL);
					OPFather tempop = StaticContext.getCadtsCaptain().trade(cstsName, ip2001);
					if (tempop.isSucceed()) {
						OP_CtrlCSTS2001 op2001 = (OP_CtrlCSTS2001) tempop;
						for (UserMsgNode node : op2001.getUserList()) {
							LinkedList<UserMsgNode> uList = userMap.get(node.getUserName());
							if (uList == null) {
								uList = new LinkedList<UserMsgNode>();
								userMap.put(node.getUserName(), uList);
							}
							uList.add(node);
						}
					}
				}
				for (LinkedList<UserMsgNode> uList : userMap.values()) {
					if (uList.size() <= 0) {
						continue;
					}
					int maxOnlineNum = 1;
					if (uList.size() <= maxOnlineNum) {
						continue;
					}
					Collections.sort(uList, new Comparator<UserMsgNode>() {

						@Override
						public int compare(UserMsgNode o1, UserMsgNode o2) {
							if (o1.getLastLoginTime() > o2.getLastLoginTime()) {
								return -1;
							} else if (o1.getLastLoginTime() < o2.getLastLoginTime()) {
								return 1;
							} else {
								return 0;
							}
						}
					});
					UserMsgNode first = uList.getFirst();
					while (uList.size() > maxOnlineNum) {
						UserMsgNode node = uList.removeLast();
						IP_CtrlCSTS2003 ip2003 = new IP_CtrlCSTS2003();
						ip2003.setNewUserIP(first.getUserIp());
						ip2003.setUserGuid(node.getUserGUID());
						ip2003.setUserName(node.getUserName());
						StaticContext.getCadtsCaptain().trade(node.getCSTSName(), ip2003);
					}
				}
			}

			try {
				Thread.sleep(20 * 1000);
			} catch (Exception e) {
				LogProxy.printException(e);
			}
		}
	}

	class KickThread extends Thread {

		public void run() {
			runKickUser();
		}
	}

}
