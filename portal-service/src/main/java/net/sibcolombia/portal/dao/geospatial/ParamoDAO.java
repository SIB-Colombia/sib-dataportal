package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.Paramo;

/**
 * The DAO for the Paramo model object.
 * 
 * @author Maria Fernanda Cubillos
 */
public interface ParamoDAO {

  /**
   * Retrieve a list of counties with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing ParamoDTO objects.
   */
  public List<Object[]> findParamosFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of paramos
   * 
   * @return list of characters
   */
  public List<Character> getParamoAlphabet();

  /**
   * Use the taxon_paramo table to retrieve the paramos with data for this taxon.
   * 
   * @param taxonConceptId
   * @return
   */
  public List<Object[]> getParamoCountsForTaxonConcept(long taxonConceptId);
  
   /**
   * Retrieve the paramo for the supplied Id.
   * 
   * @param paramoId the internal system id for this paramo
   * @return
   */
  public Object getParamoFor(long paramoId);

  /**
   * Retrieve the paramo for Colombia complex code.
   * 
   * @param complexId the complex code
   * @return Object[2], Object[0]=Paramo, Object[1]=locale specific name/
   */
  public Object getParamoForComplexId(String complexId);

  
  /**
   * Retrieves all the paramos starting with the supplied char or all the paramos if char is null.
   * 
   * @param theChar
   * @return List of paramos with ocurrence and ocurrence coordinate count
   */
  public List<Paramo> getParamosFor(Character theChar);

}
