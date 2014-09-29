/***************************************************************************
 * Copyright (C) 2012 SIB Colombia.
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package net.sibcolombia.portal.model.taxonomy;

import org.gbif.portal.model.taxonomy.TaxonConceptLite;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A join entity for taxon and marine zone. Represents occurrences of a taxon in a
 * particular  marine zone with a count.
 */
public class TaxonProtectedArea extends HibernateDaoSupport {

  protected TaxonProtectedAreaId key;

  protected TaxonConceptLite taxonConceptLite;

  protected int count;

	public TaxonProtectedAreaId getKey() {
		return key;
	}
	
	public void setKey(TaxonProtectedAreaId key) {
		this.key = key;
	}
	
	public TaxonConceptLite getTaxonConceptLite() {
		return taxonConceptLite;
	}
	
	public void setTaxonConceptLite(TaxonConceptLite taxonConceptLite) {
		this.taxonConceptLite = taxonConceptLite;
	}
	
	public int getCount() {
		return count;
	}
	
	public void setCount(int count) {
		this.count = count;
	}
  
  
}