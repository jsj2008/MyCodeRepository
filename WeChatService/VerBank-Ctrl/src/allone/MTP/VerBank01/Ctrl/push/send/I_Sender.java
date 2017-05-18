package allone.MTP.VerBank01.Ctrl.push.send;

public interface I_Sender {

	// 指定发送给单个用户
	public void sendInfoToUser(String accountID, String info);

	public void sendInfoToAllUser(String info);

	//
	// public void sendInfoToGroups(String[] groups, String info);

	// // 广播多个用户
	// public void sendInfoToMultipleUser(ArrayList<IApnsService>
	// apnsServiceArray, String info);

	public void onDestroy();
}
