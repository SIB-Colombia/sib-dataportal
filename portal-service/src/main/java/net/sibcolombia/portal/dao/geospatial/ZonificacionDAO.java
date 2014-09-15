package net.sibcolombia.portal.dao.geospatial;

import java.util.List;

import net.sibcolombia.portal.model.geospatial.Zonificacion;

/**
 * The DAO for the Zonificacion model object.
 * 
 * @author Maria Fernanda Cubillos
 */
public interface ZonificacionDAO {

  /**
   * Retrieve a list of zonificacion hidrografica with matching the name supplied.
   * 
   * @param nameStub
   * @param fuzzy
   * @return SearchResultsDTO containing ZonificacionDTO objects.
   */
  public List<Object[]> findZonificacionesFor(String nameStub, boolean fuzzy, boolean anyOccurrence, int startIndex,
    int maxResults);

  /**
   * Retrieves a list of distinct first characters from the names of Zonificacion
   * 
   * @return list of characters
   */
  public List<Character> getZonificacionAlphabet();

  /**
   * Use the taxon_zonificacion table to retrieve the Zonificaciones Hidrograficas with data for this taxon.
   * 
   * @param taxonConceptId
   * @return
   */
  public List<Object[]> getZonificacionCountsForTaxonConcept(long taxonConceptId);
  
   /**
   * Retrieve the Zonificacion for the supplied Id.
   * 
   * @param zonificacionId the internal system id for this Protected Area
   * @return
   */
  public Object getZonificacionFor(long zonificacionId);

  /**
   * Retrieve the Zonificacion Hidrografica for Colombia zonificacion.
   * 
   * @param zonificacion the Zonificacion Hidrografica code
   * @return Object[2], Object[0]=Marine Zone, Object[1]=locale specific name/
   */
  public Object getZonificacionForSZH(String zonificacion);

  
  /**
   * Retrieves all the Zonificaciones Hidrograficas starting with the supplied char or all the Zonificaciones Hidrograficas if char is null.
   * 
   * @param theChar
   * @return List of Zonificaciones Hidrograficas with ocurrence and ocurrence coordinate count
   */
  public List<Zonificacion> getZonificacionFor(Character theChar);

}