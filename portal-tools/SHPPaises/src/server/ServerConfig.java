package server;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

public class ServerConfig {

	private final String XML_FILE = "server_config.xml";
	private final String XML_GOOD_RECORDS = "good_records";
	private final String XML_IP_ADDR = "ip_addr";
	private final String XML_PORT = "port";
	private final String XML_NAME = "name";
	private final String XML_CONTENT = "content";
	private static ServerConfig instance;

	private ServerConfig() {
		init();
	}

	public static ServerConfig getInstance() {
		if (instance == null) {
			instance = new ServerConfig();
		}
		return instance;
	}

	/**
	 * login of the user of the database
	 */
	public String database_user;
	/**
	 * password for the user login of the database
	 */
	public String database_password;
	/**
	 * name of the table in which the good records are inserted
	 */
	public String dbTableGoods;
	/**
	 * name of the table of the records to work
	 */
	public String dbTableRecords;
	/**
	 * ip address of the database host
	 */
	public String dbIPAddress;
	/**
	 * network port to connect to the database
	 */
	public String database_port;
	/**
	 * name of the database
	 */
	public String database_name;
	/**
	 * names of the columns of the environmental variables data
	 */
	public Set<String> dbVariablesName;
	/**
	 * name of the of the counter of outlier
	 */
	public String dbOutlierCount;
	/**
	 * network port to connect through RMI
	 */
	public int rmi_port;

	/**
	 * Initialize the variables of the server configuration. It must be called
	 * at the beginning otherwise there will be a error if they are used
	 */
	private void init() {
		try {
			File file = new File(XML_FILE);
			/**
			 * if the configuration file does not exist yet, then create the
			 * default one
			 */
			if (!file.exists()) {
				createDeafaultXML();
			}
			readFromXML();
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	private void readFromXML() throws JDOMException, IOException {
		SAXBuilder builder = new SAXBuilder(false);
		Document doc = builder.build(new File(XML_FILE));
		Element config = doc.getRootElement();

		Element rmi = config.getChild("rmi");
		rmi_port = Integer.parseInt(rmi.getAttributeValue(XML_PORT));

		Element database = config.getChild("database");
		dbIPAddress = database.getAttributeValue(XML_IP_ADDR);
		database_name = database.getAttributeValue(XML_NAME);
		database_port = database.getAttributeValue(XML_PORT);
		database_user = database.getChild("user").getTextTrim();
		database_password = database.getChild("password").getTextTrim();
		List<Element> tables = (List<Element>) database.getChild("tables")
				.getChildren();
		for (Element table : tables) {

			String content = table.getAttribute("content").getValue();

			if (content.equalsIgnoreCase(XML_GOOD_RECORDS)) {
				dbTableGoods = table.getTextTrim();
				List<Element> vars = (List<Element>) table.getChildren();
				dbVariablesName = new LinkedHashSet<String>();
				for (Element variable : vars) {
					if (variable.getAttributeValue(XML_CONTENT)
							.equalsIgnoreCase("variable")) {
						dbVariablesName.add(variable.getTextTrim());
					} else {
						if (variable.getAttributeValue(XML_CONTENT)
								.equalsIgnoreCase("outlier_count")) {
							dbOutlierCount = variable.getTextTrim();
						}
					}
				}
			} else {
				// unknow table;
			}
		}

	}

	public static void main(String[] args) {
		ServerConfig.getInstance();
	}

	private void createDeafaultXML() throws JDOMException, IOException {

		Element config = new Element("config");

		Element rmi = new Element("rmi");
		rmi.setAttribute(XML_PORT, "1099");

		Element database = new Element("database");
		// portal_gbif
		database.setAttribute(XML_NAME, "portal");
		database.setAttribute(XML_IP_ADDR, "localhost");
		database.setAttribute(XML_PORT, "3306");
		Element user = new Element("user");
		user.setAttribute("name", "server");
		user.setText("root");
		Element password = new Element("password");
		password.setAttribute("user", "server");
		// TODO encriptar clave
		password.setText("*******");
		Element tables = new Element("tables");
		Element records = new Element("table");
		records.setAttribute("content", XML_GOOD_RECORDS);
		records.setText("occurrence_record");

		database.addContent(user);
		database.addContent(password);
		tables.addContent(records);
		database.addContent(tables);
		config.addContent(rmi);
		config.addContent(database);
		Document doc = new Document(config);

		XMLOutputter outp = new XMLOutputter();
		outp.setFormat(Format.getPrettyFormat());
		FileOutputStream file = new FileOutputStream(XML_FILE);
		outp.output(doc, file);

		file.flush();
		file.close();
		// outp.output(doc, System.out);
	}

}
