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
 * Holds details of a Colombian ecosystem.
 * This is to enable joins with the OccurrenceRecord on ecosystem.
 * 
 * @author Maria Fernanda Cubillos
 * @hibernate.class
 * table="ecosystem"
 */

public class Ecosystem extends BaseObject{
	 
	/** The ecosystem id - internal Id */
	protected Long ecosystemId;
	  
	/** The sector type*/
	protected String type;
	
	/** The number of species this data resource provides */
	protected Integer speciesCount;
	 
	/** The number of occurrence this data resource provides */
	protected Integer occurrenceCount;
	  
	/**
	 * @hibernate.property
	 * column="id"
	 * @return the ecosystemId
	 */
	
	public Long getEcosystemId() {
		return ecosystemId;
	}
	
	/**
	 * @param ecosystemId the ecosystemId to set
	 */
	public void setEcosystemId(Long ecosystemId) {
		this.ecosystemId = ecosystemId;
	}
	
	/**
	 * @hibernate.property
	 * column="type"
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	
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
	   * @see java.lang.Object#toString()
	   */
	  @Override
	  public String toString() {
	    return ToStringBuilder.reflectionToString(this);
	  }

}