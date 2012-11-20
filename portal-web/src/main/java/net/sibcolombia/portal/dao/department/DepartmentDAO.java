package net.sibcolombia.portal.dao.department;

import java.util.List;

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
  public List getDepartmentsFor(Character theChar);

}
