package client.manage;

import java.io.File;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import client.ClientConfig;
import model.Record;
import model.ShapeFile;

public class ShapeFileManager {

        /**
         * @uml.property name="shapefile"
         * @uml.associationEnd multiplicity="(1 1)" ordering="true"
         *                     inverse="base:model.ShapeFile"
         */
        private ShapeFile shapefile;
        private Map<String, String> departamentos;

        public ShapeFile getShapefile() {
                return shapefile;
        }

        public void setShapefile(ShapeFile shapefile) {
                this.shapefile = shapefile;
        }

        /**
         * @param departments
         */
        public void setDepartamentos(Map<String, String> departamentos) {
                this.departamentos = departamentos;
        }

        public ShapeFileManager() {
        	shapefile = new ShapeFile(new File(ClientConfig.getInstance().shapeFile));
        }

        /**
         * Get the departments names according to the records coordinates
         * 
         * @param records
         *            to get the departments names according to the coordinates
         * @return names of departments for all possibles departments of all these
         *         records
         */
        public Map<String, String> getDepartamentosFromCoordinates(List<Record> records) {
        	  
                Map<String,String> result = new TreeMap<String, String>();
                Set<String> departamentos = new LinkedHashSet<String>();
                for (Record rec : records) {
                	departamentos.clear();
                	departamentos.addAll(shapefile.polygonsForAPoint(rec.getLatitude(), rec.getLongitude()));
            		for (String departamento : departamentos) {
            			rec.setDepartamento(departamento);
                    	result.put(rec.getDepartamento(), departamento);
                    }
                }
                
                return result;
        }
}

