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
 * Holds details of a Colombian department including statistics data regarding
 * the number of occurrence records the system holds for a particular
 * Colombian department.
 * NOTE:The identifier for this hibernate object isnt the departmentId but the IsoDepartmentCode.
 * This is to enable joins with the OccurrenceRecord on isoDepartmentCode.
 * 
 * @author Valentina Grajales
 * @hibernate.class
 *                  table="department"
 */
public class Department extends BaseObject {

  /**
   * Department name
   * protected String isoDepartmentCode;
   * /** The ISO department Code for this model. Used as the identifier in this model object
   */
  protected String isoDepartmentCode;
  /** The department name */
  protected String departmentName;

  /** The number of occurrences records this data resource provides */
  protected Integer occurrenceCount;


  /** The number of occurrences records with geo reference data this data resource provides */
  protected Integer occurrenceCoordinateCount;

  /** The number of species this data resource provides */
  protected Integer speciesCount;
  /** The minimum latitude for this department */
  protected Float minLatitude;
  /** The maximum latitude for this department */
  protected Float maxLatitude;
  /** The minimum longitude for this department */
  protected Float minLongitude;
  /** The maximum longitude for this department */
  protected Float maxLongitude;

  /**
   * @return the departmentName
   */
  public String getDepartmentName() {
    return departmentName;
  }

  /**
   * @hibernate.id
   *               generator-class="assigned"
   *               unsaved-value="null"
   *               column="iso_department_code"
   * @return the isoDepartmentCode
   */
  public String getIsoDepartmentCode() {
    return isoDepartmentCode;
  }

  /**
   * @hibernate.property
   *                     column="max_latitude"
   * @return the maxLatitude
   */
  public Float getMaxLatitude() {
    return maxLatitude;
  }

  /**
   * @hibernate.property
   *                     column="max_longitude"
   * @return the maxLongitude
   */
  public Float getMaxLongitude() {
    return maxLongitude;
  }

  /**
   * @hibernate.property
   *                     column="min_latitude"
   * @return the minLatitude
   */
  public Float getMinLatitude() {
    return minLatitude;
  }

  /**
   * @hibernate.property
   *                     column="min_longitude"
   * @return the minLongitude
   */
  public Float getMinLongitude() {
    return minLongitude;
  }

  /**
   * @hibernate.property
   *                     column="occurrence_coordinate_count"
   * @return the occurrenceCoordinateCount
   */
  public Integer getOccurrenceCoordinateCount() {
    return occurrenceCoordinateCount;
  }

  /**
   * @hibernate.property
   *                     column="occurrence_count"
   * @return the occurrenceCount
   */
  public Integer getOccurrenceCount() {
    return occurrenceCount;
  }

  /**
   * @hibernate.property
   *                     column="species_count"
   * @return the speciesCount
   */
  public Integer getSpeciesCount() {
    return speciesCount;
  }

  /**
   * @param departmentName the departmentName to set
   */
  public void setDepartmentName(String departmentName) {
    this.departmentName = departmentName;
  }

  /**
   * @param isoDepartmentCode the isoDepartmentCode to set
   */
  public void setIsoDepartmentCode(String isoDepartmentCode) {
    this.isoDepartmentCode = isoDepartmentCode;
  }

  /**
   * @param maxLatitude the maxLatitude to set
   */
  public void setMaxLatitude(Float maxLatitude) {
    this.maxLatitude = maxLatitude;
  }

  /**
   * @param maxLongitude the maxLongitude to set
   */
  public void setMaxLongitude(Float maxLongitude) {
    this.maxLongitude = maxLongitude;
  }

  /**
   * @param minLatitude the minLatitude to set
   */
  public void setMinLatitude(Float minLatitude) {
    this.minLatitude = minLatitude;
  }

  /**
   * @param minLongitude the minLongitude to set
   */
  public void setMinLongitude(Float minLongitude) {
    this.minLongitude = minLongitude;
  }

  /**
   * @param occurrenceCoordinateCount the occurrenceCoordinateCount to set
   */
  public void setOccurrenceCoordinateCount(Integer occurrenceCoordinateCount) {
    this.occurrenceCoordinateCount = occurrenceCoordinateCount;
  }

  /**
   * @param occurrenceCount the occurrenceCount to set
   */
  public void setOccurrenceCount(Integer occurrenceCount) {
    this.occurrenceCount = occurrenceCount;
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