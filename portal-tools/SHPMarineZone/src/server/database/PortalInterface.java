package server.database;


import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import iserver.IResultServer;
import iserver.IWorkServer;
import model.Record;
import server.ServerConfig;



public class PortalInterface implements IWorkServer, IResultServer {

        private static PortalInterface instance;

        /**
         * @uml.property   name="portal"
         * @uml.associationEnd   multiplicity="(1 1)" ordering="true" inverse="base:server.database.PortalManager"
         */
        private PortalManager portal;

        private PortalInterface() {
                DataBaseManager.registerDriver();
                portal = new PortalManager(DataBaseManager.openConnection(
                                ServerConfig.getInstance().database_user, ServerConfig.getInstance().database_password));
        }

        public static PortalInterface getInstance() {
                if (instance == null) {
                        instance = new PortalInterface();
                }
                return instance;
        }

        
        @Override
        public boolean insertResult(String clientName, List<Record> data) {
	        LinkedList<Record> goodRecords = new LinkedList<Record>();
	        for (Record r : data) {
	        	goodRecords.add(r);
	        }
	        
	        if(goodRecords.size() > 0) {
        		for(Record goodRecord: goodRecords){
        			portal.insertGoodRecord(goodRecord);
        		}
                goodRecords.clear();
	        }
	        
	        System.out.println("< Inserted " + data.size() + " ["
	                        + data.get(0).getId() + "-" + data.get(data.size() - 1).getId()
	                        + "]from [" + clientName + "] " + new Date());
	
	        data.clear();
	        data = null;
	        return true;
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

}
