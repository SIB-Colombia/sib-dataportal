/***************************************************************************
 * Copyright (C) 2005 Global Biodiversity Information Facility Secretariat.  
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package org.gbif.portal.dto.taxonomy;

import java.util.Set;

import org.gbif.portal.dto.BaseDTOFactory;
import org.gbif.portal.model.taxonomy.CommonName;
import org.gbif.portal.model.taxonomy.TaxonConcept;

/**
 * A DTOFactory for Common Name objects. A Common Name is associated with a particular taxon concept.
 * 
 * @author Dave Martin
 */
public class CommonNameDTOFactory extends BaseDTOFactory {

	/**
	 * @see org.gbif.portal.dto.DTOFactory#createDTO(java.lang.Object)
	 */
	public Object createDTO(Object modelObject) {
		CommonName commonName = (CommonName) modelObject;
		CommonNameDTO commonNameDTO = new CommonNameDTO();
		commonNameDTO.setKey(commonName.getId().toString());
		commonNameDTO.setName(commonName.getName());
		
		//TODO Something to keep an eye on - involves lazy loading of the accepted concept
		Set<TaxonConcept> taxonConcepts = commonName.getTaxonConcepts();
		if(taxonConcepts!=null && !taxonConcepts.isEmpty()) {
			boolean taxonConceptSet = false;
			for (TaxonConcept tc : taxonConcepts) {
				commonNameDTO.setTaxonConceptKey(String.valueOf(tc.getId()));
				commonNameDTO.setTaxonName(tc.getTaxonName().getCanonical());
				taxonConceptSet = true;
				break;
				}
			if (!taxonConceptSet) {
				if(logger.isDebugEnabled())
					logger.debug("Either no taxon concept found - using first");
				// just use the first name retrieved
				TaxonConcept taxonConcet = taxonConcepts.iterator().next();
				commonNameDTO.setTaxonConceptKey(String.valueOf(taxonConcet.getId()));
				commonNameDTO.setTaxonName(taxonConcet.getTaxonName().getCanonical());
			}
		}
		//iso language code not being set at the minute
		//commonNameDTO.setLanguage(commonName.getIsoLanguageCode());
		commonNameDTO.setLanguage(commonName.getLanguage().getName());
		return commonNameDTO;
	}
}