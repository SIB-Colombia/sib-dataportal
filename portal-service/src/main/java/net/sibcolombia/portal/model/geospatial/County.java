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
 * Holds details of a Colombian county (municipio).
 * NOTE:The identifier for this hibernate object isnt the countyId but the IsoCountyCode.
 * This is to enable joins with the OccurrenceRecord on isoCountyCode.
 * 
 * @author Maria Fernanda Cubillos
 * @hibernate.class
 *                  table="county"
 */

public class County extends BaseObject{
	  /**
	   * County name
	   * protected String isoCountyCode;
	   * /** The ISO county Code for this model. Used as the identifier in this model object
	   */
	  protected String isoCountyCode;
	  /** The county name */
	  protected String countyName;

	  /** Department Id */
	  protected Integer departmentId;

	  /** The county id - internal Id */
	  protected Long countyId;

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
     * column="iso_county_code"
	 * @return the isoCountyCode
	 */
	public String getIsoCountyCode() {
		return isoCountyCode;
	}

	/**
	 * @param isoCountyCode the isoCountyCode to set
	 */
	public void setIsoCountyCode(String isoCountyCode) {
		this.isoCountyCode = isoCountyCode;
	}

	/**
	 * @hibernate.property
     * 			          column="county_name"
	 * @return the countyName
	 */
	public String getCountyName() {
		return countyName;
	}

	/**
	 * @param countyName the countyName to set
	 */
	public void setCountyName(String countyName) {
		this.countyName = countyName;
	}

	/**
	 * @hibernate.property
     * 			          column="department_id"
	 * @return the departmentId
	 */
	public Integer getDepartmentId() {
		return departmentId;
	}

	/**
	 * @param departmentId the departmentId to set
	 */
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	/**
	 * @hibernate.property
     * 			          column="id"
	 * @return the countyId
	 */
	public Long getCountyId() {
		return countyId;
	}

	/**
	 * @param countyId the countyId to set
	 */
	public void setCountyId(Long countyId) {
		this.countyId = countyId;
	}
	
	/**
	   * @see java.lang.Object#toString()
	   */
	  @Override
	  public String toString() {
	    return ToStringBuilder.reflectionToString(this);
	  }

}
