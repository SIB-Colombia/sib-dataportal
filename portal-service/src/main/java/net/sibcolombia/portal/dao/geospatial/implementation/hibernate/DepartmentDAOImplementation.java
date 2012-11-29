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
   * @see net.sibcolombia.portal.dao.geospatial.DepartmentDAO#getDepartmentFor(long)
   */
  public Object getDepartmentFor(final long departmentId) {
    return getHibernateTemplate().execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from Department d where d.id=:departmentId");
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
            .createQuery("SELECT d.id AS id, d.departmentName AS departmentName, d.isoDepartmentCode AS isoDepartmentCode, d.occurrenceCount AS occurrenceCount, d.occurrenceCoordinateCount AS occurrenceCoordinateCount, d.speciesCount AS speciesCount FROM Department d WHERE d.departmentName LIKE :name ORDER BY departmentName ASC");
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
