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
  private String isoDepartmentCode;

  // Ocurrence count
  private int occurrenceCount;

  // Ocurrence Coordinate Count
  private int occurrenceCoordinateCount;

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
      if (this.getDepartmentName() != null) {
        return this.getDepartmentName().equals(other.getDepartmentName());
      } else if (this == object) {
        return true;
      }
    }
    return false;
  }

  /**
   * @return the departmentName
   */
  public String getDepartmentName() {
    return departmentName;
  }

  /**
   * @return the isoDepartmentCode
   */
  public String getIsoDepartmentCode() {
    return isoDepartmentCode;
  }


  /**
   * @return the ocurrenceCoordinateCount
   */
  public int getOccurrenceCoordinateCount() {
    return occurrenceCoordinateCount;
  }


  /**
   * @return the ocurrenceCount
   */
  public int getOccurrenceCount() {
    return occurrenceCount;
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
   * @param ocurrenceCoordinateCount the ocurrenceCoordinateCount to set
   */
  public void setOccurrenceCoordinateCount(int ocurrenceCoordinateCount) {
    this.occurrenceCoordinateCount = ocurrenceCoordinateCount;
  }

  /**
   * @param ocurrenceCount the ocurrenceCount to set
   */
  public void setOccurrenceCount(int ocurrenceCount) {
    this.occurrenceCount = ocurrenceCount;
  }

  /**
   * @see java.lang.Object#toString()
   */
  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }


}
