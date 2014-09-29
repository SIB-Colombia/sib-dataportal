package server.connection.object;

import java.util.List;

import iserver.IWorkServer;
import model.Record;
import server.database.PortalInterface;



public class WorkServerObject implements IWorkServer {


        @Override
        public List<Record> getWork(String clientName) {
                return PortalInterface.getInstance().getWork(clientName);
        }

}