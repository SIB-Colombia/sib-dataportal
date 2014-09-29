/**
 * 
 */
package org.gbif.portal.dto.taxonomy;

import java.util.Set;

import org.gbif.portal.model.taxonomy.CommonName;
import org.gbif.portal.model.taxonomy.TaxonConcept;

/**
 * @author dave
 */
public class TaxonConceptCommonNameDTOFactory extends TaxonConceptDTOFactory {

	/**
	 * @see org.gbif.portal.dto.taxonomy.TaxonConceptDTOFactory#createDTO(java.lang.Object)
	 */
	@Override
	public Object createDTO(Object modelObject) {
		if(modelObject instanceof CommonName){
			CommonName cn = (CommonName) modelObject;
			
			Set<TaxonConcept> taxonConcepts = cn.getTaxonConcepts();
			TaxonConceptDTO tcDTO = new TaxonConceptDTO();
			
			if(taxonConcepts!=null && !taxonConcepts.isEmpty()) {
				boolean taxonConceptSet = false;
				for (TaxonConcept tc : taxonConcepts) {
					tcDTO = (TaxonConceptDTO) super.createDTO(tc);
					taxonConceptSet = true;
					break;
					}
				if (!taxonConceptSet) {
					if(logger.isDebugEnabled())
						logger.debug("Either no taxon concept found - using first");
					// just use the first name retrieved
					TaxonConcept taxonConcet = taxonConcepts.iterator().next();
					tcDTO = (TaxonConceptDTO) super.createDTO(taxonConcet);
				}
			}
			
			tcDTO.setCommonName(cn.getName());
			tcDTO.setCommonNameLanguage(cn.getLanguage().getName());
			return tcDTO;
		}
		return null;
	}
}
