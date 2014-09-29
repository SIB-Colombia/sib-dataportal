package iclient.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

import iclient.IWorkManager;
import model.Record;

/**
 * 
 * A communication interface for requesting work 
 *
 */
public interface IWorkManagerRMI extends IWorkManager, Remote {

        /**
         * @param clientName
         *            to identify from where the request came
         * @param quantity
         *            of requesting records
         * @return records to work
         * @throws RemoteException
         */
        @Override
        public List<Record> getWork(String clientName)
                        throws RemoteException;

}