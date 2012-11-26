package net.sibcolombia.portal.web.controller.department;

import org.gbif.portal.dto.geospatial.CountryDTO;
import org.gbif.portal.service.GeospatialManager;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.service.DepartmentManager;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * Controller for browsing departments in Colombia
 * 
 * @author Valentina Grajales
 * @author {@link "mailto:valegrajales@gmail.com"}
 */
public class DepartmentBrowserController extends net.sibcolombia.portal.web.controller.AlphabetBrowserController {

  /** Manager providing department information */
  protected DepartmentManager departmentManager;

  /** Manager providing country information */
  protected GeospatialManager geospatialManager;

  /** The Model Key for the retrieve list of departments */
  protected String departmentsModelKey = "departments";

  /** The Model Key for the retrieve list of departments */
  protected String countryModelKey = "country";

  @Override
  public ModelAndView alphabetSearch(char searchChar, ModelAndView mav, HttpServletRequest request,
    HttpServletResponse response) {
    // Code to avoid list of all countries after change of AlphabetBrowserController
    Character searchForChar = searchChar;
    if (searchChar == '0') {
      searchForChar = null;
    }
    Locale locale = RequestContextUtils.getLocale(request);
    List<DepartmentDTO> departments = departmentManager.getDepartmentsFor(searchForChar);
    CountryDTO country = geospatialManager.getCountryForIsoCountryCode("CO", locale);
    mav.addObject(selectedCharModelKey, searchChar);
    mav.addObject(departmentsModelKey, departments);
    mav.addObject(countryModelKey, country);
    return mav;
  }


  @Override
  public List<Character> retrieveAlphabet(HttpServletRequest request, HttpServletResponse response) {
    return departmentManager.getDepartmentAlphabet();
  }

  /**
   * @param departmentManager the departmentManager to set
   */
  public void setDepartmentManager(DepartmentManager departmentManager) {
    this.departmentManager = departmentManager;
  }

  /**
   * @param departmentsModelKey the departmentsModelKey to set
   */
  public void setDepartmentsModelKey(String departmentsModelKey) {
    this.departmentsModelKey = departmentsModelKey;
  }

  /**
   * @param geospatialManager the geospatialManager to set
   */
  public void setGeospatialManager(GeospatialManager geospatialManager) {
    this.geospatialManager = geospatialManager;
  }

  /**
   * @param modelViewName the modelViewName to set
   */
  @Override
  public void setModelViewName(String modelViewName) {
    this.modelViewName = modelViewName;
  }

}
