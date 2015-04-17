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
	 * Inserts a list of records that were evaluated as good in the goods table
	 * 
	 * @param recs
	 *            are the records to be insert
	 * @return the number of records inserted.
	 */
	public int insertGoodRecords(List<Record> recs) {
		int result = -1;
		if (recs != null && recs.size() > 0) {
			for (Record rec : recs) {
				StringBuilder query = new StringBuilder();
				query.append("UPDATE "
						+ ServerConfig.getInstance().dbTableGoods);
				if (rec.getDryForest() == null) {
					query.append(" SET dry_forest = null");
				} else {
					query.append(" SET dry_forest = 1");
				}
				query.append(" WHERE id = " + rec.getId());
				query.append("; ");
				result = DataBaseManager.makeChange(query.toString(), conx);
				System.out.println(query.toString() + "respuesta:" + result);
			}
			// return DataBaseManager.makeChange(query.toString(), conx);
			return result;
		}

		return 0;
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
		if (rec.getDryForest() == null) {
			query.append(" SET dry_forest = null");
		} else {
			query.append(" SET dry_forest = 1");
		}
		query.append(" WHERE id = " + rec.getId());
		query.append(" AND CAST(longitude AS DECIMAL) = CAST("
				+ rec.getLongitude() + " AS DECIMAL)");
		query.append(" AND CAST(latitude AS DECIMAL) = CAST("
				+ rec.getLatitude() + " AS DECIMAL)");
		query.append("; ");

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
		rs = DataBaseManager
				.makeQuery(
						"select id, latitude, longitude, nub_concept_id, dry_forest from "
								+ ServerConfig.getInstance().dbTableGoods
								+ " where id > "
								+ lastID
								+ " and deleted is null and latitude is not null and longitude is not null and dry_forest is null order by id ",
						conx);

		endRecords = false;
		regs.clear();
		// regs = new LinkedList<Record>();
		try {
			while (rs.next()) {
				regs.add(new Record(rs.getString("dry_forest"), rs
						.getDouble("latitude"), rs.getDouble("longitude"), rs
						.getInt("nub_concept_id"), lastID = rs.getInt("id")));
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
