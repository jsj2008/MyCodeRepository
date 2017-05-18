package cn.allone.weixin.user;


public class WeixinUserInfo {
	
	public enum Gender { MALE, FEMALE, UNKNOWN}
	
	String openId; // Open ID，公眾號中唯一。
	String nickname; // 暱稱。
	Gender gender; // 性別。
	String province; // 省份。
	String city; // 城市。
	String country; // 國家。
	String urlOfHeadImage; // 用戶頭像圖片的URL。
	String[] privileges; // 用戶權限。
	String unionId; // 微信開放平台中用戶的唯一識別號。
	
	public String getOpenId() { return openId;}
	public String getNickname() { return nickname;}
	public Gender getGender() { return gender;}
	public String getProvince() { return province;}
	public String getCity() { return city;}
	public String getCountry() { return country;}
	public String getUrlOfHeadImage() { return urlOfHeadImage;}
	public String[] getPrivileges() { return privileges;}
	public String getUnionId() { return unionId;}
	
	public void setOpenId( String value) { openId = value;}
	public void setNickname( String value) { nickname = value;}
	public void setGender( Gender value) { gender = value;}
	public void setProvince( String value) { province = value;}
	public void setCity( String value) { city = value;}
	public void setCountry( String value) { country = value;}
	public void setUrlOfHeadImage( String value) { urlOfHeadImage = value;}
	public void setPrivileges( String value[]) { privileges = value;}
	public void setUnionId( String value) { unionId = value;}
	
}
