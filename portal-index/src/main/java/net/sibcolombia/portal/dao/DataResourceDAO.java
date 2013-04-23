package net.sibcolombia.portal.dao;

import org.gbif.portal.model.DataResource;

import java.util.List;


public interface DataResourceDAO extends org.gbif.portal.dao.DataResourceDAO {

  /**
   * Gets all the dataresources
   * 
   * @return The list of dataresources
   */
  public List<DataResource> getAllResources();

}
