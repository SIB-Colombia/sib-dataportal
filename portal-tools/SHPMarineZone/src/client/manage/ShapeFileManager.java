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

	private Map<String, String> marineZones;

	/**
	 * @param manireZones
	 */
	public void setMarineZones(Map<String, String> marineZones) {
		this.marineZones = marineZones;
	}

	public ShapeFileManager() {
		shapefile = new ShapeFile(
				new File(ClientConfig.getInstance().shapeFile));
	}

	/**
	 * Get the marine zone names according to the records coordinates
	 * 
	 * @param records
	 *            to get the marine zone names according to the coordinates
	 * @return names of marine zone for all possibles marine zone of all these
	 *         records
	 */
	public Map<String, String> getMarineZoneFromCoordinates(List<Record> records) {

		Map<String, String> result = new TreeMap<String, String>();
		Set<String> marineZones = new LinkedHashSet<String>();
		for (Record rec : records) {
			marineZones.clear();
			marineZones.addAll(shapefile.polygonsForAPoint(rec.getLatitude(),
					rec.getLongitude()));
			for (String marineZone : marineZones) {
				rec.setMarineZone(marineZone);
				result.put(rec.getMarineZone(), marineZone);
			}
		}

		return result;
	}
}
