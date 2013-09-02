package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.dao.geospatial.CountyDAO;
import net.sibcolombia.portal.model.geospatial.County;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class CountyDAOImplementation extends HibernateDaoSupport implements CountyDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findCountiesFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select c from County c where (c.countyName like :name");
        if (anyOccurrence) {
          sb.append(" or c.countyName like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by c.countyName");

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
  
  public List<Character> getCountyAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> CountyChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(County.county_name,1,1)) FROM County ORDER BY County.county_name ASC");
        return query.list();
      }
    });
    ArrayList<Character> chars = new ArrayList<Character>();
    for (String result : CountyChars) {
      if (StringUtils.isNotEmpty(result))
        chars.add(new Character(Character.toUpperCase(result.charAt(0))));
    }
    Collections.sort(chars);
    return chars;
  }

  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.CountyDAO#getCountyFor(long)
   */
  public Object getCountyFor(final long CountyId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from County c where c.countyId=:countyId");
        query.setLong("countyId", CountyId);
        return query.uniqueResult();
      }
    });
  }

  public Object getCountyForIsoCountyCode(final String isoCountyCode) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from County c where c.isoCountyCode=:isoCountyCode");
        query.setString("isoCountyCode", isoCountyCode);
        return query.uniqueResult();
      }
    });
  }

  
  /**
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getCountyCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getCountyCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tc.iso_county_code the_iso_county_code, "
              + " tc.iso_county_code the_iso_county_code2, c.county_name as c_county_name, tc.count as the_count from taxon_county tc"
              + " inner join county c on tc.iso_county_code=c.iso_county_code"
              + " where tc.taxon_concept_id=:taxonConceptId order by c_county_name");
        query.setParameter("taxonConceptId", taxonConceptId);
        query.addScalar("the_iso_country_code", Hibernate.STRING);
        query.addScalar("the_iso_country_code2", Hibernate.STRING);
        query.addScalar("the_count", Hibernate.INTEGER);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  @SuppressWarnings("unchecked")
  public List<County> getCountiesFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<County>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT c.countyId AS countyId, c.countyName AS countyName, c.isoCountyCode AS isoCountyCode, c.departmentId, c.occurrenceCount AS occurrenceCount, c.speciesCount AS speciesCount, c.contextCount AS contextCount FROM County c WHERE c.countyName LIKE :name ORDER BY countyName ASC");
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
