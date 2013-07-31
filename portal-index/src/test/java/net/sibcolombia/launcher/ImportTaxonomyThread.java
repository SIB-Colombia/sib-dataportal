package net.sibcolombia.launcher;

import net.sibcolombia.portal.dao.DataResourceDAO;
import org.gbif.portal.harvest.taxonomy.TaxonomyUtils;
import org.gbif.portal.model.DataResource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ImportTaxonomyThread extends Thread{
	/**
	   * The utils
	*/
	protected TaxonomyUtils taxonomyUtils;
	/**
	 * The DataResourceDAO
	 */
	protected DataResourceDAO dataResourceDAO;
	/**
	 * The commons logger
	 */
	protected Log logger = LogFactory.getLog(this.getClass());

	/**
	 * The DataResource ID
	 */
	protected long id;
	
	/**
	   * Hidden constructor forcing the setting of the required values
	*/
	public ImportTaxonomyThread(TaxonomyUtils taxonomyUtils,DataResourceDAO dataResourceDAO, long id){
		this.taxonomyUtils = taxonomyUtils;
		this.dataResourceDAO = dataResourceDAO;
		this.id = id;
	}
	
	public void run() {
		try{
			System.out.println("Llenando campo partner_concept_id en tabla taxon_concept, para recurso con id: " + id);
		    long time = System.currentTimeMillis();
		    logger.info("Starting importing resource[" + id + "]");
		    DataResource resource = dataResourceDAO.getById(id);
		    if (resource == null) {
		    	throw new Exception("No resource for id:" + id);
		    }
	    	 // Only allow our highest taxonomic authorities to create kingdoms
		    boolean canCreateKingdoms = (resource.getTaxonomicPriority() <= 10);
		    taxonomyUtils.importTaxonomyFromDataResource(id, 1, 1, canCreateKingdoms, false, false);
		    logger.info("Finished importing resource[" + id + "] in " + ((1 + System.currentTimeMillis() - time) / 1000) + " secs");
		    
		    System.out.println("Llenando ID de taxones, kingdom, campo partner_concep, phylum, ..., species para el recurso con id: " + id);
		    logger.info("Starting taxonomy denormalisation of resource " + id);
		    taxonomyUtils.denormalisedTaxonomyForResource(id);
		    logger.info("Finished taxonomy denormalisation of resource " + id);
		}catch(Exception  e){
			return;
		}
	}
		
}

