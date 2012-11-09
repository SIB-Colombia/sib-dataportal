package net.sibcolombia.portal.model;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * Holds details about current deparments, departments code, ocurrence count and ocurrence coordinate count
 * 
 * @author Valentina Grajales {@link "mailto:valegrajales@gmail.com"}
 */
public class Department {

  // Department name
  private String departmentName;
  // Department code
  private String departmentCode;
  // Ocurrence count
  private int ocurrenceCount;
  // Ocurrence Coordinate Count
  private int ocurrenceCoordinateCount;

  /**
   * Returns true if object is an instance of BaseObject and
   * the identifier value is equal.
   * Required by ORMS for caching/collections performance.
   * 
   * @see java.lang.Object#equals(Object)
   */
  @Override
  public boolean equals(Object object) {
    if (object instanceof Department) {
      Department other = (Department) object;
      if (this.getDepartmentCode() != null) {
        return this.getDepartmentCode().equals(other.getDepartmentCode());
      } else if (this == object) {
        return true;
      }
    }
    return false;
  }

  /**
   * @return the departmentCode
   */
  public String getDepartmentCode() {
    return departmentCode;
  }

  /**
   * @return the departmentName
   */
  public String getDepartmentName() {
    return departmentName;
  }

  /**
   * @return the ocurrenceCoordinateCount
   */
  public int getOcurrenceCoordinateCount() {
    return ocurrenceCoordinateCount;
  }

  /**
   * @return the ocurrenceCount
   */
  public int getOcurrenceCount() {
    return ocurrenceCount;
  }

  /**
   * @param departmentCode the departmentCode to set
   */
  public void setDepartmentCode(String departmentCode) {
    this.departmentCode = departmentCode;
  }

  /**
   * @param departmentName the departmentName to set
   */
  public void setDepartmentName(String departmentName) {
    this.departmentName = departmentName;
  }

  /**
   * @param ocurrenceCoordinateCount the ocurrenceCoordinateCount to set
   */
  public void setOcurrenceCoordinateCount(int ocurrenceCoordinateCount) {
    this.ocurrenceCoordinateCount = ocurrenceCoordinateCount;
  }

  /**
   * @param ocurrenceCount the ocurrenceCount to set
   */
  public void setOcurrenceCount(int ocurrenceCount) {
    this.ocurrenceCount = ocurrenceCount;
  }

  /**
   * @see java.lang.Object#toString()
   */
  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }


}
