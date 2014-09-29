package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.MarineZone;

/**
 * The DAO for the MarineZone model object.
 * 
 * @author Maria Fernanda Cubillos
 */
public interface MarineZoneDAO {

  /**
   * Retrieve a list of counties with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing MarineZoneDTO objects.
   */
  public List<Object[]> findMarineZonesFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of Marine Zone
   * 
   * @return list of characters
   */
  public List<Character> getMarineZoneAlphabet();

  /**
   * Use the taxon_marine_zone table to retrieve the Marine Zones with data for this taxon.
   * 
   * @param taxonConceptId
   * @return
   */
  public List<Object[]> getMarineZoneCountsForTaxonConcept(long taxonConceptId);
  
   /**
   * Retrieve the Marine Zone for the supplied Id.
   * 
   * @param paramoId the internal system id for this Marine Zone
   * @return
   */
  public Object getMarineZoneFor(long marineZoneId);

  /**
   * Retrieve the Marine Zone for Colombia mask.
   * 
   * @param mask the marine zone code
   * @return Object[2], Object[0]=Marine Zone, Object[1]=locale specific name/
   */
  public Object getMarineZoneForMask(String mask);

  
  /**
   * Retrieves all the Marine Zones starting with the supplied char or all the Marine Zones if char is null.
   * 
   * @param theChar
   * @return List of Marine Zones with ocurrence and ocurrence coordinate count
   */
  public List<MarineZone> getMarineZoneFor(Character theChar);

}
