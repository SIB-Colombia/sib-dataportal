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
 * Holds details of a Colombian protected areas.
 * NOTE:The identifier for this hibernate object isnt the protectedAreaId but the protectedArea.
 * This is to enable joins with the OccurrenceRecord on protected_area.
 * 
 * @author Maria Fernanda Cubillos
 * @hibernate.class
 * table="protected_area"
 */

public class Zonificacion extends BaseObject{
	 
	/** The protected area id - internal Id */
	protected Long zonificacionId;
	  
	/** The protected area Code for this model. Used as the identifier in this model object*/
	protected String szh;
	  
	/** The protected area name */
	protected String nomszh;
	  
	/** The number of species this data resource provides */
	protected Integer speciesCount;
	  
	/** The number of occurrence this data resource provides */
	protected Integer occurrenceCount;

		public Long getZonificacionId() {
		return zonificacionId;
	}


	public void setZonificacionId(Long zonificacionId) {
		this.zonificacionId = zonificacionId;
	}


	public String getSzh() {
		return szh;
	}


	public void setSzh(String szh) {
		this.szh = szh;
	}


	public String getNomszh() {
		return nomszh;
	}


	public void setNomszh(String nomszh) {
		this.nomszh = nomszh;
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