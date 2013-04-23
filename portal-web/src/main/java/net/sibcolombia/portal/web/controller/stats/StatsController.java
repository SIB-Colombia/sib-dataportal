package net.sibcolombia.portal.web.controller.stats;



import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.gbif.portal.dto.resources.ResourceNetworkDTO;
import org.gbif.portal.dto.resources.DataResourceDTO;
import org.gbif.portal.dto.resources.DataProviderDTO;
import org.gbif.portal.dto.SearchResultsDTO;
import org.gbif.portal.dto.util.SearchConstraints;
import org.gbif.portal.service.DataResourceManager;
import org.gbif.portal.service.ServiceException;
import org.gbif.portal.web.content.map.MapContentProvider;
import org.gbif.portal.web.controller.RestController;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.service.DepartmentManager;
//import org.gbif.portal.service.OccurrenceManager;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


/**
 * Controller for browsing departments in Colombia
 * 
 * @author Oscar Duque
 */
public class StatsController implements Controller {
  protected static Log logger = LogFactory.getLog(RestController.class);
	/** The browser view name */
  protected String modelViewName;
  /** Manager providing department information */
  protected DepartmentManager departmentManager;
  /** Map Content Provider for map utilities */
  protected MapContentProvider mapContentProvider;
  /** Provides the data resource/provider */
  protected DataResourceManager dataResourceManager;
  
  
  protected String datasetMatchesModelKey = "datasetMatches";
  /** Model Key for the data resource matches */
  protected String dataResourceModelKey = "dataResources";
  /** Model Key for the data provider matches */
  protected String dataProviderModelKey = "dataProviders";
  /** Model Key for the data provider matches */
  protected String resourceNetworksModelKey = "resourceNetworks";

  /** The Model Key for the retrieve list of departments */
  protected String departmentsModelKey = "departments";
  
  protected String dataModelKey = "dataDate";
  protected String dataTreeModelkey="dataTree";
  
  protected DataProviderDTO nubDataProvider;
  protected List<DataResourceDTO> nubResources;

  /*
   * SIB Colombia
   * Attributes to support country details inside departments list
   */
  protected String resourceCountsModelKey = "resourceCounts";
  protected String nonResourceCountsModelKey = "nonResourceCounts";
  protected String hostedModelKey = "hosted";
  protected boolean sortResourcesByCount = false;
  
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

  @SuppressWarnings("unchecked")
  public ModelAndView listStats(ModelAndView mav, HttpServletRequest request,
    HttpServletResponse response) {
    List<DepartmentDTO> departments = departmentManager.getDepartmentsFor(null);
	
    SearchResultsDTO resourceResultsDTO = null;
	resourceResultsDTO = dataResourceManager.findDatasets("", true, false, false, new SearchConstraints(0, null));
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
    
    List<String> dataDate = dataResourceManager.getOcurrencePerMonth();
    
    List<String> resl =new ArrayList<String>();
    List<DataResourceDTO> resourcesTemp = new ArrayList<DataResourceDTO>();
    String resultp="";
    String resultr="";
    for(DataProviderDTO provider: providers){
    	resultp="";
    	provider.getKey();
    	provider.getName();
    	//resultp=provider.getName()+"|Publicadores|"+provider.getOccurrenceCount()+"|"+provider.getOccurrenceCoordinateCount();
    	resultp=provider.getName()+"|Publicadores|"+provider.getOccurrenceCoordinateCount()+"|"+provider.getOccurrenceCount();
    	resl.add(resultp);
    	try {
    		resourcesTemp=dataResourceManager.getDataResourcesForProvider(provider.getKey());
    		resultr="";
    		for(DataResourceDTO resource: resourcesTemp){
    			//resultr=resource.getName()+" |"+provider.getName()+"|"+resource.getOccurrenceCount()+"|"+resource.getOccurrenceCoordinateCount();
    			resultr=resource.getName()+" |"+provider.getName()+"|"+resource.getOccurrenceCoordinateCount()+"|"+resource.getOccurrenceCount();
    			resl.add(resultr);
    		}
			
		} catch (ServiceException err) {
			logger.error("Error filling data for resources: "+err.getMessage());
		}
    }

    mav.addObject(departmentsModelKey, departments);
	mav.addObject(datasetMatchesModelKey, resourceResultsDTO);
    mav.addObject(resourceNetworksModelKey, resourceNetworks);
    mav.addObject(dataProviderModelKey, providers);
    mav.addObject(dataResourceModelKey, resources);
    mav.addObject(dataModelKey, dataDate);
    mav.addObject(dataTreeModelkey, resl);
    
    return mav;
  }
  
    public String getModelViewName() {
	return modelViewName;
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
  
  
  public ModelAndView handleRequest(HttpServletRequest request,
    HttpServletResponse response) throws Exception {
    ModelAndView mav = new ModelAndView(modelViewName);
    return listStats(mav, request, response);
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
  
  public void setModelViewName(String modelViewName) {
		this.modelViewName = modelViewName;
	}

	public DataResourceManager getDataResourceManager() {
		return dataResourceManager;
	}

	public void setDataResourceManager(DataResourceManager dataResourceManager) {
		this.dataResourceManager = dataResourceManager;
	}

	public String getDatasetMatchesModelKey() {
		return datasetMatchesModelKey;
	}

	public void setDatasetMatchesModelKey(String datasetMatchesModelKey) {
		this.datasetMatchesModelKey = datasetMatchesModelKey;
	}

	public String getDataResourceModelKey() {
		return dataResourceModelKey;
	}

	public void setDataResourceModelKey(String dataResourceModelKey) {
		this.dataResourceModelKey = dataResourceModelKey;
	}

	public String getDataProviderModelKey() {
		return dataProviderModelKey;
	}

	public void setDataProviderModelKey(String dataProviderModelKey) {
		this.dataProviderModelKey = dataProviderModelKey;
	}

	public String getResourceNetworksModelKey() {
		return resourceNetworksModelKey;
	}

	public void setResourceNetworksModelKey(String resourceNetworksModelKey) {
		this.resourceNetworksModelKey = resourceNetworksModelKey;
	}

	public DataProviderDTO getNubDataProvider() {
		return nubDataProvider;
	}

	public void setNubDataProvider(DataProviderDTO nubDataProvider) {
		this.nubDataProvider = nubDataProvider;
	}

	public List<DataResourceDTO> getNubResources() {
		return nubResources;
	}

	public void setNubResources(List<DataResourceDTO> nubResources) {
		this.nubResources = nubResources;
	}

	public String getNonResourceCountsModelKey() {
		return nonResourceCountsModelKey;
	}

	public void setNonResourceCountsModelKey(String nonResourceCountsModelKey) {
		this.nonResourceCountsModelKey = nonResourceCountsModelKey;
	}

	public String getHostedModelKey() {
		return hostedModelKey;
	}

	public void setHostedModelKey(String hostedModelKey) {
		this.hostedModelKey = hostedModelKey;
	}

	public boolean isHideNub() {
		return hideNub;
	}

	public void setHideNub(boolean hideNub) {
		this.hideNub = hideNub;
	}

	public DepartmentManager getDepartmentManager() {
		return departmentManager;
	}

	public MapContentProvider getMapContentProvider() {
		return mapContentProvider;
	}

	public String getDepartmentsModelKey() {
		return departmentsModelKey;
	}

	public String getResourceCountsModelKey() {
		return resourceCountsModelKey;
	}

	public boolean isSortResourcesByCount() {
		return sortResourcesByCount;
	}




}