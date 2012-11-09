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
  protected String departmentCode;

  /** The locale specific name for this department */
  protected String department;

  /** The number of occurrences records this data resource provides */
  protected Integer occurrenceCount;

  /** The number of occurrences records with geo reference data this data resource provides */
  protected Integer occurrenceCoordinateCount;

  /** The String used to identify the supplied - this will be null when not used in the context of a search */
  protected String interpretedFrom;


  /**
   * @return the department
   */
  public String getDepartment() {
    return department;
  }


  /**
   * @return the isoDepartmentCode
   */
  public String getDepartmentCode() {
    return this.departmentCode;
  }


  /**
   * @return the interpretedFrom
   */
  public String getInterpretedFrom() {
    return interpretedFrom;
  }


  /**
   * @return the key
   */
  public String getKey() {
    return key;
  }


  /**
   * @return the name
   */
  public String getName() {
    return this.department;
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
   * @param department the department to set
   */
  public void setDepartment(String department) {
    this.department = department;
  }

  /**
   * @param departmentCode the departmentCode to set
   */
  public void setDepartmentCode(String departmentCode) {
    this.departmentCode = departmentCode;
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
  public void setIsoDepartmentCode(String departmentCode) {
    this.departmentCode = departmentCode;
  }

  /**
   * @param key the key to set
   */
  public void setKey(String key) {
    this.key = key;
  }

  /**
   * @param name the name to set
   */
  public void setName(String department) {
    this.department = department;
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
   * @see java.lang.Object#toString()
   */
  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }

}
