package proxy.local;

import java.rmi.RemoteException;
import java.util.List;

import iclient.IWorkManager;
import model.Record;
import server.connection.object.WorkServerObject;



public class WorkManagerLocal implements IWorkManager {
        
        private WorkServerObject wserver;
        
        public WorkManagerLocal(){
                wserver=new WorkServerObject();
        }

        @Override
        public List<Record> getWork(String clientName) throws RemoteException {
                return wserver.getWork(clientName);
        }


}