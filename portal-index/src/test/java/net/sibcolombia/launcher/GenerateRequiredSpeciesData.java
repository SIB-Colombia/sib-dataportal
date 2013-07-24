package net.sibcolombia.launcher;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.gbif.portal.harvest.taxonomy.TaxonomyUtils;
import org.gbif.portal.model.DataResource;

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
    	List<DataResource> dataResources = launcher.dataResourceDAO.getAllResources();
    	ExecutorService es = Executors.newCachedThreadPool();
		for(int i=0;i<dataResources.size();i++){
			long id =(dataResources.get(i).getId());
		    es.execute(new ImportTaxonomyThread(launcher.taxonomyUtils, launcher.dataResourceDAO, id));
		}
		es.shutdown();
		while(!es.isTerminated()) {
		   try {
	            Thread.sleep(100);
            } catch (InterruptedException e) {
	                e.printStackTrace();
	            }
       }
    } catch (Exception e) {
      System.out.println("Error ejecutando el generador.");
      e.printStackTrace();
    }finally{
    	System.out.println("Los datos requeridos para consultar taxonomia de especies ya estan disponibles.");
    	System.exit(0);
    }
  }
}