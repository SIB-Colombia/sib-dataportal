package net.sibcolombia.portal.dto.department;

import org.gbif.portal.dto.BaseDTOFactory;

import net.sibcolombia.portal.model.geospatial.Department;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;


public class DepartmentDTOFactory extends BaseDTOFactory {

  protected static Log logger = LogFactory.getLog(DepartmentDTOFactory.class);

  @Override
  public Object createDTO(Object modelObject) {
    if (modelObject == null)
      return null;
    Object[] departmentModel = (Object[]) modelObject;
    Department department = new Department();
    logger.info("Valor 0: " + departmentModel[0]);
    logger.info("Valor 1: " + departmentModel[1]);
    logger.info("Valor 2: " + departmentModel[2]);
    logger.info("Valor 3: " + departmentModel[3]);
    logger.info("Valor 4: " + departmentModel[4]);
    logger.info("Valor 5: " + departmentModel[5]);
    department.setDepartmentId((Long) departmentModel[0]);
    department.setDepartmentName((String) departmentModel[1]);
    department.setIsoDepartmentCode((String) departmentModel[2]);
    department.setOccurrenceCount((Integer) departmentModel[3]);
    department.setOccurrenceCoordinateCount((Integer) departmentModel[4]);
    department.setSpeciesCount((Integer) departmentModel[5]);

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
}
