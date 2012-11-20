package net.sibcolombia.portal.dto.department;

import org.gbif.portal.dto.BaseDTOFactory;

import net.sibcolombia.portal.model.Department;
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
    department.setDepartmentName((String) departmentModel[0]);
    department.setOccurrenceCount(Integer.valueOf(Long.toString((long) departmentModel[1], 0)));
    department.setOccurrenceCoordinateCount(Integer.valueOf(Long.toString((long) departmentModel[2], 0)));
    department.setIsoDepartmentCode((String) departmentModel[3]);

    String[] ignores = new String[] {"key"};
    DepartmentDTO departmentDTO = new DepartmentDTO();
    BeanUtils.copyProperties(department, departmentDTO, ignores);
    departmentDTO.setKey(department.getDepartmentName());

    if (departmentDTO.getOccurrenceCoordinateCount() == null)
      departmentDTO.setOccurrenceCoordinateCount(0);
    if (departmentDTO.getIsoDepartmentCode() == null)
      departmentDTO.setIsoDepartmentCode("Código no determinado");

    return departmentDTO;
  }
}
