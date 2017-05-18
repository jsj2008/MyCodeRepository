package allone.register.server.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.StringWriter;
import java.nio.charset.Charset;
import java.util.Map;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

public class XMLBeanUtil {
	private static final String ENCODING = "GBK";
	private static final Charset ENCODING_CHARSET = Charset.forName(ENCODING);

	public static String marshall(Object obj) throws JAXBException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		JAXBContext ctx = JAXBContext.newInstance(obj.getClass());
		Marshaller marshaller = ctx.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_ENCODING, ENCODING);
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		marshaller.marshal(obj, baos);
		byte[] buf = baos.toByteArray();
		return new String(buf, ENCODING_CHARSET);
	}

	private static DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	private static DocumentBuilder createDocumentBuilder;

	private static DocumentBuilder getCreateDocumentBuilder() throws ParserConfigurationException {
		if (createDocumentBuilder == null) {
			createDocumentBuilder = dbf.newDocumentBuilder();
		}
		return createDocumentBuilder;
	}

	public static Document newDocument() throws Exception {
		Document doc = getCreateDocumentBuilder().newDocument();
		doc.setXmlStandalone(true);
		return doc;
	}

	public static String marshallToMap(Object obj, Map<String, String> map) throws Exception {
		JAXBContext ctx = JAXBContext.newInstance(obj.getClass());
		Marshaller marshaller = ctx.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_ENCODING, ENCODING);
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		setupMap(obj, map, marshaller);
		String xmlText = toXML(obj, marshaller);
		return xmlText;
	}

	private static void setupMap(Object obj, Map<String, String> map, Marshaller marshaller) throws Exception {
		Document doc = newDocument();
		Element root = doc.createElement("temp");
		marshaller.marshal(obj, root);
		Node field = root.getFirstChild().getFirstChild();
		Element el = null;
		while (field != null) {
			if (field instanceof Element) {
				el = (Element) field;
				String key = el.getNodeName();
				String value = el.getTextContent();
				map.put(key, value);
			}
			field = field.getNextSibling();
		}
	}

	private static String toXML(Object obj, Marshaller marshaller) throws JAXBException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		marshaller.marshal(obj, baos);

		byte[] buf = baos.toByteArray();
		return new String(buf, ENCODING_CHARSET);
	}

	@SuppressWarnings("unchecked")
	public static <T> T unmarshall(Class<T> cls, String resXML) throws JAXBException {
		JAXBContext context = JAXBContext.newInstance(cls);
		Unmarshaller unmarshall = context.createUnmarshaller();
		ByteArrayInputStream bais = new ByteArrayInputStream(resXML.getBytes(ENCODING_CHARSET));
		return (T) unmarshall.unmarshal(bais);
	}

	@SuppressWarnings("unchecked")
	public static <T> T unmarshall(Class<T> cls, File xmlFile) throws JAXBException {
		JAXBContext context = JAXBContext.newInstance(cls);
		Unmarshaller unmarshall = context.createUnmarshaller();
		return (T) unmarshall.unmarshal(xmlFile);
	}

	/**
	 * 格式化xml
	 * 
	 * @param input
	 * @return
	 */
	public static String prettyFormatXml(String srcStr) {
		if (srcStr == null) {
			return null;
		}
		return prettyFormat(srcStr.getBytes(ENCODING_CHARSET), 4);
	}

	public static String prettyFormat(byte[] input, int indent) {
		try {
			Source xmlInput = new StreamSource(new ByteArrayInputStream(input));
			StringWriter stringWriter = new StringWriter();
			StreamResult xmlOutput = new StreamResult(stringWriter);
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			transformerFactory.setAttribute("indent-number", indent);
			Transformer transformer = transformerFactory.newTransformer();
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.transform(xmlInput, xmlOutput);
			return xmlOutput.getWriter().toString();
		} catch (Exception e) {
			return new String(input, Charset.forName(ENCODING));
		}
	}
}
