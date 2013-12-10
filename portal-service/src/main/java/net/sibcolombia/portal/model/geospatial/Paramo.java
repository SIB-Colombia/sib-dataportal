/***************************************************************************
 * Copyright (C) 2012 Sib Colombia.
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
package net.sibcolombia.portal.model.geospatial;

import org.gbif.portal.model.BaseObject;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * Holds details of a Colombian paramo.
 * NOTE:The identifier for this hibernate object isnt the paramoId but the complexId.
 * This is to enable joins with the OccurrenceRecord on paramo.
 * 
 * @author Maria Fernanda Cubillos
 * @hibernate.class
 *                  table="paramo"
 */

public class Paramo extends BaseObject{
	 
	/** The paramo id - internal Id */
	  protected Long paramoId;
	  
	  /** The complex Code for this model. Used as the identifier in this model object
	   */
	  protected String complexId;
	  /** The sector name*/
	  protected String sector;

	  /** District name */
	  protected String district;

	  /** The complex name */
	  protected Long complex;

	  /** The number of species this data resource provides */
	  protected Integer speciesCount;
	  
	  /** The number of occurrence this data resource provides */
	  protected Integer occurrenceCount;
	  
	  
	public Integer getOccurrenceCount() {
		return occurrenceCount;
	}

	public void setOccurrenceCount(Integer occurrenceCount) {
		this.occurrenceCount = occurrenceCount;
	}

	/**
	 * @return the speciesCount
	 */
	public Integer getSpeciesCount() {
		return speciesCount;
	}

	/**
	 * @param speciesCount the speciesCount to set
	 */
	public void setSpeciesCount(Integer speciesCount) {
		this.speciesCount = speciesCount;
	}

	/**
	 * @hibernate.property
     * column="id"
	 * @return the paramoId
	 */
	
	public Long getParamoId() {
		return paramoId;
	}

	/**
	 * @param paramoId the paramoId to set
	 */
	public void setParamoId(Long paramoId) {
		this.paramoId = paramoId;
	}

	/**
	 * @hibernate.property
     * column="complex_id"
	 * @return the complexId
	 */
	public String getComplexId() {
		return complexId;
	}
	/**
	 * @param complexId the complexId to set
	 */
	public void setComplexId(String complexId) {
		this.complexId = complexId;
	}
	/**
	 * @hibernate.property
     * column="sector"
	 * @return the sector
	 */
	public String getSector() {
		return sector;
	}
	/**
	 * @param sector the sector to set
	 */
	public void setSector(String sector) {
		this.sector = sector;
	}
	/**
	 * @hibernate.property
     * column="district"
	 * @return the district
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district the district to set
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @hibernate.property
     * column="complex"
	 * @return the complex
	 */
	public Long getComplex() {
		return complex;
	}
	/**
	 * @param complex the complex to set
	 */
	public void setComplex(Long complex) {
		this.complex = complex;
	}

	/**
	   * @see java.lang.Object#toString()
	   */
	  @Override
	  public String toString() {
	    return ToStringBuilder.reflectionToString(this);
	  }

}
