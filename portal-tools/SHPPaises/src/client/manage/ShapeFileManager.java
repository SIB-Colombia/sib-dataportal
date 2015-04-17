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

	private Map<String, String> countries;

	/**
	 * @param countriesISO
	 */
	public void setCountries(Map<String, String> countries) {
		this.countries = countries;
	}

	public ShapeFileManager() {
		shapefile = new ShapeFile(
				new File(ClientConfig.getInstance().shapeFile));
	}

	/**
	 * Get the paises names according to the records coordinates
	 * 
	 * @param records
	 *            to get the countries names according to the coordinates
	 * @return names of countries for all possibles countries of all these
	 *         records
	 */
	public Map<String, String> getCountriesFromCoordinates(List<Record> records) {

		Map<String, String> result = new TreeMap<String, String>();
		Set<String> countries = new LinkedHashSet<String>();
		for (Record rec : records) {
			countries.clear();
			countries.addAll(shapefile.polygonsForAPoint(rec.getLatitude(),
					rec.getLongitude()));
			for (String country : countries) {
				rec.setIsoCountryCodeCalculated(country);
				result.put(rec.getIsoCountryCodeCalculated(), country);
			}
		}

		return result;
	}
}
