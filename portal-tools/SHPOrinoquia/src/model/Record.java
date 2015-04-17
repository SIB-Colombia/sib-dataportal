package model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Record implements Serializable {

	private String scientificName;
	private String kingdom;
	private String phylum;
	private String class_concept;
	private String order_concept;
	private String family;
	private String genus;
	private String species;
	private String specificEpithet;
	private String infraspecificEpithet;
	private String autor;
	private String institution_code;
	private String data_provider;
	private String data_resource;
	private String collection_code;
	private double latitude;
	private double longitude;
	private int id;
	private boolean pertenece;

	public Record(String scientificName, String kingdom, String phylum,
			String class_concept, String order_concept, String family,
			String genus, String species, String specificEpithet,
			String infraspecificEpithet, String autor, String institution_code,
			String data_provider, String data_resource, String collection_code,
			double latitude, double longitude, int id) {
		super();
		this.scientificName = scientificName;
		this.kingdom = kingdom;
		this.phylum = phylum;
		this.class_concept = class_concept;
		this.order_concept = order_concept;
		this.family = family;
		this.genus = genus;
		this.species = species;
		this.specificEpithet = specificEpithet;
		this.infraspecificEpithet = infraspecificEpithet;
		this.autor = autor;
		this.institution_code = institution_code;
		this.data_provider = data_provider;
		this.data_resource = data_resource;
		this.collection_code = collection_code;
		this.latitude = latitude;
		this.longitude = longitude;
		this.pertenece = true;
		this.id = id;
	}

	public String getScientificName() {
		return scientificName;
	}

	public void setScientificName(String scientificName) {
		this.scientificName = scientificName;
	}

	public String getKingdom() {
		return kingdom;
	}

	public void setKingdom(String kingdom) {
		this.kingdom = kingdom;
	}

	public String getPhylum() {
		return phylum;
	}

	public void setPhylum(String phylum) {
		this.phylum = phylum;
	}

	public String getClass_concept() {
		return class_concept;
	}

	public void setClass_concept(String class_concept) {
		this.class_concept = class_concept;
	}

	public String getOrder_concept() {
		return order_concept;
	}

	public void setOrder_concept(String order_concept) {
		this.order_concept = order_concept;
	}

	public String getFamily() {
		return family;
	}

	public void setFamily(String family) {
		this.family = family;
	}

	public String getGenus() {
		return genus;
	}

	public void setGenus(String genus) {
		this.genus = genus;
	}

	public String getSpecies() {
		return species;
	}

	public void setSpecies(String species) {
		this.species = species;
	}

	public String getSpecificEpithet() {
		return specificEpithet;
	}

	public void setSpecificEpithet(String specificEpithet) {
		this.specificEpithet = specificEpithet;
	}

	public String getInfraspecificEpithet() {
		return infraspecificEpithet;
	}

	public void setInfraspecificEpithet(String infraspecificEpithet) {
		this.infraspecificEpithet = infraspecificEpithet;
	}

	public String getAutor() {
		return autor;
	}

	public void setAutor(String autor) {
		this.autor = autor;
	}

	public String getInstitution_code() {
		return institution_code;
	}

	public void setInstitution_code(String institution_code) {
		this.institution_code = institution_code;
	}

	public String getData_provider() {
		return data_provider;
	}

	public void setData_provider(String data_provider) {
		this.data_provider = data_provider;
	}

	public String getData_resource() {
		return data_resource;
	}

	public void setData_resource(String data_resource) {
		this.data_resource = data_resource;
	}

	public String getCollection_code() {
		return collection_code;
	}

	public void setCollection_code(String collection_code) {
		this.collection_code = collection_code;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isPertenece() {
		return pertenece;
	}

	public void setPertenece(boolean pertenece) {
		this.pertenece = pertenece;
	}

	public int hashCode() {
		return id;
	}

	public boolean equals(Object o) {
		return this.hashCode() == o.hashCode();
	}

	public String toString() {
		return id + "	" + scientificName + "	" + kingdom + "	" + phylum + "	"
				+ class_concept + "	" + order_concept + "	" + family + "	"
				+ genus + "	" + species + "	" + specificEpithet + "	"
				+ infraspecificEpithet + "	" + autor + "	" + institution_code
				+ "	" + data_provider + "	" + data_resource + "	"
				+ collection_code + "	"
				+ Double.toString(latitude).replace('.', ',') + "	"
				+ Double.toString(longitude).replace('.', ',');
	}
}
