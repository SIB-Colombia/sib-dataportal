package net.sibcolombia.portal.dto.department;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * A DTO that holds the details of a department.
 * Note: the name supplied is locale specific.
 * 
 * @author Valentina Grajales
 * @author {@link "mailto:valegrajales@gmail.com"}
 */
public class DepartmentDTO {


  /** The key for this department */
  protected String key;

  /** The iso department code for this department and country */
  protected String isoDepartmentCode;


  /** The locale specific name for this department */
  protected String departmentName;


  /** The number of occurrences records this data resource provides */
  protected Integer occurrenceCount;


  /** The number of occurrences records with geo reference data this data resource provides */
  protected Integer occurrenceCoordinateCount;


  /** The String used to identify the supplied - this will be null when not used in the context of a search */
  protected String interpretedFrom;


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
   * @return the interpretedFrom
   */
  public String getInterpretedFrom() {
    return interpretedFrom;
  }

  /**
   * @return the isoDepartmentCode
   */
  public String getIsoDepartmentCode() {
    return isoDepartmentCode;
  }

  /**
   * @return the key
   */
  public String getKey() {
    return key;
  }


  /**
   * @return the maxLatitude
   */
  public Float getMaxLatitude() {
    return maxLatitude;
  }

  /**
   * @return the maxLongitude
   */
  public Float getMaxLongitude() {
    return maxLongitude;
  }

  /**
   * @return the minLatitude
   */
  public Float getMinLatitude() {
    return minLatitude;
  }

  /**
   * @return the minLongitude
   */
  public Float getMinLongitude() {
    return minLongitude;
  }

  /**
   * @return the occurrenceCoordinateCount
   */
  public Integer getOccurrenceCoordinateCount() {
    return occurrenceCoordinateCount;
  }

  /**
   * @return the occurrenceCount
   */
  public Integer getOccurrenceCount() {
    return occurrenceCount;
  }


  /**
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
   * @param interpretedFrom the interpretedFrom to set
   */
  public void setInterpretedFrom(String interpretedFrom) {
    this.interpretedFrom = interpretedFrom;
  }

  /**
   * @param isoDepartmentCode the isoDepartmentCode to set
   */
  public void setIsoDepartmentCode(String isoDepartmentCode) {
    this.isoDepartmentCode = isoDepartmentCode;
  }

  /**
   * @param key the key to set
   */
  public void setKey(String key) {
    this.key = key;
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
