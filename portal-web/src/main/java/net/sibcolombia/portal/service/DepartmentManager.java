package net.sibcolombia.portal.service;

import java.util.List;

import net.sibcolombia.portal.dto.department.DepartmentDTO;

/**
 * Service interface for department methods
 * 
 * @author Valentina Grajales
 * @author {@link "mailto:valegrajales@gmail.com"}
 */
public interface DepartmentManager {

  /**
   * Retrieves the departments alphabet information
   * 
   * @return List of first character of departments names.
   */
  public List<Character> getDepartmentAlphabet();

  /**
   * Retrieves the department information for the country with the supplied key, if supplied key is null return without
   * filter.
   * 
   * @param departmentKey the system key for this department
   * @param locale the locale to use for retrieving locale specific information
   * @return DepartmentDTO holding details of this department, null if there isnt a department for the specified key.
   */
  public DepartmentDTO getDepartmentFor(String departmentKey);

  /**
   * Retrieves a distinct list of the departments with the name starting with the supplied char.
   * Additional sorting involves including departments in a resultset that do not have names that start with
   * the supplied char but logically (or politically) should be returned with the supplied search criteria.
   * 
   * @param firstChar
   * @param additionSorting whether to allow additional sorting
   * @param locale
   * @return list of departments
   */
  public List<DepartmentDTO> getDepartmentsFor(Character firstChar);

}
