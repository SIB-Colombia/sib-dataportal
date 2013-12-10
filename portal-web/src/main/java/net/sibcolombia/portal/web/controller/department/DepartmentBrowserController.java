package net.sibcolombia.portal.web.controller.department;

import org.gbif.portal.dto.geospatial.CountryDTO;
import org.gbif.portal.dto.util.BoundingBoxDTO;
import org.gbif.portal.dto.util.EntityType;
import org.gbif.portal.service.GeospatialManager;
import org.gbif.portal.service.ServiceException;
import org.gbif.portal.web.content.map.MapContentProvider;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.service.DepartmentManager;
import org.jfree.util.Log;
import org.springframework.web.bind.ServletRequestUtils;
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
  /** Map Content Provider for map utilities */
  protected MapContentProvider mapContentProvider;

  /** The Model Key for the retrieve list of departments */
  protected String departmentsModelKey = "departments";

  /** The Model Key for the retrieve list of departments */
  protected String countryModelKey = "country";

  /*
   * SIB Colombia
   * Attributes to support country details inside departments list
   */
  protected String zoomRequestKey = "zoom";
  protected String resourceCountsModelKey = "resourceCounts";
  protected String nonResourceCountsModelKey = "nonResourceCounts";
  protected String countryCountsModelKey = "countryCounts";
  protected String nonCountryCountsModelKey = "nonCountryCounts";
  protected String hostedModelKey = "hosted";
  protected boolean sortResourcesByCount = false;

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
    CountryDTO country = geospatialManager.getCountryForIsoCountryCode("BR", locale);

    boolean showHosted = ServletRequestUtils.getBooleanParameter(request, hostedModelKey, false);
    EntityType entityType = null;
    if (showHosted) {
      entityType = EntityType.TYPE_HOME_COUNTRY;
    } else {
      entityType = EntityType.TYPE_COUNTRY;
    }

    // if zoom level not specified, jump to correct zoom level for this country
    if (!MapContentProvider.zoomLevelSpecified(request) && !showHosted && country.getMinLongitude() != null
      && country.getMinLatitude() != null && country.getMaxLongitude() != null && country.getMaxLatitude() != null) {
      // zoom to the correct level for this country
      mapContentProvider.addMapContent(request, entityType.getName(), country.getKey(), country.getMinLongitude(),
        country.getMinLatitude(), country.getMaxLongitude(), country.getMaxLatitude());
      try {
        mapContentProvider.addPointsTotalsToRequest(
          request,
          entityType,
          country.getKey(),
          new BoundingBoxDTO(country.getMinLongitude(), country.getMinLatitude(), country.getMaxLongitude(), country
            .getMaxLatitude()));
      } catch (ServiceException error) {
        Log.error("Error filling data map: " + error.getMessage());
      }
    } else {
      // zoom to the level specified in the request
      mapContentProvider.addMapContent(request, entityType.getName(), country.getKey());
      try {
        mapContentProvider.addPointsTotalsToRequest(request, entityType, country.getKey(), null);
      } catch (ServiceException error) {
        Log.error("Error filling data map: " + error.getMessage());
      }
    }

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
   * @param countryModelKey the countryModelKey to set
   */
  public void setCountryModelKey(String countryModelKey) {
    this.countryModelKey = countryModelKey;
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
   * @param mapContentProvider the mapContentProvider to set
   */
  public void setMapContentProvider(MapContentProvider mapContentProvider) {
    this.mapContentProvider = mapContentProvider;
  }

  /**
   * @param modelViewName the modelViewName to set
   */
  @Override
  public void setModelViewName(String modelViewName) {
    this.modelViewName = modelViewName;
  }

  /**
   * @param resourceCountsModelKey the resourceCountsModelKey to set
   */
  public void setResourceCountsModelKey(String resourceCountsModelKey) {
    this.resourceCountsModelKey = resourceCountsModelKey;
  }

  /**
   * @param sortResourcesByCount the sortResourcesByCount to set
   */
  public void setSortResourcesByCount(boolean sortResourcesByCount) {
    this.sortResourcesByCount = sortResourcesByCount;
  }

  /**
   * @param zoomRequestKey the zoomRequestKey to set
   */
  public void setZoomRequestKey(String zoomRequestKey) {
    this.zoomRequestKey = zoomRequestKey;
  }

}
