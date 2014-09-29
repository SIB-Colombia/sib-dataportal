package net.sibcolombia.portal.model.taxonomy;

import java.io.Serializable;

/**
 * Identifier class used for compound key.
 * 
 * @author mcubillos
 */
public class TaxonCountyId implements Serializable {

  private static final long serialVersionUID = 8174862734224994208L;

  public Long taxonConceptId;
  public String isoCountyCode;

  /**
   * @return the isoCountyCode
   */
  public String getIsoCountyCode() {
    return isoCountyCode;
  }

  /**
   * @return the taxonConceptId
   */
  public Long getTaxonConceptId() {
    return taxonConceptId;
  }

  /**
   * @param isoCountyCode the isoDepartmentCode to set
   */
  public void setIsoCountyCode(String isoCountyCode) {
    this.isoCountyCode = isoCountyCode;
  }

  /**
   * @param taxonConceptId the taxonConceptId to set
   */
  public void setTaxonConceptId(Long taxonConceptId) {
    this.taxonConceptId = taxonConceptId;
  }
}