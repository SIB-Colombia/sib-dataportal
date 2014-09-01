package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import net.sibcolombia.portal.dao.geospatial.DepartmentDAO;
import net.sibcolombia.portal.model.geospatial.Department;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class DepartmentDAOImplementation extends HibernateDaoSupport implements DepartmentDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

  @SuppressWarnings("unchecked")
  public List<Object[]> findDepartmentsFor(final String nameStub, final boolean fuzzy, final boolean anyOccurrence,
    final int startIndex, final int maxResults) {
    return (List<Object[]>) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {

        StringBuffer sb = null;

        sb = new StringBuffer("select d from Department d where (d.departmentName like :name");
        if (anyOccurrence) {
          sb.append(" or d.departmentName like :anyPartName");
        }
        sb.append(")");
        sb.append(" order by d.departmentName");

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
  public List<Character> getDepartmentAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> departmentChars = (List<String>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(department.department_name,1,1)) FROM department ORDER BY department.department_name ASC");
        return query.list();
      }
    });
    ArrayList<Character> chars = new ArrayList<Character>();
    for (String result : departmentChars) {
      if (StringUtils.isNotEmpty(result))
        chars.add(new Character(Character.toUpperCase(result.charAt(0))));
    }
    Collections.sort(chars);
    return chars;
  }

  @SuppressWarnings("unchecked")
  public List<Object[]> getDepartmentCountsForDepartment(final String isoDepartmentCode, final boolean geoRefOnly,
    final Locale locale) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Object[]>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        StringBuffer sb = new StringBuffer("select dp.iso_country_code as the_iso_country_code, cn.name as cn_name,");
        if (geoRefOnly) {
          sb.append("  sum(rc.occurrence_coordinate_count) as the_count from resource_country rc"
            + " inner join data_resource dr on rc.data_resource_id=dr.id "
            + " inner join data_provider dp on dr.data_provider_id=dp.id "
            + " inner join country_name cn on dp.iso_country_code=cn.iso_country_code" + " where ");
        } else {
          sb.append("  sum(rc.count) as the_count from resource_country rc"
            + " inner join data_resource dr on rc.data_resource_id=dr.id "
            + " inner join data_provider dp on dr.data_provider_id=dp.id "
            + " inner join country_name cn on dp.iso_country_code=cn.iso_country_code" + " where ");
        }
        if (isoDepartmentCode != null) {
          sb.append(" rc.iso_country_code=:isoCountryCode");
        }

        if (geoRefOnly) {
          sb.append(" and rc.occurrence_coordinate_count>0");
        }

        sb.append(" and dr.deleted is null");

        sb.append(" group by cn_name");
        SQLQuery query = session.createSQLQuery(sb.toString());
        if (isoDepartmentCode != null) {
          query.setParameter("isoCountryCode", isoDepartmentCode);
          query.addScalar("the_iso_country_code", Hibernate.STRING);
          query.addScalar("cn_name", Hibernate.STRING);
          query.addScalar("the_count", Hibernate.INTEGER);
        }
        query.setCacheable(true);
        logger.debug("query is: " + sb.toString());
        return query.list();
      }
    });
  }

  /**
   * @see net.sibcolombia.portal.dao.taxonomy.TaxonConceptDAO#getDepartmentCountsForTaxonConcept(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getDepartmentCountsForTaxonConcept(final long taxonConceptId) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select tc.iso_department_code the_iso_department_code, "
              + " tc.iso_department_code the_iso_department_code2, dn.department_name as dn_department_name, tc.count as the_count from taxon_department tc"
              + " inner join department dn on tc.iso_department_code=dn.iso_department_code"
              + " where tc.taxon_concept_id=:taxonConceptId order by dn_department_name");
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
  public List<Department> getDepartmentsCountsForTaxonConcept() {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Department>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query =
          session
            .createSQLQuery("select dn.id as id, dn.department_name as department_name, dn.iso_department_code as iso_department_code, count(tc.taxon_concept_id) as count, 0 as count_1, 0 as count_2, dn.lat as lat, dn.lng as lng "
              + " from taxon_department tc left join department dn on tc.iso_department_code = dn.iso_department_code"
              + " group by dn.iso_department_code");
        query.setCacheable(true);
        query.addScalar("id", Hibernate.LONG);
        query.addScalar("department_name", Hibernate.STRING);
        query.addScalar("iso_department_code", Hibernate.STRING);
        query.addScalar("count", Hibernate.INTEGER);
        query.addScalar("count_1", Hibernate.INTEGER);
        query.addScalar("count_2", Hibernate.INTEGER);
        query.addScalar("lat", Hibernate.STRING);
        query.addScalar("lng", Hibernate.STRING);
        return query.list();
      }
    });
  }

  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getDepartmentFor(long)
   */
  public Object getDepartmentFor(final long departmentId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from Department d where d.departmentId=:departmentId");
        query.setLong("departmentId", departmentId);
        return query.uniqueResult();
      }
    });
  }

  public Object getDepartmentForIsoDepartmentCode(final String isoDepartmentCode) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from Department d where d.isoDepartmentCode=:isoDepartmentCode");
        query.setString("isoDepartmentCode", isoDepartmentCode);
        return query.uniqueResult();
      }
    });
  }

  @SuppressWarnings("unchecked")
  public List<Department> getDepartmentsFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Department>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("SELECT d.departmentId AS departmentId, d.departmentName AS departmentName, d.isoDepartmentCode AS isoDepartmentCode, d.occurrenceCount AS occurrenceCount, d.occurrenceCoordinateCount AS occurrenceCoordinateCount, d.speciesCount AS speciesCount, d.departmentLat AS departmentLat, d.departmentLng AS departmentLng FROM Department d WHERE d.departmentName LIKE :name ORDER BY departmentName ASC");
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
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalDepartmentCount()
   */
  public int getTotalDepartmentCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(c.id) from Department c");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }

  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalCountyCount()
   */
  public int getTotalCountyCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(c.id) from County c");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }
  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalParamoCount()
   */
  public int getTotalParamoCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(p.id) from Paramo p");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }
  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalMarineZoneCount()
   */
  public int getTotalMarineZoneCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(m.id) from MarineZone m");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }
  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalProtectedAreaCount()
   */
  public int getTotalProtectedAreaCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(pa.id) from ProtectedArea pa");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }
  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalEcosystemCount()
   */
  public int getTotalEcosystemCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(e.id) from Ecosystem e");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }
  
  /**
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getTotalZonificacionCount()
   */
  public int getTotalZonificacionCount() {
    Long count = (Long) getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select count(z.id) from Zonificacion z");
        return query.uniqueResult();
      }
    });
    return count.intValue();
  }
  
  /**
   * @param supportedLocales the supportedLocales to set
   */
  public void setSupportedLocales(List<String> supportedLocales) {
    this.supportedLocales = supportedLocales;
  }
 
}
