package net.sibcolombia.portal.model.taxonomy;

import java.io.Serializable;

/**
 * Identifier class used for compound key.
 * 
 * @author dmartin
 */
public class TaxonParamoId implements Serializable {

  private static final long serialVersionUID = 8174862734224994208L;

  public Long taxonConceptId;
  public String complexId;

  /**
   * @return the isoDepartmentCode
   */
  public String getComplexId() {
    return complexId;
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
  public void setComplexId(String complexId) {
    this.complexId = complexId;
  }

  /**
   * @param taxonConceptId the taxonConceptId to set
   */
  public void setTaxonConceptId(Long taxonConceptId) {
    this.taxonConceptId = taxonConceptId;
  }
}