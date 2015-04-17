package server.database;

import java.util.Date;
import java.util.List;

import iserver.IResultServer;
import iserver.IWorkServer;
import model.Record;
import server.ServerConfig;

public class PortalInterface implements IWorkServer, IResultServer {

	private static PortalInterface instance;

	/**
	 * @uml.property name="portal"
	 * @uml.associationEnd multiplicity="(1 1)" ordering="true"
	 *                     inverse="base:server.database.PortalManager"
	 */
	private PortalManager portal;

	private PortalInterface() {
		DataBaseManager.registerDriver();
		portal = new PortalManager(DataBaseManager.openConnection(
				ServerConfig.getInstance().database_user,
				ServerConfig.getInstance().database_password));
	}

	public static PortalInterface getInstance() {
		if (instance == null) {
			instance = new PortalInterface();
		}
		return instance;
	}

	@Override
	public List<Record> getWork(String clientName) {
		List<Record> records = portal.getRecords();
		if (records.size() > 0) {
			System.out.println("> Sending " + records.size() + " ["
					+ records.get(0).getId() + "-"
					+ records.get(records.size() - 1).getId() + "] to ["
					+ clientName + "] " + new Date());
		} else {
			System.out.println("> No records to send to " + clientName
					+ ". To exit press 'q' and enter anytime");
		}
		/*
		 * return the list of records
		 */
		return records;
	}

	@Override
	public boolean insertResult(String clientName, List<Record> data)
			throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

}
