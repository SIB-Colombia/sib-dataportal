/***************************************************************************
 * Copyright (C) 2006 Global Biodiversity Information Facility Secretariat.
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package org.gbif.portal.model.occurrence;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.gbif.portal.model.IntegerEnumType;

/**
 * Enumerated type for the basis of record for an occurrence record
 *
 * @author dhobern
 */
public class BasisOfRecord extends IntegerEnumType implements Serializable{
	/**
	 * Generated
	 */
	private static final long serialVersionUID = -5385187206898024886L;
	
	private static final Map<String,BasisOfRecord> nameMap = new HashMap<String,BasisOfRecord>();
	private static final Map<Integer,BasisOfRecord> valueMap = new HashMap<Integer,BasisOfRecord>();

	public static final BasisOfRecord UNKNOWN = new BasisOfRecord("unknown", 0);
	
	// The following are primarily for occurrence data resources
	public static final BasisOfRecord OBSERVATION = new BasisOfRecord("observation", 1);
	public static final BasisOfRecord SPECIMEN = new BasisOfRecord("specimen", 2);
	public static final BasisOfRecord LIVING = new BasisOfRecord("living", 3);
	public static final BasisOfRecord GERMPLASM = new BasisOfRecord("germplasm", 4);
	public static final BasisOfRecord FOSSIL = new BasisOfRecord("fossil", 5);
	public static final BasisOfRecord LITERATURE = new BasisOfRecord("literature", 6);
	public static final BasisOfRecord PRESERVEDSPECIMEN = new BasisOfRecord("preservedspecimen", 7);
	public static final BasisOfRecord FOSSILSPECIMEN = new BasisOfRecord("fossilspecimen", 8);
	public static final BasisOfRecord LIVINGSPECIMEN = new BasisOfRecord("livingspecimen", 9);
	public static final BasisOfRecord HUMANOBSERVATION = new BasisOfRecord("humanobservation", 10);
	public static final BasisOfRecord MACHINEOBSERVATION = new BasisOfRecord("machineobservation", 11);
	public static final BasisOfRecord STILLIMAGE = new BasisOfRecord("stillimage", 12);
	public static final BasisOfRecord MOVINGIMAGE = new BasisOfRecord("movingimage", 13);
	public static final BasisOfRecord SOUNDRECORDING = new BasisOfRecord("soundrecording", 14);
	public static final BasisOfRecord OTHERSPECIMEN = new BasisOfRecord("otherspecimen", 15);
	public static final BasisOfRecord OCCURRENCE = new BasisOfRecord("occurrence", 16);
	public static final BasisOfRecord MATERIALSAMPLE = new BasisOfRecord("materialsample", 17);
	public static final BasisOfRecord EVENT = new BasisOfRecord("event", 18);
	public static final BasisOfRecord LOCATION = new BasisOfRecord("location", 19);
	public static final BasisOfRecord TAXON = new BasisOfRecord("taxon", 20);
	public static final BasisOfRecord NOMENCLATURALCHECKLIST = new BasisOfRecord("nomenclaturalchecklist", 21);

	// The following are primarily for name/concept data resources
	public static final BasisOfRecord NOMENCLATOR = new BasisOfRecord("nomenclator", 101);
	public static final BasisOfRecord TAXONOMY = new BasisOfRecord("taxonomy", 102);
	public static final BasisOfRecord REGIONALCHECKLIST = new BasisOfRecord("regional_checklist", 103);
	public static final BasisOfRecord LEGISLATIVELIST = new BasisOfRecord("legislative_list", 104);

	public BasisOfRecord() {
		//default constructor, required by hibernate
	}
	
	private BasisOfRecord(String name, int value) {
		super(name, Integer.valueOf(value));
		nameMap.put(name, this);
		valueMap.put(new Integer(value), this);
	}
	
	/**
	 * Utility method to return the enumerated instance for the specified name
	 * @param name The enumerated name value
	 * @return The enumerated instance if found or null
	 */
	public static final BasisOfRecord getBasisOfRecord(String name) {
		if (name != null) {
			return nameMap.get(name);
		}
		return null;
	}
	
	/**
	 * Utility method to return the enumerated instance for the specified value
	 * @param value The enumerated name integer value
	 * @return The enumerated instance if found or null
	 */
	public static final BasisOfRecord getBasisOfRecord(int value) {
		return valueMap.get(new Integer(value));
	}
}