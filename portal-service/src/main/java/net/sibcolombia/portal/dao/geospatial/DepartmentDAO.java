package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.Department;

/**
 * The DAO for the Department model object.
 * 
 * @author Valentina Grajales {@link "mailto:valegrajales@gmail.com"}
 */
public interface DepartmentDAO {

  /**
   * Retrieves a list of distinct first characters from the names of departments
   * 
   * @return list of characters
   */
  public List<Character> getDepartmentAlphabet();

  /**
   * Retrieves all the departments starting with the supplied char or all the departments if char is null.
   * 
   * @param theChar
   * @return List of departments with ocurrence and ocurrence coordinate count
   */
  public List<Department> getDepartmentsFor(Character theChar);

}