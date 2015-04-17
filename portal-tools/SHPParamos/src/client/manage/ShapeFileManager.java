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

	public ShapeFile getShapefile() {
		return shapefile;
	}

	public void setShapefile(ShapeFile shapefile) {
		this.shapefile = shapefile;
	}

	private Map<String, String> paramos;

	/**
	 * @param countriesISO
	 */
	public void setParamos(Map<String, String> paramos) {
		this.paramos = paramos;
	}

	public ShapeFileManager() {
		shapefile = new ShapeFile(
				new File(ClientConfig.getInstance().shapeFile));
	}

	/**
	 * Get the paramos names according to the records coordinates
	 * 
	 * @param records
	 *            to get the paramos names according to the coordinates
	 * @return names of paramos for all possibles paramos of all these records
	 */
	public Map<String, String> getParamosFromCoordinates(List<Record> records) {

		Map<String, String> result = new TreeMap<String, String>();
		Set<String> paramos = new LinkedHashSet<String>();
		for (Record rec : records) {
			paramos.clear();
			paramos.addAll(shapefile.polygonsForAPoint(rec.getLatitude(),
					rec.getLongitude()));
			for (String paramo : paramos) {
				rec.setParamo(paramo);
				result.put(rec.getParamo(), paramo);
			}
		}

		return result;
	}
}
