package client;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.List;

import iclient.ClientFactory;
import iclient.IResultManager;
import iclient.IWorkManager;
import model.Record;
import model.ShapeFile;
import proxy.local.ClientFactoryLocal;

public class Client {

	/**
	 * @uml.property name="worker"
	 * @uml.associationEnd multiplicity="(1 1)" ordering="true"
	 *                     inverse="base:iclientmanager.IWorkManager"
	 */
	private IWorkManager worker;

	/**
	 * @uml.property name="resulter"
	 * @uml.associationEnd multiplicity="(1 1)" ordering="true"
	 *                     inverse="base:iclientmanager.IResultManager"
	 */
	@SuppressWarnings("unused")
	private IResultManager resulter;

	/**
	 * @uml.property name="factory"
	 * @uml.associationEnd multiplicity="(1 1)" ordering="true"
	 *                     inverse="base:iclientmanager.ClientFactory"
	 */
	private ClientFactory factory;
	private Long initTime;
	@SuppressWarnings("unused")
	private boolean running;

	/**
	 * @uml.property name="records"
	 * @uml.associationEnd multiplicity="(0 -1)" ordering="true"
	 *                     inverse="base:model.Record"
	 */
	private List<Record> records;

	/**
	 * @uml.property name="shapeFileManager"
	 * @uml.associationEnd multiplicity="(1 1)" ordering="true"
	 *                     inverse="base:client.correctormanager.ShapeFileManager"
	 */
	@SuppressWarnings("unused")
	private ShapeFile shapeFile;

	private String clientName;
	private static PrintWriter writer;

	private int worked;

	public static void main(String[] args) throws IOException {
		FileWriter out = new FileWriter("registros.txt");
		writer = new PrintWriter(out);
		Client client = new Client();
		client.start();
	}

	/**
	 * Creates the client whit the properties set
	 */
	public Client() {
		try {
			worked = 0;
			running = false;

			shapeFile = new ShapeFile(new File(
					ClientConfig.getInstance().shapeFile));
			clientName = InetAddress.getLocalHost().getHostName() + " "
					+ System.getProperty("user.name") + " "
					+ InetAddress.getLocalHost().getHostAddress();
			initTime = System.currentTimeMillis();

			if (ClientConfig.getInstance().communication_type
					.equalsIgnoreCase(ClientConfig.LOCAL_COMMUNICATION)) {
				factory = new ClientFactoryLocal();
			} else {
				System.out.println("Not implemented communication type: "
						+ ClientConfig.getInstance().communication_type);

			}

		} catch (UnknownHostException e) {
			clientName = "unknown";
		}
	}

	/**
	 * starts the client
	 */
	public void start() {

		try {
			initComunication();
			initTime = System.currentTimeMillis();
			System.out.println("< Asking work to the server ["
					+ ClientConfig.getInstance().server_ipaddr + "] "
					+ new Date());
			records = worker.getWork(clientName);

			if (records.size() > 0) {
				writer.println("id	scientificName	kingdom	phylum	class_concept	order_concept	family	genus	species	specificEpithet	infraspecificEpithet	autor	institution_code	data_provider	data_resource	collection_code	latitude	longitude");
				for (Record goodRecord : records) {
					if (goodRecord.isPertenece()) {
						writer.println(goodRecord.toString());
					}
				}
			}

			System.out.println("< Inserted " + records.size() + new Date());
			writer.close();
			records = null;
			// work();
			System.out.println("# Work finished " + worked + " in "
					+ (System.currentTimeMillis() - initTime) + "ms "
					+ new Date());

		} catch (RemoteException e) {
			System.out.println("There was a problem with the RMI connection.");
			System.out.println(e.getMessage());
		} catch (Exception e) {
			System.out.println("There was a problem asking for work.");
			System.out.println(e.getMessage());
		} finally {
			System.exit(0);
		}

	}

	/**
	 * creates the worker and the resulter from the client factory
	 * 
	 * @throws RemoteException
	 */
	private void initComunication() throws RemoteException {
		worker = factory.createWorkManager();
		resulter = factory.createResultManager();

	}

}