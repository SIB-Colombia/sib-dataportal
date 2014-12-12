/***************************************************************************
 * Copyright (C) 2005 Global Biodiversity Information Facility Secretariat.
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/

package org.gbif.portal.dao.resources.impl.hibernate;

import org.gbif.portal.dao.resources.DataProviderDAO;
import org.gbif.portal.model.resources.DataProvider;
import org.gbif.portal.model.resources.DataResource;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A hibernate based DAO implementation for DataProviderDAO.
 * 
 * @author Dave Martin
 */
public class DataProviderDAOImpl extends HibernateDaoSupport implements DataProviderDAO {
	

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#findDataProviders(java.lang.String, boolean, int, int)
   */
  @SuppressWarnings("unchecked")
  public Long countDataProviders(final String nameStub, final boolean fuzzy, final String isoCountryCode,
    final Date modifiedSince) {
    HibernateTemplate template = getHibernateTemplate();
    return ((Integer) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Criteria criteria = session.createCriteria(DataProvider.class, "dp");
        if (nameStub != null) {
          if (fuzzy) {
            criteria = criteria.add(Restrictions.like("dp.name", nameStub, MatchMode.START));
          } else {
            criteria = criteria.add(Restrictions.eq("dp.name", nameStub));
          }
        }
        if (isoCountryCode != null) {
          criteria = criteria.add(Restrictions.eq("dp.isoCountryCode", isoCountryCode));
        }
        if (modifiedSince != null) {
          criteria = criteria.add(Restrictions.ge("dp.modified", modifiedSince));
        }
        criteria.setProjection(Projections.rowCount());
        return criteria.uniqueResult();
      }
    })).longValue();
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#findDataProviders(java.lang.String, boolean, int, int)
   */
  @SuppressWarnings("unchecked")
  public List<DataProvider> findDataProviders(final String nameStub, final boolean fuzzy, final String isoCountryCode,
    final Date modifiedSince, final int startIndex, final int maxResults) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<DataProvider>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Criteria criteria = session.createCriteria(DataProvider.class, "dp");
        if (nameStub != null) {
          if (fuzzy) {
            criteria = criteria.add(Restrictions.like("dp.name", nameStub, MatchMode.START));
          } else {
            criteria = criteria.add(Restrictions.eq("dp.name", nameStub));
          }
        }
        if (isoCountryCode != null) {
          criteria = criteria.add(Restrictions.eq("dp.isoCountryCode", isoCountryCode));
        }
        if (modifiedSince != null) {
          criteria = criteria.add(Restrictions.ge("dp.modified", modifiedSince));
        }
        criteria.setCacheable(true);
        return criteria.list();
      }
    });
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getAllDataProviders()
   */
  public List<DataProvider> getAllDataProviders() {
    HibernateTemplate template = getHibernateTemplate();
    List results = (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from DataProvider where id != 1 order by name");
        return query.list();
      }
    });
    return results;
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getDataProviderFor(long)
   */
  @SuppressWarnings("unchecked")
  public List<DataProvider> getDataProviderAssociatedWithUser(final String emailUsername, final String emailDomain) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<DataProvider>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session.createQuery("select distinct dp from DataProvider dp " + "inner join dp.dataProviderAgents agents "
            + "inner join  agents.agent ag " + "where ag.email like :emailUsername and ag.email like :emailDomain");
        query.setParameter("emailUsername", emailUsername);
        query.setParameter("emailDomain", emailDomain);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  /**
   * @see org.gbif.portal.dao.resources.DataResourceDAO#getDataResourceCountsForCountry(java.lang.Long)
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getDataProviderCountsForCountry(final String isoCountryCode) {
    HibernateTemplate template = getHibernateTemplate();
    return (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session.createSQLQuery("select distinct dp.id, dp.name as dp_name, sum(rc.count) from data_provider dp"
            + " inner join data_resource dr on dr.data_provider_id=dp.id"
            + " inner join resource_country rc on rc.data_resource_id=dr.id"
            + " where rc.iso_country_code=? group by dp.id order by dp_name");
        query.setParameter(0, isoCountryCode);
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getDataProviderCountsForHostCountry(java.lang.String, boolean)
   */
  public int getDataProviderCountsForHostCountry(final String isoCountryCode, final boolean georeferenced) {
    HibernateTemplate template = getHibernateTemplate();
    Integer result = (Integer) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        StringBuffer sb = new StringBuffer("select sum(dp.");
        if (georeferenced) {
          sb.append("occurrenceCount");
        } else {
          sb.append("occurrenceCoordinateCount");
        }
        sb.append(") from DataProvider dp where dp.isoCountryCode=:isoCountryCode");
        Query query = session.createQuery(sb.toString());
        query.setParameter("isoCountryCode", isoCountryCode);
        return query.uniqueResult();
      }
    });
    return result;
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getDataProviderFor(long)
   */
  public DataProvider getDataProviderFor(final long dataProviderId) {
    HibernateTemplate template = getHibernateTemplate();
    return (DataProvider) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("from DataProvider dp where dp.id = ?");
        query.setParameter(0, dataProviderId);
        query.setCacheable(true);
        return query.uniqueResult();
      }
    });
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getDataProviderList()
   */
  public List getDataProviderList() {
    HibernateTemplate template = getHibernateTemplate();
    List results = (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createQuery("select id, name from DataProvider where deleted is null order by name");
        return query.list();
      }
    });
    return results;
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getDataProvidersOfferingTaxonomies()
   */
  @SuppressWarnings("unchecked")
  public List<DataProvider> getDataProvidersOfferingTaxonomies() {
    HibernateTemplate template = getHibernateTemplate();
    return (List<DataProvider>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session.createQuery("select dr.dataProvider from DataResource dr" + " inner join dr.dataProvider as dp"
            + " where dr.sharedTaxonomy=true" + " group by dp.id order by dp.name");
        query.setCacheable(true);
        return query.list();
      }
    });
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getInternationalDataProviders(boolean)
   */
  @SuppressWarnings("unchecked")
  public List<DataProvider> getInternationalDataProviders(final boolean withOccurrencesOnly) {
    HibernateTemplate template = getHibernateTemplate();
    return (List<DataProvider>) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        StringBuffer sb = new StringBuffer("from DataProvider dp where dp.isoCountryCode is null");
        if (withOccurrencesOnly) {
          sb.append(" and dp.occurrenceCount > 0");
        }
        sb.append(" order by dp.name");
        Query query = session.createQuery(sb.toString());
        return query.list();
      }
    });
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getRolloverDates()
   */
  @SuppressWarnings("unchecked")
  public List<Date> getRolloverDates() {
    HibernateTemplate template = getHibernateTemplate();
    List<Date> results = (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        SQLQuery query = session.createSQLQuery("select rollover_date from rollover order by rollover_date desc");
        query.addScalar("rollover_date", Hibernate.DATE);
        return query.list();
      }
    });
    return results;
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getSystemDetails()
   */
  @SuppressWarnings("unchecked")
  public List<Object[]> getSystemDetails() {
    HibernateTemplate template = getHibernateTemplate();
    List results = (List) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query = session.createSQLQuery("Select * from view_indexing");
        return query.list();
      }
    });
    return results;
  }

  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getTotalDataProviderCount()
   */
  public int getTotalDataProviderCount() {
    HibernateTemplate template = getHibernateTemplate();
    Object result = template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("select count(dp.id) from DataProvider dp where dp.deleted is null and dp.gbifApprover is not null");
        return query.uniqueResult();
      }
    });
    if (result instanceof Integer)
      return ((Integer) result).intValue();
    if (result instanceof Long)
      return ((Long) result).intValue();
    return 0;
  }
  
  
  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getTotalOcurrenceCount()
   */
  @SuppressWarnings("unchecked")
  public int getTotalOcurrenceCount(){
	  HibernateTemplate template = getHibernateTemplate();
	    Object result = template.execute(new HibernateCallback() {
	        public Object doInHibernate(Session session) {
	          Query query =
	            session
	              .createQuery("select sum(dp.occurrenceCount) from DataProvider dp");
	          return query.uniqueResult();
	        }
	      });
	    if (result instanceof Integer)
	        return ((Integer) result).intValue();
	      if (result instanceof Long)
	        return ((Long) result).intValue();
	      return 0;
  }
  
  
  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getTotalOcurrenceCoordinateCount()
   */
  @SuppressWarnings("unchecked")
  public int getTotalOcurrenceCoordinateCount(){
	  HibernateTemplate template = getHibernateTemplate();
	    Object result = template.execute(new HibernateCallback() {
	        public Object doInHibernate(Session session) {
	          Query query =
	            session
	              .createQuery("select sum(dp.occurrenceCoordinateCount) from DataProvider dp");
	          return query.uniqueResult();
	        }
	      });
	    if (result instanceof Integer)
	        return ((Integer) result).intValue();
	      if (result instanceof Long)
	        return ((Long) result).intValue();
	      return 0;
  }
  
  @SuppressWarnings("unchecked")
  public List<String> getOcurrencesPerMonth(){
	  List<Object[]> dataOcurrences = (List<Object[]>)getHibernateTemplate().execute (new HibernateCallback() {
              public Object doInHibernate(Session session) {
            	  //Query query1= session.createSQLQuery("select concat(year(ror.created),'/',month(ror.created)), dt.name, count(distinct ror.id) from raw_occurrence_record ror, data_provider dt where ror.data_provider_id = dt.id and ror.created >= now()-interval 3 month group by month(ror.created),ror.data_provider_id order by ror.created asc;");
            	  
                  Query query = session.createQuery("select concat(year(ror.created),'/',month(ror.created)), dt.name, count(distinct ror.id) from RawOccurrenceRecord ror, DataProvider dt" +
                          " where ror.dataProviderId = dt.id" +
                          " group by month(ror.created),ror.dataProviderId order by ror.created asc");
                         
                  return query.list();
              }
          });

      ArrayList<String> dataO = new ArrayList<String>();  
      
      
      for (Object[] result: dataOcurrences) {
    	  dataO.add(result[0].toString() + "|" + result[1].toString() + "|" + result[2].toString());
    	}

      return dataO;
  }
  
  
  public int getTotalDataResourceCountPerProvider(final String dataProviderKey){
	  HibernateTemplate template = getHibernateTemplate();
	    Object result = template.execute(new HibernateCallback() {
	        public Object doInHibernate(Session session) {
	          Query query = session.createQuery("select count(dr.id) from DataResource dr where dr.dataProviderId=:dataProviderKey");
	          query.setParameter("dataProviderKey", Long.parseLong(dataProviderKey));
	          return query.uniqueResult();
	        }
	      });
	    if (result instanceof Integer)
	        return ((Integer) result).intValue();
	      if (result instanceof Long)
	        return ((Long) result).intValue();
	      return 0;
  }
  
  /**
   * @see org.gbif.portal.dao.resources.DataProviderDAO#getLastDataProviderAdded()
   */
  public DataProvider getLastDataProviderAdded() {
    HibernateTemplate template = getHibernateTemplate();
    return (DataProvider) template.execute(new HibernateCallback() {

      public Object doInHibernate(Session session) {
        Query query =
          session
            .createQuery("from DataProvider dp where dp.deleted is null order by dp.created desc");
        query.setMaxResults(1);
        query.setCacheable(true);
        return query.uniqueResult();
      }
    });
  }
  @SuppressWarnings("unchecked")
  public List<String> getProviderTypeCounts(){
	  HibernateTemplate template = getHibernateTemplate();
	  List<Object[]> providerTypeCounts = (List<Object[]>)getHibernateTemplate().execute (new HibernateCallback() {
              public Object doInHibernate(Session session) {
            	  SQLQuery query = session.createSQLQuery("SELECT provider_type, count FROM stats_provider_type_species_counts");
                  query.setCacheable(true);
                  query.addScalar("provider_type", Hibernate.STRING);
                  query.addScalar("count", Hibernate.INTEGER);
                  return query.list();
              }
          });

      ArrayList<String> providerC = new ArrayList<String>();  
      
      for (Object[] result: providerTypeCounts) {
    	  providerC.add(result[0].toString() + "|" + result[1].toString());
    	}

      return providerC;
  }
  
  @SuppressWarnings("unchecked")
  public List<String> getOcurrencePerMonthAccumulativeCounts(){
	  HibernateTemplate template = getHibernateTemplate();
	  List<Object[]> monthAccumulativeCounts = (List<Object[]>)getHibernateTemplate().execute (new HibernateCallback() {
              public Object doInHibernate(Session session) {
            	  SQLQuery query = session.createSQLQuery("SELECT year, month, accumulative FROM stats_month_counts where count > 0");
                  query.setCacheable(true);
                  query.addScalar("year", Hibernate.INTEGER);
                  query.addScalar("month", Hibernate.INTEGER);
                  query.addScalar("accumulative", Hibernate.INTEGER);
                  return query.list();
              }
          });

      ArrayList<String> monthC = new ArrayList<String>();  
      
      for (Object[] result: monthAccumulativeCounts) {
    	  monthC.add(result[0].toString() + "-" + result[1].toString() + "|" + result[2].toString());
    	}

      return monthC;
  }
  
  @SuppressWarnings("unchecked")
  public List<String> getOcurrencePerMonthTriCounts(){
	  HibernateTemplate template = getHibernateTemplate();
	  List<Object[]> monthTriCounts = (List<Object[]>)getHibernateTemplate().execute (new HibernateCallback() {
              public Object doInHibernate(Session session) {
            	  SQLQuery query = session.createSQLQuery("SELECT tri, count FROM stats_tri_month_counts where count > 0");
                  query.setCacheable(true);
                  query.addScalar("tri", Hibernate.STRING);
                  query.addScalar("count", Hibernate.INTEGER);
                  return query.list();
              }
          });

      ArrayList<String> monthTC = new ArrayList<String>();  
      
      for (Object[] result: monthTriCounts) {
    	  monthTC.add(result[0].toString() + "|" + result[1].toString());
    	}

      return monthTC;
  }
}

