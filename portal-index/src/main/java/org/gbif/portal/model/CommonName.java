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
package org.gbif.portal.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.gbif.portal.model.TaxonConcept;

/**
 * A bean to represent a common name in whole or part
 * @author Donald Hobern
 */
public class CommonName implements Serializable{
	/**
	 * Generated 
	 */
	private static final long serialVersionUID = -3005075738383480628L;
	
	protected Long id;
	protected Set<TaxonConcept> taxonConcepts = new HashSet<TaxonConcept>();
	protected String name;
	protected String isoLanguageCode;
	protected String isoCountryCode;
	protected String transliteration;
	
	public CommonName() {		
	}
	
	public CommonName(String name, String isoLanguageCode) {
		this.name = name;
		this.isoLanguageCode = isoLanguageCode;
	}
	
	public CommonName(long id, String name, String isoLanguageCode, String isoCountryCode, String transliteration) {
		this.id = id;
		this.name = name;
		this.isoLanguageCode = isoLanguageCode;
		this.isoCountryCode = isoCountryCode;
		this.transliteration = transliteration;
	}

	/**
	 * @return A full version of the common name for logging
	 */
	public String toFullString() {
		 return new ToStringBuilder(this, ToStringStyle.SHORT_PREFIX_STYLE).
	       append("name", name).
	       append("isoLanguageCode", isoLanguageCode).
	       append("isoCountryCode", isoCountryCode).
	       append("transliteration", transliteration).
	       toString();	
	}
	
	/**
	 * @return A short version of the common name (Name, Language)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		 return new ToStringBuilder(this, ToStringStyle.SHORT_PREFIX_STYLE).
	       append("name", name).
	       append("isoLanguageCode", isoLanguageCode).
	       toString();	
	}
	
	/**
	 * CommonName is considered equal if the taxonConceptId, name and language are the same
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object target) {
		if (target instanceof CommonName) {
			CommonName targetName = (CommonName) target;
			if (StringUtils.equals(getName(), targetName.getName())
				&& StringUtils.equals(getIsoLanguageCode(), targetName.getIsoLanguageCode()))
			{
				return true;
			}
		}
		return false;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Set<TaxonConcept> getTaxonConcepts() {
		return taxonConcepts;
	}

	public void setTaxonConcepts(Set<TaxonConcept> taxonConcepts) {
		this.taxonConcepts = taxonConcepts;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIsoLanguageCode() {
		return isoLanguageCode;
	}

	public void setIsoLanguageCode(String isoLanguageCode) {
		this.isoLanguageCode = isoLanguageCode;
	}

	public String getIsoCountryCode() {
		return isoCountryCode;
	}

	public void setIsoCountryCode(String isoCountryCode) {
		this.isoCountryCode = isoCountryCode;
	}

	public String getTransliteration() {
		return transliteration;
	}

	public void setTransliteration(String transliteration) {
		this.transliteration = transliteration;
	}

	

}