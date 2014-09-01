package net.sibcolombia.portal.model.taxonomy;

import java.io.Serializable;

/**
 * Identifier class used for compound key.
 * 
 * @author mcubillos
 */
public class TaxonZonificacionId implements Serializable {

  private static final long serialVersionUID = 8174862734224994208L;

  public Long taxonConceptId;
  public String zonificacionId;

  /**
   * @return the zonificacionId
   */
  public String getZonificacionId() {
    return zonificacionId;
  }

  /**
   * @return the taxonConceptId
   */
  public Long getTaxonConceptId() {
    return taxonConceptId;
  }

  /**
   * @param zonificacionId the zonificacionId to set
   */
  public void setZonificacionId(String zonificacionId) {
    this.zonificacionId = zonificacionId;
  }

  /**
   * @param taxonConceptId the taxonConceptId to set
   */
  public void setTaxonConceptId(Long taxonConceptId) {
    this.taxonConceptId = taxonConceptId;
  }
}