package net.sibcolombia.portal.service.implementation;

import java.util.List;

import net.sibcolombia.portal.dao.department.DepartmentDAO;
import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.dto.department.DepartmentDTOFactory;
import net.sibcolombia.portal.model.Department;
import net.sibcolombia.portal.service.DepartmentManager;

/**
 * An implementation of the DepartmentManager interface that makes use of the
 * DAO layer objects for data access.
 * 
 * @author Valentina Grajales {@link "mailto:valegrajales@gmail.com"}
 */
public class DepartmentManagerImplementation implements DepartmentManager {

  /* The DAO for accessing Departments */
  protected DepartmentDAO departmentDAO;
  /* Factory to department initialize */
  protected DepartmentDTOFactory departmentDTOFactory;

  /*
   * (non-Javadoc)
   * @see net.sibcolombia.portal.service.DepartmentManager#getDepartmentAlphabet()
   */
  public List<Character> getDepartmentAlphabet() {
    return departmentDAO.getDepartmentAlphabet();
  }

  public DepartmentDTO getDepartmentFor(String departmentKey) {
    // TODO Auto-generated method stub
    return null;
  }

  public List<DepartmentDTO> getDepartmentsFor(Character firstChar) {
    List<Department> departments = departmentDAO.getDepartmentsFor(firstChar);
    return departmentDTOFactory.createDTOList(departments);
  }

  /**
   * @param departmentDAO the departmentDAO to set
   */
  public void setDepartmentDAO(DepartmentDAO departmentDAO) {
    this.departmentDAO = departmentDAO;
  }

  /**
   * @param departmentDTOFactory the departmentDTOFactory to set
   */
  public void setDepartmentDTOFactory(DepartmentDTOFactory departmentDTOFactory) {
    this.departmentDTOFactory = departmentDTOFactory;
  }

}
