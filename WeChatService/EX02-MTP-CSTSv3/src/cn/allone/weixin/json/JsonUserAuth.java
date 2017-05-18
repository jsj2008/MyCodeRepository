package cn.allone.weixin.json;

public class JsonUserAuth {
	
	public String access_token;
	public Long expires_in;
	public String refresh_token;
	public String openid;
	public String scope;
	public Long errcode;
	public String errmsg;
   
	@Override
	public String toString() {
		return 
			"access_token: " + access_token + 
			" , expires_in: " + expires_in + 
			", refresh_token: " + refresh_token + 
			" , openid: " + openid + 
			" , scope: " + scope +
			" , errcode: " + errcode +
			" , errmsg: " + errmsg;
	}
	
}
