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

package org.gbif.portal.model.taxonomy;

import java.util.HashSet;
import java.util.Set;

import org.gbif.portal.model.BaseObject;
import org.gbif.portal.model.geospatial.Country;
import org.gbif.portal.model.resources.Language;
/**
 * A Common Name associated with a taxonomic concept.
 * 
 * @author mcubillos
 */
public class CommonName extends BaseObject {
	
	/** The taxon concept that this is joined to  */
	protected Set<TaxonConcept> taxonConcepts = new HashSet<TaxonConcept>();
	
	/** The actual name */
	protected String name;
	
	/** The ISO Language code */
	protected String isoLanguageCode;
	
	/** The Country of the common name location */
	protected Language language;
	
	/** The ISO Country code */
	protected String isoCountryCode;
	
	/** The Country of the common name location */
	protected Country country;
	
	/** The transliteration */
	protected String transliteration;
	
	/**
	 * @return the isoCountryCode
	 */
	public String getIsoLanguageCode() {
		return isoLanguageCode;
	}
	/**
	 * @param isoCountryCode the isoCountryCode to set
	 */
	public void setIsoLanguageCode(String isoCountryCode) {
		this.isoLanguageCode = isoCountryCode;
	}
	
	
	public Language getLanguage() {
		return language;
	}
	public void setLanguage(Language language) {
		this.language = language;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the taxonConcept
	 */
	public Set<TaxonConcept> getTaxonConcepts() {
		return taxonConcepts;
	}
	/**
	 * @param taxonConcept the taxonConcept to set
	 */
	public void setTaxonConcepts(Set<TaxonConcept> taxonConcepts) {
		this.taxonConcepts = taxonConcepts;
	}
	public String getIsoCountryCode() {
		return isoCountryCode;
	}
	public void setIsoCountryCode(String isoCountryCode) {
		this.isoCountryCode = isoCountryCode;
	}
	
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public String getTransliteration() {
		return transliteration;
	}
	public void setTransliteration(String transliteration) {
		this.transliteration = transliteration;
	}
}