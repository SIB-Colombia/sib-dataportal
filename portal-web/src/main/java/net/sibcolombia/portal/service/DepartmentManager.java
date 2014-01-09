package net.sibcolombia.portal.service;

import org.gbif.portal.dto.CountDTO;
import org.gbif.portal.service.ServiceException;

import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.dto.department.DepartmentDTO;


/**
 * Service interface for department methods
 * 
 * @author Valentina Grajales
 * @author {@link "mailto:valegrajales@gmail.com"}
 */
public interface DepartmentManager {

  /**
   * Returns a list of occurrence record counts for data resources in the supplied country.
   * 
   * @param isoDepartmentCode The department key
   * @param georeferencedOnly Whether to only count georeferenced points
   * @return List<CountDTO> containing data resource id, data resource name, data provider name and count
   * @throws ServiceException indicate a failure to retrieve the data due to a network/database connection
   */
  public List<CountDTO> getDataResourceCountsForDepartment(String isoDepartmentCode, boolean georeferencedOnly)
    throws ServiceException;

  /**
   * Retrieves the departments alphabet information
   * 
   * @return List of first character of departments names.
   */
  public List<Character> getDepartmentAlphabet();

  /**
   * Returns a list of occurrence record counts for departments providing data for an country
   * 
   * @param isoDepartmentCode The department key
   * @param geoRefOnly Whether to only count georeferenced points
   * @param locale current locale of the webapps
   * @return List<CountDTO> containing iso department code, department name and count
   * @throws ServiceException indicate a failure to retrieve the data due to a network/database connection
   */
  public List<CountDTO> getDepartmentCountsForDepartment(String isoDepartmentCode, boolean geoRefOnly, Locale locale)
    throws ServiceException;

  /**
   * Retrieves the department information for the department with the supplied key.
   * 
   * @param departmentKey the system key for this department
   * @return DepartmentDTO holding details of this department, null if there isnt a department for the specified key.
   */
  public DepartmentDTO getDepartmentFor(String departmentKey);

  /**
   * Retrieves the department information for the department with the supplied iso department code.
   * 
   * @param isoDepartmentCode the iso department code to use
   * @param locale the locale to use for retrieving locale specific information
   * @return DepartmentDTO holding details of this Department, null if there isnt a Department for the specified key.
   */
  public DepartmentDTO getDepartmentForIsoDepartmentCode(String isoDepartmentCode);

  /**
   * Retrieves a distinct list of the departments with the name starting with the supplied char.
   * Additional sorting involves including departments in a resultset that do not have names that start with
   * the supplied char but logically (or politically) should be returned with the supplied search criteria.
   * 
   * @param firstChar
   * @param additionSorting whether to allow additional sorting
   * @return list of departments
   */
  public List<DepartmentDTO> getDepartmentsFor(Character firstChar);

  /**
   * SIB Colombia New method
   * Returns a count of the total number of departments
   * 
   * @return count of the total number of departments
   * @throws ServiceException indicate a failure to retrieve the data due to a network/database connection
   */
  public int getTotalDepartmentCount() throws ServiceException;
  
  /**
   * SIB Colombia New method
   * Returns a count of the total number of counties
   * 
   * @return count of the total number of counties
   * @throws ServiceException indicate a failure to retrieve the data due to a network/database connection
   */
  public int getTotalCountyCount() throws ServiceException;

  /**
   * SIB Colombia New method
   * Returns a count of the total number of paramos
   * 
   * @return count of the total number of paramos
   * @throws ServiceException indicate a failure to retrieve the data due to a network/database connection
   */
  public int getTotalParamoCount() throws ServiceException;
  
  /**
   * SIB Colombia New method
   * Returns a count of the total number of marine zones
   * 
   * @return count of the total number of marine zones
   * @throws ServiceException indicate a failure to retrieve the data due to a network/database connection
   */
  public int getTotalMarineZoneCount() throws ServiceException;
  
  /**
   * Returns true if the supplied string could be a valid Department Key. This
   * method does not verify a data resource exists for this key, merely that the supplied
   * key is of the correct format.
   * 
   * @see getDepartmentFor(String)
   * @return true if the supplied key is a valid key
   */
  public boolean isValidDepartmentKey(String departmentKey);

  /**
   * Returns true if the supplied string could be a valid ISO Department Code Key. This
   * method does not verify a data resource exists for this key, merely that the supplied
   * key is of the correct format.
   * 
   * @see getDepartmentFor(String)
   * @return true if the supplied key is a valid ISO Department Code
   */
  public boolean isValidISODepartmentCode(String isoDepartmentCode);

  /**
   * Syncronize both lists of "occurrence record counts for data resources in the supplied department".
   * The new lists will depend of the records that have the two lists, using the following rules:
   * - If a record exists in the georef list but not in the nonGeoref list. The record will be added to the
   * nonGeoref list with a value of 0 in its count attribute.
   * - If a record exists in the nonGeoref list but not in the georef list. The record will be added to the
   * georef list with a value of 0 in its count attribute.
   * - Both lists will have the same records in the same order.
   * 
   * @param georeferenced The list with georeferenced counts
   * @param nonGeoreferenced The list with non georeferenced counts.
   */
  public void synchronizeLists(List<CountDTO> georeferenced, List<CountDTO> nonGeoreferenced);
}
