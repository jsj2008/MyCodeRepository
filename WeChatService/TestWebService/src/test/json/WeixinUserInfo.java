package test.json;


public class WeixinUserInfo {
public enum Gender { MALE, FEMALE, UNKNOWN}
	
	String openId; // Open ID������̖��Ψһ��
	String nickname; // ���Q��
	Gender gender; // �Ԅe��
	String province; // ʡ�ݡ�
	String city; // ���С�
	String country; // ���ҡ�
	String urlOfHeadImage; // �Ñ��^��DƬ��URL��
	String[] privileges; // �Ñ����ޡ�
	String unionId; // ΢���_��ƽ̨���Ñ���Ψһ�R�e̖��
	
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
