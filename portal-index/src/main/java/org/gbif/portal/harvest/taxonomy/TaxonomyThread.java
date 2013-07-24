package org.gbif.portal.harvest.taxonomy;

import org.gbif.portal.dao.RelationshipAssertionDAO;
import org.gbif.portal.dao.TaxonConceptDAO;

public class TaxonomyThread extends TaxonomyUtils implements Runnable{
	/**
	 * @param args
	 */
	protected RelationshipAssertionDAO relationshipAssertionDAO;
	protected TaxonConceptDAO taxonConceptDAO;
	protected long sourceDataResourceId;
	protected long targetDataResourceId;
	protected long targetDataProviderId; 
	protected boolean allowCreateUnknownKingdoms;
	protected boolean majorRanksOnly;
	protected int rank;
	protected boolean unpartnered;
	
	
	
	
	public TaxonomyThread(RelationshipAssertionDAO relationshipAssertionDAO, TaxonConceptDAO taxonConceptDAO, long targetDataResourceId, long targetDataProviderId, boolean allowCreateUnknownKingdoms, boolean majorRanksOnly, boolean unpartnered, long sourceDataResourceId, int rank){
		this.relationshipAssertionDAO = relationshipAssertionDAO;
		this.taxonConceptDAO = taxonConceptDAO;
		this.sourceDataResourceId = sourceDataResourceId;
		this.targetDataResourceId = targetDataResourceId;
		this.targetDataProviderId = targetDataProviderId;
		this.allowCreateUnknownKingdoms = allowCreateUnknownKingdoms;
		this.majorRanksOnly = majorRanksOnly;
		this.rank = rank;
		this.unpartnered = unpartnered;
	}
	
	public void run() {
		logger.info("Importing accepted concepts of rank " + rank + " from source data resource[" + sourceDataResourceId + "] to target data resource[" + targetDataResourceId + "]");
		importTaxonomyFromDataResource(relationshipAssertionDAO, taxonConceptDAO, sourceDataResourceId, targetDataResourceId, targetDataProviderId, allowCreateUnknownKingdoms, majorRanksOnly, rank, true, unpartnered);
		logger.info("Importing non-accepted concepts of rank " + rank + " from source data resource[" + sourceDataResourceId + "] to target data resource[" + targetDataResourceId + "]");
		importTaxonomyFromDataResource(relationshipAssertionDAO, taxonConceptDAO, sourceDataResourceId, targetDataResourceId, targetDataProviderId, allowCreateUnknownKingdoms, majorRanksOnly, rank, false, unpartnered);
	}
}
