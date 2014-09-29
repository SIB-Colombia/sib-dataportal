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
 * NOTE:The identifier for this hibernate object isnt the marineZoneId but the mask.
 * This is to enable joins with the OccurrenceRecord on marine_zone.
 * 
 * @author Maria Fernanda Cubillos
 * @hibernate.class
 *                  table="marine_zone"
 */

public class MarineZone extends BaseObject{
	 
	/** The marine zone id - internal Id */
	  protected Long marineZoneId;
	  
	  /** The mask Code for this model. Used as the identifier in this model object*/
	  protected String mask;
	  
	  /** The marine zone name */
	  protected String description;

	  /** The number of species this data resource provides */
	  protected Integer speciesCount;
	  
	  /** The number of occurrence this data resource provides */
	  protected Integer occurrenceCount;

	public Long getMarineZoneId() {
		return marineZoneId;
	}

	public void setMarineZoneId(Long marineZoneId) {
		this.marineZoneId = marineZoneId;
	}

	public String getMask() {
		return mask;
	}

	public void setMask(String mask) {
		this.mask = mask;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getSpeciesCount() {
		return speciesCount;
	}

	public void setSpeciesCount(Integer speciesCount) {
		this.speciesCount = speciesCount;
	}

	public Integer getOccurrenceCount() {
		return occurrenceCount;
	}

	public void setOccurrenceCount(Integer occurrenceCount) {
		this.occurrenceCount = occurrenceCount;
	}
	/** @see java.lang.Object#toString() **/
	  @Override
	  public String toString() {
	    return ToStringBuilder.reflectionToString(this);
	  }
}