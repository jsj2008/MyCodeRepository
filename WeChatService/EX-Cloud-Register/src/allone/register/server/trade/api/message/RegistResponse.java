package allone.register.server.trade.api.message;

import net.sf.json.JSONObject;

public class RegistResponse extends ECRResponse {
	public String responseToJson() {
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("isSuccess", isSuccess);
		jsonObject.put("errCode", responseCode);
		jsonObject.put("errMessage", responseMessage);
		
		return jsonObject.toString();
	}
}
