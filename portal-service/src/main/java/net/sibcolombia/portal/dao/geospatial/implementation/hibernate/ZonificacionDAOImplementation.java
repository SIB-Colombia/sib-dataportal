package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.sibcolombia.portal.dao.geospatial.ZonificacionDAO;
import net.sibcolombia.portal.model.geospatial.Zonificacion;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class ZonificacionDAOImplementation extends HibernateDaoSupport implements ZonificacionDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findZonificacionesFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select z from Zonificacion z where (z.szh like :name");
        if (anyOccurrence) {
          sb.append(" or z.szh like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by z.szh");

        Query query = session.createQuery(sb.toString());
        String searchString = nameStub;
        if (fuzzy)
          searchString = searchString + '%';
        if (anyOccurrence)
          query.setString("anyPartName", "% " + searchString);

        query.setString("name", searchString);
        query.setFirstResult(startIndex);
        query.setMaxResults(maxResults);
        return query.list();
      }
    });
  }

  @SuppressWarnings("unchecked")
  
  public List<Character> getZonificacionAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> protectedAreaChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(Zonificacion.szh,1,1)) FROM Zonificacion ORDER BY Zonificacion.szh ASC");
        return query.list();
      }
    });
    ArrayList<Character> chars = new ArrayList<Character>();
    for (String result : protectedAreaChars) {
      if (StringUtils.isNotEmpty(result))
        chars.add(new Character(Character.toUpperCase(result.charAt(0))));
    }
    Collections.sort(chars);
    return chars;
  }

  /**
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getZonificacionCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getZonificacionCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tz.zonificacion_id the_zonificacion_id, "
              + " tz.zonificacion_id the_zonificacion_id2, z.szh as z_szh, tz.count as the_count from taxon_zonificacion tz"
              + " inner join zonificacion z on tz.zonificacion_id = z.szh"
              + " where tz.taxon_concept_id=:taxonConceptId order by z_szh");
        query.setParameter("taxonConceptId", taxonConceptId);
        query.addScalar("the_zonificacion_id", Hibernate.STRING);
        query.addScalar("the_zonificacion_id2", Hibernate.STRING);
        query.addScalar("the_count", Hibernate.INTEGER);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.ProtectedAreaDAO#getZonificacionFor(long)
   */
  public Object getZonificacionFor(final long zonificacionId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from Zonificacion z where z.zonificacionId=:zonificacionId");
        query.setLong("zonificacionId", zonificacionId);
        return query.uniqueResult();
      }
    });
  }
  
  public Object getZonificacionForSZH(final String zonificacion) {
	    return getHibernateTemplate().execute(new HibernateCallback() {

	      public Object doInHibernate(Session session) {
	        Query query = session.createQuery("from Zonificacion z where z.szh =:szh");
	        query.setString("szh", zonificacion);
	        return query.uniqueResult();
	      }
	    });
	  }


  @SuppressWarnings("unchecked")
  public List<Zonificacion> getZonificacionFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Zonificacion>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT z.szh AS szh, z.nomszh AS name, z.occurrenceCount AS occurrenceCount, z.speciesCount AS speciesCount, z.contextCount AS contextCount FROM Zonificacion z WHERE z.nomszh LIKE :name ORDER BY nomszh ASC");
        String searchString;
        if (theChar != null) {
          searchString = theChar + "%";
        } else {
          searchString = "%";
        }
        query.setString("nomszh", searchString);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

   /**
   * @param supportedLocales the supportedLocales to set
   */
  public void setSupportedLocales(List<String> supportedLocales) {
    this.supportedLocales = supportedLocales;
  }

}