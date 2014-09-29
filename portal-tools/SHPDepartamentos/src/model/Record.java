package model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Record implements Serializable {

    private String departamento;
    private double latitude;
    private double longitude;
    private String canonical;
    private int nub_concept_id;
    private int id;
    private String note;

    public Record(String departamento, double latitude, double longitude, int nudConceptId, int id) {
            super();
            this.departamento = departamento;
            this.latitude = latitude;
            this.longitude = longitude;
            this.nub_concept_id = nudConceptId;
            this.id = id;
            this.note = null;
            this.canonical = null;
    }

    /**
     * Use the new constructor that use the locality attribute.
     * 
     * @deprecated
     */
    public Record(String departamento, double latitude, double longitude, int nudConceptId, String canonical, int id) {
            super();
            this.departamento = departamento;
            this.latitude = latitude;
            this.longitude = longitude;
            this.nub_concept_id = nudConceptId;
            this.canonical = canonical;
            this.id = id;
    }

        
    public String getDepartamento() {
		return departamento;
	}
	
	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}

	public String getNote() {
            return note;
    }
	
    public void setNote(String note) {
            this.note = note;
    }

    public int getId() {
            return id;
    }
	
    public double getLatitude() {
            return latitude;
    }

    public double getLongitude() {
            return longitude;
    }
	
    public int getNub_concept_id() {
            return nub_concept_id;
    }

    public String getCanonical() {
            return canonical;
    }
	
    public void setCanonical(String canonical) {
            this.canonical = canonical;
    }

    public void setLatitude(double latitude) {
            this.latitude = latitude;
    }
	
    public void setLongitude(double longitude) {
            this.longitude = longitude;
    }

    public void setNub_concept_id(int nubConceptId) {
            nub_concept_id = nubConceptId;
    }

    public void setId(int id) {
            this.id = id;
    }
	
    public int hashCode() {
            return id;
    }

    public boolean equals(Object o) {
            return this.hashCode() == o.hashCode();
    }

    public String toString() {
            return id + "," + nub_concept_id + "," + departamento + "," + latitude + "," + longitude;
    }
}

