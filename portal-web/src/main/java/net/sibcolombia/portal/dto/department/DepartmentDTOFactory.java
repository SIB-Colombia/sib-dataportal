package net.sibcolombia.portal.dto.department;

import org.gbif.portal.dto.BaseDTOFactory;

import net.sibcolombia.portal.model.geospatial.Department;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;


public class DepartmentDTOFactory extends BaseDTOFactory {

  protected static Log logger = LogFactory.getLog(DepartmentDTOFactory.class);

  public Object createDTO(Object modelObject) {
    if (modelObject == null)
      return null;
    Object[] departmentModel = (Object[]) modelObject;
    Department department = new Department();
    department.setId((Long) departmentModel[0]);
    department.setDepartmentName((String) departmentModel[1]);
    department.setIsoDepartmentCode((String) departmentModel[2]);
    department.setOccurrenceCount((Integer) departmentModel[3]);
    department.setOccurrenceCoordinateCount((Integer) departmentModel[4]);
    department.setSpeciesCount((Integer) departmentModel[5]);
    department.setDepartmentLat((String)departmentModel[6]);
    department.setDepartmentLng((String)departmentModel[7]);

    String[] ignores = new String[] {"key"};
    DepartmentDTO departmentDTO = new DepartmentDTO();
    BeanUtils.copyProperties(department, departmentDTO, ignores);
    departmentDTO.setKey(department.getIsoDepartmentCode());

    if (departmentDTO.getOccurrenceCoordinateCount() == null)
      departmentDTO.setOccurrenceCoordinateCount(0);
    if (departmentDTO.getIsoDepartmentCode() == null)
      departmentDTO.setIsoDepartmentCode("Código no determinado");

    return departmentDTO;
  }

  public Object createDTOSingle(Object modelObject) {
    if (modelObject == null)
      return null;

    Department department = (Department) modelObject;

    String[] ignores = new String[] {"key"};
    DepartmentDTO departmentDTO = new DepartmentDTO();
    BeanUtils.copyProperties(department, departmentDTO, ignores);
    departmentDTO.setKey(Long.toString(department.getDepartmentId()));

    if (departmentDTO.getOccurrenceCoordinateCount() == null)
      departmentDTO.setOccurrenceCoordinateCount(0);
    if (departmentDTO.getIsoDepartmentCode() == null)
      departmentDTO.setIsoDepartmentCode("Código no determinado");

    return departmentDTO;
  }

  public Object createDTOSingleId(Object modelObject) {
    if (modelObject == null)
      return null;

    Department department = (Department) modelObject;

    String[] ignores = new String[] {"key"};
    DepartmentDTO departmentDTO = new DepartmentDTO();
    BeanUtils.copyProperties(department, departmentDTO, ignores);
    departmentDTO.setKey(Long.toString(department.getDepartmentId()));

    if (departmentDTO.getOccurrenceCoordinateCount() == null)
      departmentDTO.setOccurrenceCoordinateCount(0);
    if (departmentDTO.getIsoDepartmentCode() == null)
      departmentDTO.setIsoDepartmentCode("Código no determinado");

    return departmentDTO;
  }
}
