package test.json;


public class JsonWeixinUserInfo {
	public String openid;
	public String nickname;
	public Long sex;
	public String province;
	public String city;
	public String country;
	public String headimgurl; 
	public String[] privilege;
	public String unionid; // ����̖������΢���_��ƽ̨��ŕ���ֵ��
	public Long errcode;
	public String errmsg;
	
	@Override
	public String toString() {
		return 
			"openid: " + openid + 
			" , nickname: " + nickname + 
			" , sex: " + sex + 
			" , province: " + province + 
			" , city: " + city +
			" , country: " + country +
			" , headimgurl: " + headimgurl +
			" , privilege: " + privilege +
			" , unionid: " + unionid +
			" , errcode: " + errcode +
			" , errmsg: " + errmsg;
	}
}
