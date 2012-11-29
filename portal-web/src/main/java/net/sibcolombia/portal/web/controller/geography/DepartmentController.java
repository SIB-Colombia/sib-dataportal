/***************************************************************************
 * Copyright (C) 2005 Global Biodiversity Information Facility Secretariat.
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package net.sibcolombia.portal.web.controller.geography;

import org.gbif.portal.dto.CountDTO;
import org.gbif.portal.dto.util.BoundingBoxDTO;
import org.gbif.portal.dto.util.EntityType;
import org.gbif.portal.web.content.map.MapContentProvider;
import org.gbif.portal.web.controller.RestController;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.service.DepartmentManager;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * A Rest controller for geographic areas and countries.
 * 
 * @author Oscar Duque
 */
public class DepartmentController extends RestController {

  /** GeospatialManager for department queries */
  protected DepartmentManager departmentManager;
  /** Map Content Provider for map utilities */
  protected MapContentProvider mapContentProvider; // *****

  protected String keyRequestKey = "key";
  protected String zoomRequestKey = "zoom";
  protected String departmentModelKey = "department";
  protected String resourceCountsModelKey = "resourceCounts";
  protected String nonResourceCountsModelKey = "nonResourceCounts";
  protected String departmentCountsModelKey = "departmentCounts";
  protected String nonDepartmentCountsModelKey = "nonDepartmentCounts";
  protected String hostedModelKey = "hosted";
  protected boolean sortResourcesByCount = false;

  /**
   * @see org.gbif.portal.web.controller.RestController#handleRequest(java.util.List,
   *      javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
   */
  @Override
  public ModelAndView handleRequest(Map<String, String> properties, HttpServletRequest request,
    HttpServletResponse response) throws Exception {

    String departmentKey = properties.get(keyRequestKey);
    if (StringUtils.isNotEmpty(departmentKey)) {
      DepartmentDTO department = null;
      Locale locale = RequestContextUtils.getLocale(request); // ?
      if (departmentManager.isValidISODepartmentCode(departmentKey)) {
        department = departmentManager.getDepartmentForIsoDepartmentCode(departmentKey);
      } else if (departmentManager.isValidDepartmentKey(departmentKey)) {
        department = departmentManager.getDepartmentFor(departmentKey);
      }

      if (department != null) {
        // sort counts into descending order
        List<CountDTO> resourceCounts =
          departmentManager.getDataResourceCountsForDepartment(department.getIsoDepartmentCode(), true);
        // List<CountDTO> departmentCounts =
        // departmentManager.getDepartmentCountsForDepartment(department.getIsoDepartmentCode(), true, locale);
        // List<CountDTO> nonDepartmentCounts =
        // departmentManager.getDepartmentCountsForDepartment(department.getIsoDepartmentCode(), false, locale);
        List<CountDTO> nonResourceCounts =
          departmentManager.getDataResourceCountsForDepartment(department.getIsoDepartmentCode(), false);
        departmentManager.synchronizeLists(resourceCounts, nonResourceCounts);
        // departmentManager.synchronizeLists(departmentCounts, nonDepartmentCounts);

        if (sortResourcesByCount) {
          Collections.sort(resourceCounts, new Comparator<CountDTO>() {

            public int compare(CountDTO o1, CountDTO o2) {
              if (o1 == null || o2 == null || o1.getCount() == null || o2.getCount() == null)
                return -1;
              return o1.getCount().compareTo(o2.getCount()) * -1;
            }
          });
          Collections.sort(nonResourceCounts, new Comparator<CountDTO>() {

            public int compare(CountDTO o1, CountDTO o2) {
              if (o1 == null || o2 == null || o1.getCount() == null || o2.getCount() == null)
                return -1;
              return o1.getCount().compareTo(o2.getCount()) * -1;
            }
          });
        }

        boolean showHosted = ServletRequestUtils.getBooleanParameter(request, hostedModelKey, false);
        EntityType entityType = null;

        entityType = EntityType.TYPE_DEPARTMENT;

        ModelAndView mav = resolveAndCreateView(properties, request, false);

        mav = resolveAndCreateView(properties, request, false);
        /*
         * mav.addObject(departmentModelKey, department);
         * mav.addObject(resourceCountsModelKey, resourceCounts);
         * mav.addObject(nonResourceCountsModelKey, nonResourceCounts);
         * mav.addObject(departmentCountsModelKey, departmentCounts);
         * mav.addObject(nonDepartmentCountsModelKey, nonDepartmentCounts);
         */

        if (logger.isDebugEnabled())
          logger.debug("Returning details of:" + department);

        // if zoom level not specified, jump to correct zoom level for this department
        if (!MapContentProvider.zoomLevelSpecified(request) && !showHosted && department.getMinLongitude() != null
          && department.getMinLatitude() != null && department.getMaxLongitude() != null
          && department.getMaxLatitude() != null) {
          // zoom to the correct level for this department
          mapContentProvider.addMapContent(request, entityType.getName(), department.getKey(),
            department.getMinLongitude(), department.getMinLatitude(), department.getMaxLongitude(),
            department.getMaxLatitude());
          mapContentProvider.addPointsTotalsToRequest(request, entityType, department.getKey(),
            new BoundingBoxDTO(department.getMinLongitude(), department.getMinLatitude(), department.getMaxLongitude(),
              department.getMaxLatitude()));
        } else {
          // zoom to the level specified in the request
          mapContentProvider.addMapContent(request, entityType.getName(), department.getKey());
          mapContentProvider.addPointsTotalsToRequest(request, entityType, department.getKey(), null);
        }
        return mav;
      }
    }

    return redirectToDefaultView();

  }

  /**
   * @param geospatialManager the geospatialManager to set
   */
  public void setDepartmentManager(DepartmentManager departmentManager) {
    this.departmentManager = departmentManager;
  }

  /**
   * @param departmentModelKey the departmentModelKey to set
   */
  public void setDepartmentModelKey(String departmentModelKey) {
    this.departmentModelKey = departmentModelKey;
  }

  /**
   * @param keyRequestKey the keyRequestKey to set
   */
  public void setKeyRequestKey(String keyRequestKey) {
    this.keyRequestKey = keyRequestKey;
  }

  /**
   * @param mapContentProvider the mapContentProvider to set
   */
  public void setMapContentProvider(MapContentProvider mapContentProvider) {
    this.mapContentProvider = mapContentProvider;
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