package iserver.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

import iserver.IWorkServer;
import iserver.zip.IZipWorkServer;
import model.Record;


public interface IWorkServerRMI extends Remote, IWorkServer, IZipWorkServer {
        
        /**
         * 
         * @param clientName
         *            to identify from where the request came
         * @param quantity
         *            of requesting records
         * @return Records of records to work
         * @throws RemoteException
         */
        public List<Record> getWork(String clientName, int quantity)
                        throws RemoteException;

        /**
         * 
         * @param clientName
         *            to identify from where the request came
         * @param quantity
         *            of requesting records
         * @return zippedData of records to work instance of List<Record>
         * @throws Exception
         */
        public byte[] getZippedWork(String clientName)
                        throws RemoteException;
}
