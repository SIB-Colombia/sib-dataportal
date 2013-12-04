package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.County;

/**
 * The DAO for the County model object.
 * 
 * @author Maria Fernanda Cubillos
 */
public interface CountyDAO {

  /**
   * Retrieve a list of counties with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing CountryDTO objects.
   */
  public List<Object[]> findCountiesFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of counties
   * 
   * @return list of characters
   */
  public List<Character> getCountyAlphabet();

  /**
   * Use the taxon_county table to retrieve the counties with data for this taxon.
   * 
   * @param taxonConceptId
   * @return
   */
  public List<Object[]> getCountyCountsForTaxonConcept(long taxonConceptId);
  
   /**
   * Retrieve the county for the supplied Id.
   * 
   * @param countyId the internal system id for this county
   * @return
   */
  public Object getCountyFor(long countyId);

  /**
   * Retrieve the county for Colombia ISO county code.
   * 
   * @param isoCountyCode the ISO County code
   * @return Object[2], Object[0]=Country, Object[1]=locale specific name/
   */
  public Object getCountyForIsoCountyCode(String isoCountyCode);

  /**
   * Retrieves all the counties starting with the supplied char or all the counties if char is null.
   * 
   * @param theChar
   * @return List of counties with ocurrence and ocurrence coordinate count
   */
  public List<County> getCountiesFor(Character theChar);

}
