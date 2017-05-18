package cn.allone.weixin.json;

public class JsonAuth {
	
	public String access_token;
	public Long expires_in;
	public Integer errcode;
	public String errmsg;
	
	@Override
	public String toString() {
		return "access_token: " + access_token + " , expires_in: " + expires_in + ", errcode: " + errcode + " , errmsg: " + errmsg;
	}
	
}
