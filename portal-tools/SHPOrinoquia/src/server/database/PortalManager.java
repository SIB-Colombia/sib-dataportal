package server.database;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import client.ClientConfig;
import model.Record;
import model.ShapeFile;

public class PortalManager {

	private Connection conx;
	private ResultSet rs;
	/**
	 * @uml.property name="regs"
	 * @uml.associationEnd multiplicity="(0 -1)" ordering="true"
	 *                     inverse="base:model.Record"
	 */
	private List<Record> regs;
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
		this.lastID = 0;
		this.regs = new LinkedList<Record>();
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
						"SELECT tn.canonical as scientificName, tn1.canonical as kingdom,  tn2.canonical as phylum, tn3.canonical as class_concept, tn4.canonical as order_concept,  tn5.canonical as family, tn6.canonical as genus, tn7.canonical as species, tn.specific_epithet as specificEpithet, tn.infraspecific as infraspecificEpithet , tn.author as author, ic.code as institution_code, dp.name as data_provider, dr.name as data_resource, cc.code as collection_code, oc.latitude as latitude, oc.longitude as longitude, oc.id as id FROM institution_code ic, data_provider dp, data_resource dr, collection_code cc, taxon_name tn1, taxon_name tn2, taxon_name tn3, taxon_name tn4, taxon_name tn5, taxon_name tn6, taxon_name tn7, occurrence_record oc inner join taxon_name tn on oc.taxon_name_id = tn.id left join taxon_concept tc on oc.kingdom_concept_id = tc.id left join taxon_concept tc1 on oc.phylum_concept_id = tc1.id left join taxon_concept tc2 on oc.class_concept_id = tc2.id left join taxon_concept tc3 on oc.order_concept_id = tc3.id left join taxon_concept tc4 on oc.family_concept_id = tc4.id left join taxon_concept tc5 on oc.genus_concept_id = tc5.id left join taxon_concept tc6 on oc.species_concept_id = tc6.id where oc.deleted is null and oc.latitude is not null and oc.longitude is not null and oc.data_resource_id = dr.id and tc.taxon_name_id = tn1.id and tc1.taxon_name_id = tn2.id and tc2.taxon_name_id = tn3.id and tc3.taxon_name_id = tn4.id and tc4.taxon_name_id = tn5.id and tc5.taxon_name_id = tn6.id and tc6.taxon_name_id = tn7.id and oc.institution_code_id = ic.id and oc.data_provider_id = dp.id and oc.data_resource_id = dr.id and oc.collection_code_id = cc.id and oc.id > "
								+ lastID, conx);
		regs.clear();
		ShapeFile shapefile = new ShapeFile(new File(
				ClientConfig.getInstance().shapeFile));
		Set<String> registros = new LinkedHashSet<String>();
		try {
			while (rs.next()) {
				registros.clear();
				registros.addAll(shapefile.polygonsForAPoint(
						rs.getDouble("latitude"), rs.getDouble("longitude")));
				if (registros.size() > 0) {
					regs.add(new Record(rs.getString("scientificName"), rs
							.getString("kingdom"), rs.getString("phylum"), rs
							.getString("class_concept"), rs
							.getString("order_concept"),
							rs.getString("family"), rs.getString("genus"), rs
									.getString("species"), rs
									.getString("specificEpithet"), rs
									.getString("infraspecificEpithet"), rs
									.getString("author"), rs
									.getString("institution_code"), rs
									.getString("data_provider"), rs
									.getString("data_resource"), rs
									.getString("collection_code"), rs
									.getDouble("latitude"), rs
									.getDouble("longitude"), lastID = rs
									.getInt("id")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.getStatement().close();
				rs.close();
				rs = null;
			} catch (final SQLException e) {
				e.printStackTrace();
			}
		}
		return regs;
	}
}
