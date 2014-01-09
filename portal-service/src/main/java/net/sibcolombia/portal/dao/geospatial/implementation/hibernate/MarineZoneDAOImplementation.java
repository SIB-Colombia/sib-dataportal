package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.dao.geospatial.MarineZoneDAO;
import net.sibcolombia.portal.model.geospatial.MarineZone;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class MarineZoneDAOImplementation extends HibernateDaoSupport implements MarineZoneDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findMarineZonesFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select m from MarineZone m where (m.mask like :name");
        if (anyOccurrence) {
          sb.append(" or m.mask like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by m.mask");

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
  
  public List<Character> getMarineZoneAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> marineZoneChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(MarineZone.mask,1,1)) FROM MarineZone ORDER BY MarineZone.mask ASC");
        return query.list();
      }
    });
    ArrayList<Character> chars = new ArrayList<Character>();
    for (String result : marineZoneChars) {
      if (StringUtils.isNotEmpty(result))
        chars.add(new Character(Character.toUpperCase(result.charAt(0))));
    }
    Collections.sort(chars);
    return chars;
  }

  /**
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getMarineZoneCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getMarineZoneCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tm.marine_id the_marine_id, "
              + " tm.marine_id the_marine_id2, m.mask as m_mask, tm.count as the_count from taxon_marine_zone tm"
              + " inner join marine_zone m on tm.marine_id = m.mask"
              + " where tp.taxon_concept_id=:taxonConceptId order by m_mask");
        query.setParameter("taxonConceptId", taxonConceptId);
        query.addScalar("the_marine_id", Hibernate.STRING);
        query.addScalar("the_marine_id2", Hibernate.STRING);
        query.addScalar("the_count", Hibernate.INTEGER);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.ParamoDAO#getParamoFor(long)
   */
  public Object getMarineZoneFor(final long marineZoneId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from MarineZone m where m.marineZoneId=:marineZoneId");
        query.setLong("marineZoneId", marineZoneId);
        return query.uniqueResult();
      }
    });
  }
  
  public Object getMarineZoneForMask(final String mask) {
	    return getHibernateTemplate().execute(new HibernateCallback() {

	      public Object doInHibernate(Session session) {
	        Query query = session.createQuery("from MarineZone m where m.mask =:mask");
	        query.setString("mask", mask);
	        return query.uniqueResult();
	      }
	    });
	  }


  @SuppressWarnings("unchecked")
  public List<MarineZone> getMarineZoneFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<MarineZone>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT m.mask AS mask, m.description AS description, m.occurrenceCount AS occurrenceCount, m.speciesCount AS speciesCount, m.contextCount AS contextCount FROM MarineZone m WHERE m.description LIKE :name ORDER BY description ASC");
        String searchString;
        if (theChar != null) {
          searchString = theChar + "%";
        } else {
          searchString = "%";
        }
        query.setString("name", searchString);
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