package net.sibcolombia.portal.dao.department.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.sibcolombia.portal.dao.department.DepartmentDAO;
import net.sibcolombia.portal.model.Department;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * The DAO for the Department Model object.
 * 
 * @author Valentina Grajales {@link "mailto:valegrajales@gmail.com"}
 */
public class DepartmentDAOImplementation extends HibernateDaoSupport implements DepartmentDAO {

  @SuppressWarnings("unchecked")
  @Override
  public List<Character> getDepartmentAlphabet() {
    HibernateTemplate template = getHibernateTemplate();
    List<String> departmentChars = (List<String>) template.execute(new HibernateCallback() {

      @Override
      public Object doInHibernate(Session session) {
        Query query =
          session
            .createSQLQuery("SELECT DISTINCT(SUBSTRING(state_province,1,1)) FROM raw_occurrence_record WHERE raw_occurrence_record.state_province IS NOT NULL AND raw_occurrence_record.deleted IS NULL ORDER BY raw_occurrence_record.state_province ASC");
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

  /*
   * (non-Javadoc)
   * @see net.sibcolombia.portal.dao.department.DepartmentDAO#getDepartmentsFor(char, boolean)
   */
  @Override
  @SuppressWarnings("unchecked")
  public List<Department> getDepartmentsFor(final Character theChar) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<Department>) template.execute(new HibernateCallback() {

      @Override
      public Object doInHibernate(Session session) {
        Query query =
          session.createQuery("SELECT raw_occurrence_record.state_province AS department, "
            + "Count(raw_occurrence_record.state_province) AS ocurrenceCount, "
            + "Count(raw_occurrence_record.latitude) AS ocurrenceCoordinateCount, "
            + "occurrence_record.iso_departments_code AS department_code " + "FROM raw_occurrence_record "
            + "INNER JOIN occurrence_record ON occurrence_record.id = raw_occurrence_record.id "
            + "WHERE occurrence_record.iso_country_code = 'CO' "
            + "AND raw_occurrence_record.state_province IS NOT NULL "
            + "AND raw_occurrence_record.state_province LIKE :name GROUP BY raw_occurrence_record.state_province "
            + "ORDER BY department ASC");
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

}
