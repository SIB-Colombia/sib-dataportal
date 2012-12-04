package net.sibcolombia.portal.dao.implementation.jdbc;

import org.gbif.portal.model.DataResource;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import net.sibcolombia.portal.dao.DataResourceDAO;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapperResultSetExtractor;
import org.springframework.jdbc.core.support.JdbcDaoSupport;


public class DataResourceDAOImplementation extends JdbcDaoSupport implements DataResourceDAO {

  /**
   * Utility to create a DataResource for a row
   * 
   * @author trobertson
   */
  protected class DataResourceRowMapper implements RowMapper {

    /**
     * The factory
     */
    public DataResource mapRow(ResultSet rs, int rowNumber) throws SQLException {
      return new DataResource(rs.getLong("id"), rs.getLong("data_provider_id"), rs.getString("description"),
        rs.getString("display_name"), rs.getString("name"), rs.getString("rights"), rs.getString("citation"),
        rs.getString("citable_agent"), rs.getString("website_url"), rs.getString("logo_url"),
        rs.getInt("basis_of_record"), rs.getInt("root_taxon_rank"), rs.getString("root_taxon_name"),
        rs.getString("scope_continent_code"), rs.getString("scope_country_code"),
        (Integer) rs.getObject("provider_record_count"), rs.getInt("taxonomic_priority"), rs.getDate("created"),
        rs.getDate("modified"), rs.getDate("deleted"), rs.getBoolean("lock_display_name"),
        rs.getBoolean("lock_citable_agent"), rs.getBoolean("lock_basis_of_record"));
    }
  }

  /**
   * The query by ID sql
   */
  protected static final String QUERY_BY_ID =
    "select id, data_provider_id, name, display_name, description, rights, citation, citable_agent, website_url, logo_url, basis_of_record, root_taxon_rank, root_taxon_name, scope_continent_code, scope_country_code, provider_record_count, taxonomic_priority, created, modified, deleted, lock_display_name, lock_citable_agent, lock_basis_of_record "
      + "from data_resource where id=?";

  /**
   * The query by ID sql
   */
  protected static final String QUERY =
    "select id, data_provider_id, name, display_name, description, rights, citation, citable_agent, website_url, logo_url, basis_of_record, root_taxon_rank, root_taxon_name, scope_continent_code, scope_country_code, provider_record_count, taxonomic_priority, created, modified, deleted, lock_display_name, lock_citable_agent, lock_basis_of_record "
      + "from data_resource";

  /**
   * Reusable row mapper
   */
  protected DataResourceRowMapper dataResourceRowMapper = new DataResourceRowMapper();

  public long create(DataResource dataResource) {
    // TODO Auto-generated method stub
    return 0;
  }

  @SuppressWarnings("unchecked")
  public List<DataResource> getAllResources() {
    List<DataResource> results =
      (List<DataResource>) getJdbcTemplate().query(DataResourceDAOImplementation.QUERY, new Object[] {},
        new RowMapperResultSetExtractor(dataResourceRowMapper, 1));
    if (results.size() == 0) {
      return null;
    } else if (results.size() > 1) {
      logger.info("Found multiple DataResources.");
    }
    return results;
  }

  /**
   * @see org.gbif.portal.dao.DataProviderDAO#getById(long)
   */
  @SuppressWarnings("unchecked")
  public DataResource getById(long id) {
    List<DataResource> results =
      (List<DataResource>) getJdbcTemplate().query(DataResourceDAOImplementation.QUERY_BY_ID, new Object[] {id},
        new RowMapperResultSetExtractor(dataResourceRowMapper, 1));
    if (results.size() == 0) {
      return null;
    } else if (results.size() > 1) {
      logger.warn("Found multiple DataResources with ID: " + id);
    }
    return results.get(0);
  }

  public DataResource getByNameAndUrlForProvider(String name, String url, long dataProviderId) {
    // TODO Auto-generated method stub
    return null;
  }

  public DataResource getByNameForProvider(String name, long dataProviderId) {
    // TODO Auto-generated method stub
    return null;
  }

  public DataResource getByRemoteIdAtUrlAndUrlForProvider(String remoteId, String url, long dataProviderId) {
    // TODO Auto-generated method stub
    return null;
  }

  public long updateOrCreate(DataResource dataResource) {
    // TODO Auto-generated method stub
    return 0;
  }

}
