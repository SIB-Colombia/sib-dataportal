package server.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import model.Record;
import server.ServerConfig;

public class PortalManager {

        private Connection conx;
        private ResultSet rs;
        /**
         * @uml.property name="regs"
         * @uml.associationEnd multiplicity="(0 -1)" ordering="true"
         *                     inverse="base:model.Record"
         */
        private List<Record> regs;
        private boolean endRecords;
        private int lastID;

        /**
         * Creates the manager of the database
         * 
         * @param conx
         *            is the connection to the database
         */
        public PortalManager(Connection conx) {
                super();
                this.conx = conx;
                this.endRecords = true;
                this.lastID = 0;
                this.regs = new LinkedList<Record>();
        }

        /**
         * Inserts a record that was evaluated as good in the goods table
         * 
         * @param rec
         *            is the record to be insert
         * @return 1 - if the insertion was succes. 0 - otherwise.
         */
        public int insertGoodRecord(Record rec) {

	    	StringBuilder query = new StringBuilder();
	        query.append("UPDATE " + ServerConfig.getInstance().dbTableGoods);
	        if(rec.getMarineZone()==null){
	        	query.append(" SET marine_zone = null");
	        }else{
	        	query.append(" SET marine_zone = (select mask from marine_zone where description like ('" + rec.getMarineZone().split(",")[0] + "'))");
	        }
	        query.append(" WHERE id = " + rec.getId());
	        query.append(" AND longitude LIKE ('"+ rec.getLongitude() + "')");
	        query.append(" AND latitude LIKE ('"+ rec.getLatitude()+ "')");
	        query.append(";");
	        return DataBaseManager.makeChange(query.toString(), conx);

        }

        /**
         * Gets a list of records to work
         * 
         * @param numRecords
         *            to get
         * @return
         */
        public synchronized List<Record> getRecords() {
                rs = DataBaseManager.makeQuery("select id,latitude,longitude,nub_concept_id,marine_zone from " + ServerConfig.getInstance().dbTableGoods
                                + " where id > " + lastID  + " order by id " ,
                                conx);

                endRecords = false;
                regs.clear();
                // regs = new LinkedList<Record>();
                try {
	                while(rs.next()) {
	                	regs.add(new Record(rs.getString("marine_zone"), rs.getDouble("latitude"), rs.getDouble("longitude"), rs.getInt("nub_concept_id"), lastID = rs.getInt("id")));
	                }

                } catch (SQLException e) {
                        e.printStackTrace();
                } finally {
                        try {
                                rs.getStatement().close();
                                rs.close();
                                rs = null;
                        } catch (SQLException e) {
                                e.printStackTrace();
                        }
                }
                return regs;
        }
}
