package jedi.ex01.client.station.api.bankserver;

import java.util.LinkedHashMap;
import java.util.Map;

import allone.xml.parser.XMLCaptain;
import allone.xml.parser.XMLNode;

import com.ximpleware.VTDGen;
import com.ximpleware.VTDNav;

public class BankMetadataBuilder {

	public static IBankMetadata unmarshall(String source) throws Exception {
		VTDGen vg = new VTDGen();
		vg.setDoc(source.getBytes("UTF-8"));
		vg.parse(true);
		VTDNav vnNav = vg.getNav();
		vnNav.toElement(VTDNav.ROOT);
		String name = vnNav.toString(vnNav.getCurrentIndex());
		CommMetaData data = new CommMetaData(name);
		int idx = vnNav.getAttrVal("dwneed");
		if (idx >= 0) {
			boolean dwneed = Boolean.valueOf(vnNav.toString(idx));
			data.setDwneed(dwneed);
		}
		// idx = vnNav.getAttrVal("updateUserinfo");
		// if (idx>=0){
		// boolean updateUserinfo=Boolean.valueOf(vnNav.toString(idx));
		// data.setUpdateUserinfo(updateUserinfo);
		// }

		if (vnNav.toElement(VTDNav.FIRST_CHILD, "signNotice")) {
			int index = vnNav.getText();
			if (index >= 0) {
				String signNotice = vnNav.toString(index);
				data.setSignNotice(signNotice);
				vnNav.toElement(VTDNav.PARENT);
			}
		}

		Map<String, String> bankCodeMap = new LinkedHashMap<String, String>();
		if (vnNav.toElement(VTDNav.FIRST_CHILD, "BankCodeMap")) {
			do {
				if (vnNav.toElement(VTDNav.FIRST_CHILD, "item")) {
					do {
						String key = null;
						String value = null;
						int index = vnNav.getAttrVal("key");
						if (index >= 0) {
							key = vnNav.toString(index);
						}
						index = vnNav.getAttrVal("value");
						if (index >= 0) {
							value = vnNav.toString(index);
						}
						bankCodeMap.put(key, value);
					} while (vnNav.toElement(VTDNav.NEXT_SIBLING, "item"));
					vnNav.toElement(VTDNav.PARENT);
				}
			} while (vnNav.toElement(VTDNav.NEXT_SIBLING, "BankCodeMap"));
			vnNav.toElement(VTDNav.PARENT);
		}
		if (!bankCodeMap.isEmpty()) {
			data.setBankCodeMap(bankCodeMap);
		}

		Map<String, String> otherInfoMap = new LinkedHashMap<String, String>();
		if (vnNav.toElement(VTDNav.FIRST_CHILD, "OtherInfoMap")) {
			idx = vnNav.getAttrVal("fromGW");
			if (idx >= 0) {
				boolean _fromGW = Boolean.valueOf(vnNav.toString(idx));
				data.set_fromGW(_fromGW);
			}
			idx = vnNav.getAttrVal("anotherStreamID");
			if (idx >= 0) {
				boolean _anotherStreamID = Boolean.valueOf(vnNav.toString(idx));
				data.set_anotherStreamID(_anotherStreamID);
			}

			do {
				if (vnNav.toElement(VTDNav.FIRST_CHILD, "item")) {
					do {
						String key = null;
						String value = null;
						int index = vnNav.getAttrVal("key");
						if (index >= 0) {
							key = vnNav.toString(index);
						}
						index = vnNav.getAttrVal("value");
						if (index >= 0) {
							value = vnNav.toString(index);
						}
						otherInfoMap.put(key, value);
					} while (vnNav.toElement(VTDNav.NEXT_SIBLING, "item"));
					vnNav.toElement(VTDNav.PARENT);
				}
			} while (vnNav.toElement(VTDNav.NEXT_SIBLING, "OtherInfoMap"));
			vnNav.toElement(VTDNav.PARENT);
		}
		// if (!otherInfoMap.isEmpty()) {
		data.setOtherInfoMap(otherInfoMap);
		// }

		if (vnNav.toElement(VTDNav.FIRST_CHILD, "PublicNotice")) {
			String notice = vnNav.toString(vnNav.getText());
			data.setNotice(notice);
			vnNav.toElement(VTDNav.PARENT);
		}

		return data;
	}

	public static String marshall(IBankMetadata bankMetadata) throws Exception {
		String xmlString = null;
		if (bankMetadata instanceof CommMetaData) {
			CommMetaData data = (CommMetaData) bankMetadata;
			XMLNode xml = new XMLNode();
			xml.setName(data.getBankID());
			xml.setPro("dwneed", Boolean.toString(data.isDwneed()));
			// xml.setPro("updateUserinfo",
			// Boolean.toString(data.isUpdateUserinfo()));

			if (!(null == data.getSignNotice() || "".equals(data
					.getSignNotice().trim()))) {
				XMLNode subSignNoticeXml = new XMLNode();
				subSignNoticeXml.setName("signNotice");
				xml.addSubNode(subSignNoticeXml);
				subSignNoticeXml.setValue(data.getSignNotice());
			}

			if (data.getBankCodeMap() != null) {
				XMLNode subxml = new XMLNode();
				subxml.setName("BankCodeMap");
				xml.addSubNode(subxml);
				Map<String, String> map = data.getBankCodeMap();
				for (Map.Entry<String, String> entry : map.entrySet()) {
					XMLNode xNode = new XMLNode();
					xNode.setName("item");
					xNode.setPro("key", entry.getKey());
					xNode.setPro("value", entry.getValue());
					subxml.addSubNode(xNode);
				}
			}
			if (data.getOtherInfoMap() != null) {
				XMLNode subxml = new XMLNode();
				subxml.setName("OtherInfoMap");
				xml.addSubNode(subxml);
				subxml.setPro("fromGW", Boolean.toString(data.is_fromGW()));
				subxml.setPro("anotherStreamID",
						Boolean.toString(data.is_anotherStreamID()));
				Map<String, String> map = data.getOtherInfoMap();
				for (Map.Entry<String, String> entry : map.entrySet()) {
					XMLNode xNode = new XMLNode();
					xNode.setName("item");
					xNode.setPro("key", entry.getKey());
					xNode.setPro("value", entry.getValue());
					subxml.addSubNode(xNode);
				}
			}

			xmlString = XMLCaptain.format(xml);
		}

		return xmlString;
	}

	// public static void main(String[] args) throws Exception {
	// File path = new
	// File("E:\\tomcat\\webapps\\JEDIv7-BankServer\\WEB-INF\\config\\bank");
	//
	// for (File file : path.listFiles()) {
	// String str = FileUtil
	// .readFile(
	// "E:\\tomcat\\webapps\\JEDIv7-BankServer\\WEB-INF\\config\\bank\\ABC.xml"
	// );
	// String str = FileUtil.readFile(file);
	// IBankMetadata data = unmarshall(str);
	// System.out.println(data.getBankID());
	// String string = marshall(data);
	// System.out.println(string);
	// }
	// }

	// public static void main(String[] args) {
	// String source = "1<abc";
	// int index = source.indexOf("<");
	// if (index > 0) {
	// source = source.substring(index);
	// }
	// System.out.println(source);
	//
	// System.out.println(System.getProperty("file.encoding"));
	// try {
	// unmarshall(FileUtil.readFile(new File(
	// "E:\\tomcat\\webapps\\JEDIv7-BankServer\\WEB-INF\\config\\bank\\GOPAY.xml")
	// ));
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
}
