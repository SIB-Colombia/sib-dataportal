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

	private Map<String, String> dry_forests;

	/**
	 * @param dry_forests
	 */
	public void setDryForests(Map<String, String> dry_forests) {
		this.dry_forests = dry_forests;
	}

	public ShapeFileManager() {
		shapefile = new ShapeFile(
				new File(ClientConfig.getInstance().shapeFile));
	}

	/**
	 * Get the dry_forests names according to the records coordinates
	 * 
	 * @param records
	 *            to get the dry_forests names according to the coordinates
	 * @return names of dry_forests for all possibles dry_forests of all these
	 *         records
	 */
	public Map<String, String> getDryForestsFromCoordinates(List<Record> records) {

		Map<String, String> result = new TreeMap<String, String>();
		Set<String> dry_forests = new LinkedHashSet<String>();
		for (Record rec : records) {
			dry_forests.clear();
			dry_forests.addAll(shapefile.polygonsForAPoint(rec.getLatitude(),
					rec.getLongitude()));
			for (String dry_forest : dry_forests) {
				rec.setDryForest(dry_forest);
				result.put(rec.getDryForest(), dry_forest);
			}
		}

		return result;
	}
}
