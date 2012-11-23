package net.sibcolombia.portal.dao.geospatial.implementation.hibernate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.sibcolombia.portal.dao.geospatial.DepartmentDAO;
import net.sibcolombia.portal.model.geospatial.Department;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


public class DepartmentDAOImplementation extends HibernateDaoSupport implements DepartmentDAO {

  /** The list of currently support locales - dynamically loaded on application start up */
  protected List<String> supportedLocales = null;

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
        logger.info("Query debug: " + query.getQueryString());
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
