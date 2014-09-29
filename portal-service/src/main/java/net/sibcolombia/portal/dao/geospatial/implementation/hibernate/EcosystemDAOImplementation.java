package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.sibcolombia.portal.dao.geospatial.EcosystemDAO;
import net.sibcolombia.portal.model.geospatial.Ecosystem;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class EcosystemDAOImplementation extends HibernateDaoSupport implements EcosystemDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findEcosystemFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select e from Ecosystem e where (e.type like :name");
        if (anyOccurrence) {
          sb.append(" or e.type like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by e.type");

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
  
  public List<Character> getEcosystemAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> ecosystemChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(Ecosystem.type,1,1)) FROM Ecosystem ORDER BY Ecosystem.type ASC");
        return query.list();
      }
    });
    ArrayList<Character> chars = new ArrayList<Character>();
    for (String result : ecosystemChars) {
      if (StringUtils.isNotEmpty(result))
        chars.add(new Character(Character.toUpperCase(result.charAt(0))));
    }
    Collections.sort(chars);
    return chars;
  }

  /**
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getEcosystemCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getEcosystemCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tp.ecosystem_id the_ecosystem_id, "
              + " tp.ecosystem_id the_ecosystem_id2, e.id as e_id, tp.count as the_count from taxon_ecosystem tp"
              + " inner join ecosystem e on tp.ecosystem_id = e.id"
              + " where tp.taxon_concept_id=:taxonConceptId order by e_id");
        query.setParameter("taxonConceptId", taxonConceptId);
        query.addScalar("the_ecosystem_id", Hibernate.STRING);
        query.addScalar("the_ecosystem_id2", Hibernate.STRING);
        query.addScalar("the_count", Hibernate.INTEGER);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.ProtectedAreaDAO#getProtectedAreaFor(long)
   */
  public Object getEcosystemFor(final long ecosystemId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from Ecosystem e where e.ecosystemId=:ecosystemId");
        query.setLong("ecosystemId", ecosystemId);
        return query.uniqueResult();
      }
    });
  }
  @SuppressWarnings("unchecked")
  public List<Ecosystem> getEcosystemsFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Ecosystem>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT e.ecosystemId AS ecosystemId, e.type AS type, e.occurrenceCount AS occurrenceCount, e.speciesCount AS speciesCount, e.contextCount AS contextCount FROM Ecosystem e WHERE e.type LIKE :type ORDER BY type ASC");
        String searchString;
        if (theChar != null) {
          searchString = theChar + "%";
        } else {
          searchString = "%";
        }
        query.setString("type", searchString);
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