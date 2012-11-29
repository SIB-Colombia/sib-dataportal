package net.sibcolombia.portal.service.implementation;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sibcolombia.portal.dao.geospatial.DepartmentDAO; 
import net.sibcolombia.portal.dto.department.DepartmentDTO;
import org.gbif.portal.dto.DTOFactory;
import org.gbif.portal.dto.CountDTO;
import org.gbif.portal.dto.SearchResultsDTO;
import org.gbif.portal.dto.util.EntityType;
import org.gbif.portal.dto.util.SearchConstraints;
import org.gbif.portal.service.ServiceException;

import net.sibcolombia.portal.dto.department.DepartmentDTOFactory;
import net.sibcolombia.portal.model.geospatial.Department;
import net.sibcolombia.portal.service.DepartmentManager;

/**
 * An implementation of the DepartmentManager interface that makes use of the
 * DAO layer objects for data access.
 * 
 * @author Valentina Grajales {@link "mailto:valegrajales@gmail.com"}
 */
public class DepartmentManagerImplementation implements DepartmentManager {
	
  protected String defaultISOLanguageCode = "en";

  /* The DAO for accessing Departments */
  protected DepartmentDAO departmentDAO;
  /* Factory to department initialize */
  protected DepartmentDTOFactory departmentDTOFactory;
  
  /** DTO factories */
  /** DTO Factory for CountDTOs */
  protected DTOFactory countDTOFactory;

  /*
   * (non-Javadoc)
   * @see net.sibcolombia.portal.service.DepartmentManager#getDepartmentAlphabet()
   */
  public List<Character> getDepartmentAlphabet() {
    return departmentDAO.getDepartmentAlphabet();
  }
  
  protected static Long parseKey(String key) {
	    Long parsedKey = null;
	    try {
	      parsedKey = Long.parseLong(key);
	    } catch (NumberFormatException e) {
	      // expected behaviour for invalid keys
	    }
	    return parsedKey;
	  }
/*
  public DepartmentDTO getDepartmentFor(String departmentKey) {
    Long departmentId = parseKey(departmentKey);
    if (departmentId == null)
      return getDepartmentForIsoDepartmentCode(departmentKey);
    Object department = departmentDAO.getDepartmentFor(departmentId);
    return (DepartmentDTO) departmentDTOFactory.createDTO(department);
  }
*/
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
  
  
  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#isValidISODepartmentCode(java.lang.String)
   */
  public boolean isValidISODepartmentCode(String isoDepartmentCode) {
    if (isoDepartmentCode != null && isoDepartmentCode.length() == 2) {
      if (!NumberUtils.isNumber(isoDepartmentCode))
        return true;
    }
    return false;
  }
  

    /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getDepartmentForIsoDepartmentCode(java.lang.String, java.util.Locale)
   */
  /*
  public DepartmentDTO getDepartmentForIsoDepartmentCode(String isoDepartmentCode) {
    Object department = DepartmentDAO.getDepartmentForIsoDepartmentCode(isoDepartmentCode);
    return (DepartmentDTO) departmentDTOFactory.createDTO(department);
  }
  */
   /**
   * @see net.sibcolombia.portal.service.DepartmentManager#isValidDepartmentKey(java.lang.String)
   */
  public boolean isValidDepartmentKey(String departmentKey) {
    return parseKey(departmentKey) != null;
  }
  
    /**
   * @see net.sibcolombia.portal.service.DepartmentManager#findDepartments(java.lang.String, boolean, java.util.Locale,
   *      org.gbif.portal.dto.util.SearchConstraints)
   */
  /*
  public SearchResultsDTO findDepartments(String nameStub, boolean fuzzy, boolean anyOccurrence,
    boolean onlySearchInLocale, Locale locale, SearchConstraints searchConstraints) {

    // search returns a department and the name used to match that department
    List<Object[]> departmentAndInterpretedNames =
      departmentDAO.findDepartmentFor(nameStub, fuzzy, anyOccurrence, onlySearchInLocale, locale,
        searchConstraints.getStartIndex(), 1000);
    // sort out duplicates
    List distinctMatches = new ArrayList<Object[]>();
    List<String> isoCodes = new ArrayList<String>();
    for (Object[] departmentAndInterpretedName : departmentAndInterpretedNames) {
      Department department = (Department) departmentAndInterpretedName[0];
      String interpretedFrom = (String) departmentAndInterpretedName[1];

      if (!isoCodes.contains(department.getIsoDepartmentCode())) {
        isoCodes.add(department.getIsoDepartmentCode());

        // get the locale specific name
        Set<DepartmentName> departmentNames = department.getDepartmentNames();
        // get the locale specific name
        String localeDepartmentName = null;
        // get the locale specific name
        String defaultLocaleDepartmentName = null;

        for (DepartmentName departmentName : departmentNames) {
          if (defaultISOLanguageCode.equals(departmentName.getLocale())) {
            defaultLocaleDepartmentName = departmentName.getName();
            // if supplied locale is null, no point looking further
            if (locale != null)
              break;
          }
          if (locale != null) {
            if (departmentName.getLocale() != null && departmentName.getLocale().equals(locale.getLanguage())) {
              localeDepartmentName = departmentName.getName();
              break;
            }
          }
        }
        if (localeDepartmentName == null) {
          localeDepartmentName = defaultLocaleDepartmentName;
        }
        distinctMatches.add(new Object[] {department, localeDepartmentName, interpretedFrom});
      }
    }

    return departmentDTOFactory.createResultsDTO(distinctMatches, searchConstraints.getMaxResults());
  }
  */
 
  /**
	 * 
	 */
  /*
	public List<CountDTO> getDataResourceCountsForDepartment(String isoDepartmentCode, boolean geoRefOnly)
    throws ServiceException {
    List<Object[]> counts = dataResourceDAO.getDataResourceCountsForDepartment(isoDepartmentCode, geoRefOnly);
    return countDTOFactory.createDTOList(counts);
  }
  
    public List<CountDTO> getDepartmentCountsForDepartment(String isoDepartmentCode, boolean geoRefOnly, Locale locale)
    throws ServiceException {
    List<Object[]> counts = departmentDAO.getDepartmentCountsForDepartment(isoDepartmentCode, geoRefOnly, locale);
    return countDTOFactory.createDTOList(counts);
  }
  
    public void synchronizeLists(List<CountDTO> georeferenced, List<CountDTO> nonGeoreferenced) {
    // Creating a clone list of non georeferenced records.
    List<CountDTO> nonGeoreferencedTemp = new ArrayList<CountDTO>();
    for (CountDTO count : nonGeoreferenced) {
      nonGeoreferencedTemp.add(count);
    }
    // Synchronizing...
    for (CountDTO count : georeferenced) {
      boolean exist = false;
      for (Iterator<CountDTO> iNon = nonGeoreferencedTemp.iterator(); !exist && iNon.hasNext();) {
        CountDTO nonCount = iNon.next();
        if (count.getKey().equals(nonCount.getKey())) {
          iNon.remove();
          exist = true;
        }
      }
      if (!exist) {
        CountDTO newCount = new CountDTO();
        newCount.setKey(count.getKey());
        newCount.setName(count.getName());
        newCount.setProperties(count.getProperties());
        newCount.setCount(0);
        nonGeoreferenced.add(newCount);
      }
    }
    for (CountDTO countTemp : nonGeoreferencedTemp) {
      CountDTO count = new CountDTO();
      count.setKey(countTemp.getKey());
      count.setName(countTemp.getName());
      count.setProperties(countTemp.getProperties());
      count.setCount(0);
      georeferenced.add(count);
    }
    nonGeoreferencedTemp.clear();

    // Both lists should be ordered.
    Collections.sort(georeferenced);
    Collections.sort(nonGeoreferenced);
  }
*/
}
