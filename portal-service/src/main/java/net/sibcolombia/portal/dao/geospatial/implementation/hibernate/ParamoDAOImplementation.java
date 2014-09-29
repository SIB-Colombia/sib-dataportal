package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.dao.geospatial.ParamoDAO;
import net.sibcolombia.portal.model.geospatial.Paramo;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class ParamoDAOImplementation extends HibernateDaoSupport implements ParamoDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findParamosFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select p from Paramo p where (p.complex like :name");
        if (anyOccurrence) {
          sb.append(" or p.complex like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by p.complex");

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
  
  public List<Character> getParamoAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> ParamoChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(Paramo.complex,1,1)) FROM Paramo ORDER BY Paramo.complex ASC");
        return query.list();
      }
    });
    ArrayList<Character> chars = new ArrayList<Character>();
    for (String result : ParamoChars) {
      if (StringUtils.isNotEmpty(result))
        chars.add(new Character(Character.toUpperCase(result.charAt(0))));
    }
    Collections.sort(chars);
    return chars;
  }

  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.ParamoDAO#getParamoFor(long)
   */
  public Object getParamoFor(final long ParamoId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from Paramo p where p.paramoId=:paramoId");
        query.setLong("paramoId", ParamoId);
        return query.uniqueResult();
      }
    });
  }
  
  public Object getParamoForComplexId(final String complexId) {
	    return getHibernateTemplate().execute(new HibernateCallback() {

	      public Object doInHibernate(Session session) {
	        Query query = session.createQuery("from Paramo p where p.complexId =:complexId");
	        query.setString("complexId", complexId);
	        return query.uniqueResult();
	      }
	    });
	  }

 /**
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getParamoCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getParamoCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tp.complex_id the_complex_id, "
              + " tp.complex_id the_complex_id2, p.complex as p_complex, tp.count as the_count from taxon_paramo tp"
              + " inner join paramo p on tp.complex_id = p.complex_id"
              + " where tp.taxon_concept_id=:taxonConceptId order by p_complex");
        query.setParameter("taxonConceptId", taxonConceptId);
        query.addScalar("the_complex_id", Hibernate.STRING);
        query.addScalar("the_complex_id2", Hibernate.STRING);
        query.addScalar("the_count", Hibernate.INTEGER);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  @SuppressWarnings("unchecked")
  public List<Paramo> getParamosFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Paramo>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT p.complexId AS complexId, p.complex AS complexName, p.sector AS sector, p.district AS district, p.occurrenceCount AS occurrenceCount, p.speciesCount AS speciesCount, p.contextCount AS contextCount FROM Paramo p WHERE p.complex LIKE :name ORDER BY complex ASC");
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
