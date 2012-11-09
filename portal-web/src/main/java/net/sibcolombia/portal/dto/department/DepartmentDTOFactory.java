package net.sibcolombia.portal.dto.department;

import org.gbif.portal.dto.BaseDTOFactory;

import net.sibcolombia.portal.model.Department;
import org.springframework.beans.BeanUtils;


public class DepartmentDTOFactory extends BaseDTOFactory {

  @Override
  public Object createDTO(Object modelObject) {
    if (modelObject == null)
      return null;
    Object[] departmentModel = (Object[]) modelObject;
    Department department = (Department) departmentModel[0];


    String[] ignores = new String[] {"key", "name"};
    DepartmentDTO departmentDTO = new DepartmentDTO();
    BeanUtils.copyProperties(department, departmentDTO, ignores);
    departmentDTO.setKey(department.getDepartmentCode());
    departmentDTO.setName(department.getDepartmentName());
    departmentDTO.setIsoDepartmentCode(department.getDepartmentCode());
    departmentDTO.setOccurrenceCount(department.getOcurrenceCount());
    departmentDTO.setOccurrenceCoordinateCount(department.getOcurrenceCoordinateCount());


    if (departmentModel[1] instanceof Department) {
      Department departmentName = (Department) departmentModel[1];
      departmentDTO.setName(departmentName.getDepartmentName());
    } else if (departmentModel[1] instanceof String) {
      departmentDTO.setName((String) departmentModel[1]);
    }
    if (departmentModel.length > 2) {
      departmentDTO.setInterpretedFrom((String) departmentModel[2]);
    }
    if (departmentDTO.getOccurrenceCoordinateCount() == null)
      departmentDTO.setOccurrenceCoordinateCount(0);

    return departmentDTO;
  }
}
