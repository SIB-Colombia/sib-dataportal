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

	private Map<String, String> protected_areas;

	/**
	 * @param protected_areas
	 */
	public void setProtectedAreas(Map<String, String> protected_areas) {
		this.protected_areas = protected_areas;
	}

	public ShapeFileManager() {
		shapefile = new ShapeFile(
				new File(ClientConfig.getInstance().shapeFile));
	}

	/**
	 * Get the protected_areas names according to the records coordinates
	 * 
	 * @param records
	 *            to get the protected_areas names according to the coordinates
	 * @return names of protected_areas for all possibles protected_areas of all
	 *         these records
	 */
	public Map<String, String> getProtectedAreasFromCoordinates(
			List<Record> records) {

		Map<String, String> result = new TreeMap<String, String>();
		Set<String> protected_areas = new LinkedHashSet<String>();
		for (Record rec : records) {
			protected_areas.clear();
			protected_areas.addAll(shapefile.polygonsForAPoint(
					rec.getLatitude(), rec.getLongitude()));
			for (String protected_area : protected_areas) {
				rec.setProtectedArea(protected_area);
				result.put(rec.getProtectedArea(), protected_area);
			}
		}

		return result;
	}
}
