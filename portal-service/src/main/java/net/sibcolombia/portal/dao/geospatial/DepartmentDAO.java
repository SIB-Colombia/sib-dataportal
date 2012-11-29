package net.sibcolombia.portal.dao.geospatial;

import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.model.geospatial.Department;

/**
 * The DAO for the Department model object.
 * 
 * @author Valentina Grajales {@link "mailto:valegrajales@gmail.com"}
 */
public interface DepartmentDAO {

  /**
   * Retrieve a list of departments with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing CountryDTO objects.
   */
  public List<Object[]> findDepartmentsFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of departments
   * 
   * @return list of characters
   */
  public List<Character> getDepartmentAlphabet();

  /**
   * Retrieve counts for departments providing data for the country
   * 
   * @param isoDepartmentCode
   * @param geoRefOnly
   * @return
   */
  public List<Object[]> getDepartmentCountsForDepartment(String isoDepartmentCode, boolean geoRefOnly, Locale locale);

  /**
   * Retrieve the department for the supplied Id.
   * 
   * @param departmentId the internal system id for this department
   * @return
   */
  public Object getDepartmentFor(long departmentId);

  /**
   * Retrieve the department for Colombia ISO Department code.
   * 
   * @param isoDepartmentCode the ISO Department code
   * @return Object[2], Object[0]=Country, Object[1]=locale specific name/
   */
  public Object getDepartmentForIsoDepartmentCode(String isoDepartmentCode);

  /**
   * Retrieves all the departments starting with the supplied char or all the departments if char is null.
   * 
   * @param theChar
   * @return List of departments with ocurrence and ocurrence coordinate count
   */
  public List<Department> getDepartmentsFor(Character theChar);

}
