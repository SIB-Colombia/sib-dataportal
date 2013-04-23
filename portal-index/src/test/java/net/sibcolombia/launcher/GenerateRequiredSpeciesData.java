package net.sibcolombia.launcher;

import org.gbif.portal.harvest.taxonomy.TaxonomyUtils;
import org.gbif.portal.model.DataResource;

import java.util.List;

import net.sibcolombia.portal.dao.DataResourceDAO;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class GenerateRequiredSpeciesData {

  /**
   * The commons logger
   */
  protected Log logger = LogFactory.getLog(this.getClass());

  /**
   * The utils
   */
  protected TaxonomyUtils taxonomyUtils;

  /**
   * The DataResourceDAO
   */
  protected DataResourceDAO dataResourceDAO;

  /**
   * The spring context
   */
  protected ApplicationContext context;

  /**
   * Hidden constructor forcing the setting of the required values
   */
  protected GenerateRequiredSpeciesData() {
    String[] locations =
      {"classpath*:/**/applicationContext-*.xml", "classpath*:**/applicationContext-*.xml",
        "classpath*:org/gbif/portal/**/applicationContext-*.xml"};
    context = new ClassPathXmlApplicationContext(locations);
    taxonomyUtils = (TaxonomyUtils) context.getBean("taxonomyUtils");
    dataResourceDAO = (DataResourceDAO) context.getBean("dataResourceDAOSib");
  }

  /**
   * @param args
   */
  public static void main(String[] args) {
    System.out.println("Iniciando generador de datos requeridos para consultar taxonomia de especies.");
    GenerateRequiredSpeciesData launcher = new GenerateRequiredSpeciesData();
    try {
      launcher.launch();
    } catch (Exception e) {
      System.out.println("Error ejecutando el generador.");
      e.printStackTrace();
    }
    System.out.println("Finalizado generador de datos requeridos para consultar taxonomia de especies.");
  }

  private void launch() throws Exception {
    List<DataResource> dataResources = dataResourceDAO.getAllResources();

    for (DataResource dataResource : dataResources) {
      System.out.println("Llenando campo partner_concept_id en tabla taxon_concept, para recurso con id: "
        + dataResource.getId());
      long time = System.currentTimeMillis();
      logger.info("Starting importing resource[" + dataResource.getId() + "]");
      DataResource resource = dataResourceDAO.getById(dataResource.getId());
      if (resource == null) {
        throw new Exception("No resource for id:" + dataResource.getId());
      }

      // Only allow our highest taxonomic authorities to create kingdoms
      boolean canCreateKingdoms = (resource.getTaxonomicPriority() <= 10);
      taxonomyUtils.importTaxonomyFromDataResource(dataResource.getId(), 1, 1, canCreateKingdoms, false, false);
      logger.info("Finished importing resource[" + dataResource.getId() + "] in "
        + ((1 + System.currentTimeMillis() - time) / 1000) + " secs");
    }
    for (DataResource dataResource : dataResources) {
      System.out
        .println("Llenando ID de taxones, kingdom, campo partner_concep, phylum, ..., species para el recurso con id: "
          + dataResource.getId());
      logger.info("Starting taxonomy denormalisation of resource " + dataResource.getId());
      taxonomyUtils.denormalisedTaxonomyForResource(dataResource.getId());
      logger.info("Finished taxonomy denormalisation of resource " + dataResource.getId());
    }
  }
}
