package iserver;

import java.util.List;

import model.Record;


public interface IWorkServer {
        
        /**
         * 
         * @param clientName
         *            to identify from where the request came
         * @param quantity
         *            of requesting records
         * @return Records of records to work
         * @throws Exception
         */
        public List<Record> getWork(String clientName) throws Exception;

}