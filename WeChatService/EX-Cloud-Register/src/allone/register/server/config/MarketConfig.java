package allone.register.server.config;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "marketConfig")
@XmlAccessorType(XmlAccessType.FIELD)
public class MarketConfig {
	@XmlElement(name = "marketMapping")
	private MarketMapping marketCfg;
	@XmlElement(name = "marketId")
	private int marketId;
	@XmlElement(name = "userGroup")
	private String userGroup;

	public MarketMapping getMarketCfg() {
		return marketCfg;
	}

	public void setMarketCfg(MarketMapping marketCfg) {
		this.marketCfg = marketCfg;
	}

	public int getMarketId() {
		return marketId;
	}

	public void setMarketId(int marketId) {
		this.marketId = marketId;
	}

	public String getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(String userGroup) {
		this.userGroup = userGroup;
	}
	

}
