package net.sibcolombia.portal.model.taxonomy;

import java.io.Serializable;

/**
 * Identifier class used for compound key.
 * 
 * @author dmartin
 */
public class TaxonMarineZoneId implements Serializable {

  private static final long serialVersionUID = 8174862734224994208L;

  public Long taxonConceptId;
  public String marineZoneId;

  /**
   * @return the isoDepartmentCode
   */
  public String getMarineZoneId() {
    return marineZoneId;
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
  public void setMarineZoneId(String marineZoneId) {
    this.marineZoneId = marineZoneId;
  }

  /**
   * @param taxonConceptId the taxonConceptId to set
   */
  public void setTaxonConceptId(Long taxonConceptId) {
    this.taxonConceptId = taxonConceptId;
  }
}