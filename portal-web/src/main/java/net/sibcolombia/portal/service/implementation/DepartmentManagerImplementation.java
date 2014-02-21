package net.sibcolombia.portal.service.implementation;

import org.gbif.portal.dao.resources.DataResourceDAO;
import org.gbif.portal.dto.CountDTO;
import org.gbif.portal.dto.DTOFactory;
import org.gbif.portal.service.ServiceException;
import org.gbif.portal.webservices.actions.DensityAction;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.dao.geospatial.DepartmentDAO;
import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.dto.department.DepartmentDTOFactory;
import net.sibcolombia.portal.model.geospatial.Department;
import net.sibcolombia.portal.service.DepartmentManager;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

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

  /** Data Resource DAO */
  protected DataResourceDAO dataResourceDAO;

  /** DTO factories */
  /** DTO Factory for CountDTOs */
  protected DTOFactory countDTOFactory;

  public static Log log = LogFactory.getLog(DensityAction.class);

  protected static Long parseKey(String key) {
    Long parsedKey = null;
    try {
      parsedKey = Long.parseLong(key);
    } catch (NumberFormatException e) {
      // expected behaviour for invalid keys
    }
    return parsedKey;
  }

  @SuppressWarnings("unchecked")
  public List<CountDTO> getDataResourceCountsForDepartment(String isoDepartmentCode, boolean georeferencedOnly)
    throws ServiceException {
    List<Object[]> counts = dataResourceDAO.getDataResourceCountsForCountry(isoDepartmentCode, georeferencedOnly);
    return countDTOFactory.createDTOList(counts);
  }

  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getDepartmentAlphabet()
   */
  public List<Character> getDepartmentAlphabet() {
    return departmentDAO.getDepartmentAlphabet();
  }

  @SuppressWarnings("unchecked")
  public List<CountDTO> getDepartmentCountsForDepartment(String isoDepartmentCode, boolean geoRefOnly, Locale locale)
    throws ServiceException {
    List<Object[]> counts = departmentDAO.getDepartmentCountsForDepartment(isoDepartmentCode, geoRefOnly, locale);
    return countDTOFactory.createDTOList(counts);
  }

  public DepartmentDTO getDepartmentFor(String departmentKey) {
    Long departmentId = parseKey(departmentKey);
    if (departmentId == null)
      return getDepartmentForIsoDepartmentCode(departmentKey);
    Object department = departmentDAO.getDepartmentFor(departmentId);
    return (DepartmentDTO) departmentDTOFactory.createDTOSingle(department);
  }


  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getDepartmentForIsoDepartmentCode(java.lang.String,
   *      java.util.Locale)
   */
  public DepartmentDTO getDepartmentForIsoDepartmentCode(String isoDepartmentCode) {
    log.debug("isoDepartmentCode:" + isoDepartmentCode);
    Object department = departmentDAO.getDepartmentForIsoDepartmentCode(isoDepartmentCode);
    return (DepartmentDTO) departmentDTOFactory.createDTOSingleId(department);
  }


  public List<DepartmentDTO> getDepartmentsFor(Character firstChar) {
    List<Department> departments = departmentDAO.getDepartmentsFor(firstChar);
    return departmentDTOFactory.createDTOList(departments);
  }

  public List<DepartmentDTO> getDepartmentsCountForTaxonConcept() {
	    List<Department> departments = departmentDAO.getDepartmentsCountsForTaxonConcept();
	    return departmentDTOFactory.createDTOList(departments);
  }
  
  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getTotalDepartmentCount()
   */
  public int getTotalDepartmentCount() throws ServiceException {
    return departmentDAO.getTotalDepartmentCount();
  }

  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getTotalCountyCount()
   */
  public int getTotalCountyCount() throws ServiceException {
    return departmentDAO.getTotalCountyCount();
  }
  
  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getTotalParamoCount()
   */
  public int getTotalParamoCount() throws ServiceException {
    return departmentDAO.getTotalParamoCount();
  }
  
  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#getTotalMarineZoneCount()
   */
  public int getTotalMarineZoneCount() throws ServiceException {
    return departmentDAO.getTotalMarineZoneCount();
  }
  
  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#isValidDepartmentKey(java.lang.String)
   */
  public boolean isValidDepartmentKey(String departmentKey) {
    return parseKey(departmentKey) != null;
  }

  /**
   * @see net.sibcolombia.portal.service.DepartmentManager#isValidISODepartmentCode(java.lang.String)
   */
  public boolean isValidISODepartmentCode(String isoDepartmentCode) {
    if (isoDepartmentCode != null && (isoDepartmentCode.length() == 6 || isoDepartmentCode.length() == 5)) {
      if (!NumberUtils.isNumber(isoDepartmentCode))
        return true;
    }
    return false;
  }

  /**
   * @param dataResourceDAO the dataResourceDAO to set
   */
  public void setDataResourceDAO(DataResourceDAO dataResourceDAO) {
    this.dataResourceDAO = dataResourceDAO;
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
}