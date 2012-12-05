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
 * A join entity for taxon and country. Represents occurrences of a taxon in a
 * particular country with a count.
 * 
 * @author dmartin
 */
public class TaxonDepartment extends HibernateDaoSupport {

  protected TaxonDepartmentId key;

  protected TaxonConceptLite taxonConceptLite;

  protected int count;

  /**
   * @return the count
   */
  public int getCount() {
    return count;
  }

  /**
   * @return the key
   */
  public TaxonDepartmentId getKey() {
    return key;
  }

  /**
   * @return the taxonConceptLite
   */
  public TaxonConceptLite getTaxonConceptLite() {
    return taxonConceptLite;
  }

  /**
   * @param count the count to set
   */
  public void setCount(int count) {
    this.count = count;
  }

  /**
   * @param key the key to set
   */
  public void setKey(TaxonDepartmentId key) {
    this.key = key;
  }

  /**
   * @param taxonConceptLite the taxonConceptLite to set
   */
  public void setTaxonConceptLite(TaxonConceptLite taxonConceptLite) {
    this.taxonConceptLite = taxonConceptLite;
  }
}