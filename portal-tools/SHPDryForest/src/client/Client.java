package client;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import client.manage.ShapeFileManager;
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
	private IResultManager resulter;

	/**
	 * @uml.property name="factory"
	 * @uml.associationEnd multiplicity="(1 1)" ordering="true"
	 *                     inverse="base:iclientmanager.ClientFactory"
	 */
	private ClientFactory factory;
	private Long initTime;
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
	private ShapeFileManager shapeFileManager;
	private ShapeFile shapeFile;

	private String clientName;

	private int worked;

	public static void main(String[] args) {
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

			shapeFileManager = new ShapeFileManager();
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
			work();
			System.out.println("# Work finished " + worked + " in "
					+ (System.currentTimeMillis() - initTime) + "ms "
					+ new Date());

		} catch (RemoteException e) {
			System.out.println("There was a problem with the connection.");
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

	/**
	 * 
	 * inserts the results
	 * 
	 * @param parts
	 *            the number of parts in which the results will be send
	 * @throws RemoteException
	 */
	private void insertResults(int parts) throws RemoteException {
		if (parts > 1) {
			System.out.println("Reconnecting to the server....");
			initComunication();
		}
		System.out.println("< Sending worked records to server.");
		try {
			if (resulter.insertResult(clientName, new LinkedList<Record>(
					records))) {
				worked += records.size();
				System.out.println("> Successfully entered records! "
						+ new Date(System.currentTimeMillis()));
			}
			records.clear();
			records = null;
		} catch (Exception e) {
			System.out
					.println("There was a problem trying send the results to the server.");
			System.out.println("ERROR:");
			System.out.println(e.getMessage());
			e.printStackTrace();
			System.out.println();
			System.out.println(".....Trying to send back the results in "
					+ parts + " parts....");
			try {
				Thread.sleep(20000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
			insertResults(parts++);
		}
	}

	/**
	 * evaluate the records after received
	 */
	private void work() {
		long tiempoTotal = System.currentTimeMillis();
		try {
			shapeFileManager.setDryForests(shapeFileManager
					.getDryForestsFromCoordinates(records));
			System.out.println("Total time :"
					+ (System.currentTimeMillis() - tiempoTotal)
					+ "ms FreeMem:" + Runtime.getRuntime().freeMemory());
			try {
				insertResults(1);
			} catch (RemoteException e) {
				System.out.println("Can't connect to the server.");
				System.out.println("ERROR: ");
				System.out.println(e.getMessage());
			}
		} catch (Exception e) {
			System.out.println("There was a problem");
			System.out.println("ERROR:");
			System.out.println(e.getMessage());
		}

	}

}