package net.sibcolombia.portal.model.taxonomy;

import java.io.Serializable;

/**
 * Identifier class used for compound key.
 * 
 * @author dmartin
 */
public class TaxonProtectedAreaId implements Serializable {

  private static final long serialVersionUID = 8174862734224994208L;

  public Long taxonConceptId;
  public String protectedAreaId;

  /**
   * @return the isoDepartmentCode
   */
  public String getProtectedAreaId() {
    return protectedAreaId;
  }

  /**
   * @return the taxonConceptId
   */
  public Long getTaxonConceptId() {
    return taxonConceptId;
  }

  /**
   * @param isoDepartmentCode the isoDepartmentCode to set
   */
  public void setProtectedAreaId(String protectedAreaId) {
    this.protectedAreaId = protectedAreaId;
  }

  /**
   * @param taxonConceptId the taxonConceptId to set
   */
  public void setTaxonConceptId(Long taxonConceptId) {
    this.taxonConceptId = taxonConceptId;
  }
}