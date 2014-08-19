package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.ProtectedArea;

/**
 * The DAO for the ProtectedArea model object.
 * 
 * @author Maria Fernanda Cubillos
 */
public interface ProtectedAreaDAO {

  /**
   * Retrieve a list of protected areas with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing ProtectedAreaDTO objects.
   */
  public List<Object[]> findProtectedAreasFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of Protected Area
   * 
   * @return list of characters
   */
  public List<Character> getProtectedAreaAlphabet();

  /**
   * Use the taxon_protected_area table to retrieve the Protected Areas with data for this taxon.
   * 
   * @param taxonConceptId
   * @return
   */
  public List<Object[]> getProtectedAreaCountsForTaxonConcept(long taxonConceptId);
  
   /**
   * Retrieve the Protected Area for the supplied Id.
   * 
   * @param protectedAreaId the internal system id for this Protected Area
   * @return
   */
  public Object getProtectedAreaFor(long protectedAreaId);

  /**
   * Retrieve the Protected Area for Colombia protectedArea.
   * 
   * @param protectedArea the Protected Area code
   * @return Object[2], Object[0]=Marine Zone, Object[1]=locale specific name/
   */
  public Object getProtectedAreaForProtectedArea(String protectedArea);

  
  /**
   * Retrieves all the Protected Areas starting with the supplied char or all the Protected Areas if char is null.
   * 
   * @param theChar
   * @return List of Protected Areas with ocurrence and ocurrence coordinate count
   */
  public List<ProtectedArea> getProtectedAreaFor(Character theChar);

}
