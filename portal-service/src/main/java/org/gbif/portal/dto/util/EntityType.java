/***************************************************************************
 * Copyright (C) 2005 Global Biodiversity Information Facility Secretariat.
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package org.gbif.portal.dto.util;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * An enum type for use generic methods such as mapping, feedback etc that
 * work at the level of multiple entities.
 * 
 * @author dmartin
 */
public class EntityType implements Serializable {

  private static final long serialVersionUID = -8892568969648775859L;

  public static Map<Integer, EntityType> entityTypes = new HashMap<Integer, EntityType>();
  public static Map<String, EntityType> entityTypesByName = new HashMap<String, EntityType>();

  public static final EntityType TYPE_ALL = new EntityType(0, "all");
  public static final EntityType TYPE_TAXON = new EntityType(1, "taxon");
  public static final EntityType TYPE_COUNTRY = new EntityType(2, "country");
  public static final EntityType TYPE_DATA_PROVIDER = new EntityType(3, "provider");
  public static final EntityType TYPE_DATA_RESOURCE = new EntityType(4, "resource");
  public static final EntityType TYPE_RESOURCE_NETWORK = new EntityType(5, "network");
  public static final EntityType TYPE_HOME_COUNTRY = new EntityType(6, "homeCountry");
  public static final EntityType TYPE_OCCURRENCE = new EntityType(7, "occurrence");
  public static final EntityType TYPE_DEPARTMENT = new EntityType(8, "department");
  public static final EntityType TYPE_COUNTY = new EntityType(9, "county");
  public static final EntityType TYPE_PARAMO = new EntityType(10, "paramo");
  public static final EntityType TYPE_MARINEZONE = new EntityType(11, "marineZone");
  public static final EntityType TYPE_PROTECTEDAREA = new EntityType(12, "protectedArea");
  public static final EntityType TYPE_ECOSYSTEM = new EntityType(13, "ecosystem");
  public static final EntityType TYPE_ZONIFICACION = new EntityType(14, "zonificacion");
  
  static {
    entityTypes.put(TYPE_ALL.id, TYPE_ALL);
    entityTypes.put(TYPE_TAXON.id, TYPE_TAXON);
    entityTypes.put(TYPE_COUNTRY.id, TYPE_COUNTRY);
    entityTypes.put(TYPE_DATA_PROVIDER.id, TYPE_DATA_PROVIDER);
    entityTypes.put(TYPE_DATA_RESOURCE.id, TYPE_DATA_RESOURCE);
    entityTypes.put(TYPE_RESOURCE_NETWORK.id, TYPE_RESOURCE_NETWORK);
    entityTypes.put(TYPE_HOME_COUNTRY.id, TYPE_HOME_COUNTRY);
    entityTypes.put(TYPE_OCCURRENCE.id, TYPE_OCCURRENCE);
    entityTypes.put(TYPE_DEPARTMENT.id, TYPE_DEPARTMENT);
    entityTypes.put(TYPE_COUNTY.id, TYPE_COUNTY);
    entityTypes.put(TYPE_PARAMO.id, TYPE_PARAMO);
    entityTypes.put(TYPE_MARINEZONE.id, TYPE_MARINEZONE);
    entityTypes.put(TYPE_PROTECTEDAREA.id, TYPE_PROTECTEDAREA);
    entityTypes.put(TYPE_ECOSYSTEM.id, TYPE_ECOSYSTEM);
    entityTypes.put(TYPE_ZONIFICACION.id, TYPE_ZONIFICACION);
    entityTypesByName.put(TYPE_ALL.name, TYPE_ALL);
    entityTypesByName.put(TYPE_TAXON.name, TYPE_TAXON);
    entityTypesByName.put(TYPE_COUNTRY.name, TYPE_COUNTRY);
    entityTypesByName.put(TYPE_DATA_PROVIDER.name, TYPE_DATA_PROVIDER);
    entityTypesByName.put(TYPE_DATA_RESOURCE.name, TYPE_DATA_RESOURCE);
    entityTypesByName.put(TYPE_RESOURCE_NETWORK.name, TYPE_RESOURCE_NETWORK);
    entityTypesByName.put(TYPE_HOME_COUNTRY.name, TYPE_HOME_COUNTRY);
    entityTypesByName.put(TYPE_OCCURRENCE.name, TYPE_OCCURRENCE);
    entityTypesByName.put(TYPE_DEPARTMENT.name, TYPE_DEPARTMENT);
    entityTypesByName.put(TYPE_COUNTY.name, TYPE_COUNTY);
    entityTypesByName.put(TYPE_PARAMO.name, TYPE_PARAMO);
    entityTypesByName.put(TYPE_MARINEZONE.name, TYPE_MARINEZONE);
    entityTypesByName.put(TYPE_PROTECTEDAREA.name, TYPE_PROTECTEDAREA);
    entityTypesByName.put(TYPE_ECOSYSTEM.name, TYPE_ECOSYSTEM);
    entityTypesByName.put(TYPE_ZONIFICACION.name, TYPE_ZONIFICACION);
  }

  /** Unique id for this enum type */
  private final int id;
  /** Unique name for this enum type */
  private final String name;

  private EntityType(int id, String name) {
    this.id = id;
    this.name = name;
  }

  /**
   * @return the id
   */
  public int getId() {
    return id;
  }

  /**
   * @return the name
   */
  public String getName() {
    return name;
  }

  /**
   * Returns the getName()
   */
  @Override
  public String toString() {
    return getName();
  }
}