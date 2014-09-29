package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.sibcolombia.portal.dao.geospatial.ProtectedAreaDAO;
import net.sibcolombia.portal.model.geospatial.ProtectedArea;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class ProtectedAreaDAOImplementation extends HibernateDaoSupport implements ProtectedAreaDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findProtectedAreasFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select pa from ProtectedArea pa where (pa.paId like :name");
        if (anyOccurrence) {
          sb.append(" or pa.paId like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by pa.paId");

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
  
  public List<Character> getProtectedAreaAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> protectedAreaChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(ProtectedArea.paId,1,1)) FROM ProtectedArea ORDER BY ProtectedArea.paId ASC");
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
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getProtectedAreaCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getProtectedAreaCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tp.protected_area_id the_protected_area_id, "
              + " tp.protected_area_id the_protected_area_id2, pa.paId as pa_paId, tp.count as the_count from taxon_protected_area tp"
              + " inner join protected_area pa on tp.protected_area_id = pa.pa_id"
              + " where tp.taxon_concept_id=:taxonConceptId order by pa_paId");
        query.setParameter("taxonConceptId", taxonConceptId);
        query.addScalar("the_protected_area_id", Hibernate.STRING);
        query.addScalar("the_protected_area_id2", Hibernate.STRING);
        query.addScalar("the_count", Hibernate.INTEGER);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.ProtectedAreaDAO#getProtectedAreaFor(long)
   */
  public Object getProtectedAreaFor(final long protectedAreaId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from ProtectedArea pa where pa.protectedAreaId=:protectedAreaId");
        query.setLong("protectedAreaId", protectedAreaId);
        return query.uniqueResult();
      }
    });
  }
  
  public Object getProtectedAreaForProtectedArea(final String protectedArea) {
	    return getHibernateTemplate().execute(new HibernateCallback() {

	      public Object doInHibernate(Session session) {
	        Query query = session.createQuery("from ProtectedArea pa where pa.paId =:paId");
	        query.setString("paId", protectedArea);
	        return query.uniqueResult();
	      }
	    });
	  }


  @SuppressWarnings("unchecked")
  public List<ProtectedArea> getProtectedAreaFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<ProtectedArea>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT pa.paId AS paId, pa.name AS name, pa.description AS description, pa.occurrenceCount AS occurrenceCount, pa.speciesCount AS speciesCount, pa.contextCount AS contextCount FROM ProtectedArea pa WHERE pa.name LIKE :name ORDER BY name ASC");
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