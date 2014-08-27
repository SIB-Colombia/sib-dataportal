package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.Ecosystem;


/**
 * The DAO for the Ecosystem model object.
 * 
 * @author Maria Fernanda Cubillos
 */
public interface EcosystemDAO {

  /**
   * Retrieve a list of ecosystem with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing ParamoDTO objects.
   */
  public List<Object[]> findEcosystemFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of Ecosystems
   * 
   * @return list of characters
   */
  public List<Character> getEcosystemAlphabet();

  /**
   * Use the taxon_ecosystem table to retrieve the Ecosystems with data for this taxon.
   * 
   * @param taxonConceptId
   * @return
   */
  public List<Object[]> getEcosystemCountsForTaxonConcept(long taxonConceptId);
  
   /**
   * Retrieve the Ecosystem for the supplied Id.
   * 
   * @param paramoId the internal system id for this Ecosystem
   * @return
   */
  public Object getEcosystemFor(long ecosystemId);

  /**
   * Retrieves all the Ecosystems starting with the supplied char or all the Ecosystems if char is null.
   * 
   * @param theChar
   * @return List of Ecosystems with ocurrence and ocurrence coordinate count
   */
  public List<Ecosystem> getEcosystemsFor(Character theChar);

}