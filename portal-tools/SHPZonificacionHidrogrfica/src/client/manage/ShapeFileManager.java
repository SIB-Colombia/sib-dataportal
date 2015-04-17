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

	private Map<String, String> zonificaciones;

	/**
	 * @param zonificaciones
	 */
	public void setZonificaciones(Map<String, String> zonificaciones) {
		this.zonificaciones = zonificaciones;
	}

	public ShapeFileManager() {
		shapefile = new ShapeFile(
				new File(ClientConfig.getInstance().shapeFile));
	}

	/**
	 * Get the zonificaciones names according to the records coordinates
	 * 
	 * @param records
	 *            to get the zonificaciones names according to the coordinates
	 * @return names of zonificaciones for all possibles zonificaciones of all
	 *         these records
	 */
	public Map<String, String> getZonificacionesFromCoordinates(
			List<Record> records) {

		Map<String, String> result = new TreeMap<String, String>();
		Set<String> zonificaciones = new LinkedHashSet<String>();
		for (Record rec : records) {
			zonificaciones.clear();
			zonificaciones.addAll(shapefile.polygonsForAPoint(
					rec.getLatitude(), rec.getLongitude()));
			for (String zonificacion : zonificaciones) {
				rec.setZonificacion(zonificacion);
				result.put(rec.getZonificacion(), zonificacion);
			}
		}

		return result;
	}
}
