package net.sibcolombia.portal.web.controller.dataset;

import org.gbif.portal.dto.SearchResultsDTO;
import org.gbif.portal.dto.resources.DataProviderDTO;
import org.gbif.portal.dto.resources.DataResourceDTO;
import org.gbif.portal.dto.resources.ResourceNetworkDTO;
import org.gbif.portal.dto.util.SearchConstraints;
import org.gbif.portal.service.DataResourceManager;
import org.gbif.portal.service.ServiceException;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;


public class DatasetBrowserController extends net.sibcolombia.portal.web.controller.AlphabetBrowserController {

  /** Provides the data resource/provider */
  protected DataResourceManager dataResourceManager;
  /** Model Key for the dataset matches */
  protected String datasetMatchesModelKey = "datasetMatches";
  /** Model Key for the data resource matches */
  protected String dataResourceModelKey = "dataResources";
  /** Model Key for the data provider matches */
  protected String dataProviderModelKey = "dataProviders";
  /** Model Key for the data provider matches */
  protected String resourceNetworksModelKey = "resourceNetworks";
  
  /** total ocurrence count */
  protected String totalOcurrenceCount="totalOcurrenceCount";
  
  /** total ocurrence coordinate count */
  protected String totalOcurrenceCoordinateCount="totalOcurrenceCoordinateCount";

  protected DataProviderDTO nubDataProvider;
  protected List<DataResourceDTO> nubResources;

  /** Whether to hide the nub provider/resources from the view */
  protected boolean hideNub = true;

  private static Comparator<ResourceNetworkDTO> COMPARERESOURCENETWORK = new Comparator<ResourceNetworkDTO>() {

    public int compare(ResourceNetworkDTO o1, ResourceNetworkDTO o2) {
      return o1.getName().compareTo(o2.getName());
    }
  };

  private static Comparator<DataResourceDTO> COMPARERESOURCES = new Comparator<DataResourceDTO>() {

    public int compare(DataResourceDTO o1, DataResourceDTO o2) {
      return o1.getName().compareTo(o2.getName());
    }
  };

  private static Comparator<DataProviderDTO> COMPAREPROVIDERS = new Comparator<DataProviderDTO>() {

    public int compare(DataProviderDTO o1, DataProviderDTO o2) {
      return o1.getName().compareTo(o2.getName());
    }
  };

  /**
   * @see org.gbif.portal.web.controller.AlphabetBrowserController#alphabetSearch(char,
   *      org.springframework.web.servlet.ModelAndView)
   */
  @SuppressWarnings("unchecked")
  @Override
  public ModelAndView alphabetSearch(char searchChar, ModelAndView mav, HttpServletRequest request,
    HttpServletResponse response) {
    SearchResultsDTO resourceResultsDTO = null;
    if (searchChar != '0') {
      resourceResultsDTO =
        dataResourceManager
          .findDatasets(String.valueOf(searchChar), true, false, false, new SearchConstraints(0, null));
    } else {
      resourceResultsDTO = dataResourceManager.findDatasets("", true, false, false, new SearchConstraints(0, null));
    }
    List<Object> resourceMatches = resourceResultsDTO.getResults();

    List<DataProviderDTO> providers = new ArrayList<DataProviderDTO>();
    List<DataResourceDTO> resources = new ArrayList<DataResourceDTO>();
    List<ResourceNetworkDTO> resourceNetworks = new ArrayList<ResourceNetworkDTO>();
    for (Object resourceMatch : resourceMatches) {
      if (resourceMatch instanceof DataProviderDTO)
        providers.add((DataProviderDTO) resourceMatch);
      if (resourceMatch instanceof DataResourceDTO)
        resources.add((DataResourceDTO) resourceMatch);
      if (resourceMatch instanceof ResourceNetworkDTO)
        resourceNetworks.add((ResourceNetworkDTO) resourceMatch);
    }
    
    

    if (hideNub) {
      removeNubProviderAndResources(providers, resources);
    }
    Collections.sort(resourceNetworks, COMPARERESOURCENETWORK);
    Collections.sort(resources, COMPARERESOURCES);
    Collections.sort(providers, COMPAREPROVIDERS);
    mav.addObject(datasetMatchesModelKey, resourceResultsDTO);
    mav.addObject(resourceNetworksModelKey, resourceNetworks);
    mav.addObject(dataProviderModelKey, providers);
    mav.addObject(dataResourceModelKey, resources);
    //mav.addObject(totalnumber, 154);
    try {
		int ocurrenceCount = dataResourceManager.getTotalOcurrenceCount();
		int ocurrenceCoordinateCount = dataResourceManager.getTotalOcurrenceCoordinateCount();
		mav.addObject(totalOcurrenceCount, ocurrenceCount);
		mav.addObject(totalOcurrenceCoordinateCount, ocurrenceCoordinateCount);
	} catch (ServiceException e) {
		logger.error("Total occurrence count cannot be found, setting to 0", e);
		logger.error("Total occurrence with coordinate count cannot be found, setting to 0", e);
		mav.addObject(totalOcurrenceCount, 0);
		mav.addObject(totalOcurrenceCoordinateCount, 0);
	}
    
    
    return mav;
  }

  /**
   * Remove the nub provider/resources from the datasets list.
   * 
   * @param providers
   * @param resources
   */
  protected void removeNubProviderAndResources(List<DataProviderDTO> providers, List<DataResourceDTO> resources) {
    if (nubDataProvider == null) {
      try {
        nubDataProvider = dataResourceManager.getNubDataProvider();
        if (nubDataProvider != null) {
          providers.remove(nubDataProvider);
          nubResources = dataResourceManager.getDataResourcesForProvider(nubDataProvider.getKey());
          if (nubResources != null)
            resources.removeAll(nubResources);
        }
      } catch (ServiceException e) {
        logger.error(e.getMessage(), e);
      }
    }
  }

  @Override
  public List<Character> retrieveAlphabet(HttpServletRequest request, HttpServletResponse response) {
    return dataResourceManager.getDatasetAlphabet();
  }

  /**
   * @param dataProviderModelKey the dataProviderModelKey to set
   */
  public void setDataProviderModelKey(String dataProviderModelKey) {
    this.dataProviderModelKey = dataProviderModelKey;
  }

  /**
   * @param dataResourceManager the dataResourceManager to set
   */
  public void setDataResourceManager(DataResourceManager dataResourceManager) {
    this.dataResourceManager = dataResourceManager;
  }

  /**
   * @param dataResourceModelKey the dataResourceModelKey to set
   */
  public void setDataResourceModelKey(String dataResourceModelKey) {
    this.dataResourceModelKey = dataResourceModelKey;
  }

  /**
   * @param datasetMatchesModelKey the datasetMatchesModelKey to set
   */
  public void setDatasetMatchesModelKey(String datasetMatchesModelKey) {
    this.datasetMatchesModelKey = datasetMatchesModelKey;
  }

}
