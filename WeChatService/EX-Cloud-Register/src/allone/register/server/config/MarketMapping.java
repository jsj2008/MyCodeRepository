package allone.register.server.config;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class MarketMapping {
	@XmlElement(name = "item")
	private List<MarketMappingItem> marketList;

	public List<MarketMappingItem> getMarketList() {
		return marketList;
	}

	public void setMarketList(List<MarketMappingItem> marketList) {
		this.marketList = marketList;
	}
}
