<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	var criteria = "<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>";
</script>
<c:set var="pointsTotal" value="${department.occurrenceCoordinateCount}" scope="request"/>
<c:set var="occurrenceCount" value="${department.occurrenceCount}" scope="request"/>
<c:set var="entityName" scope="request"><gbif:capitalize><spring:message code="department.${department.isoDepartmentCode}"/></gbif:capitalize></c:set>
<c:set var="extraParams" scope="request"><gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/></c:set>

<tiles:insert name="overviewMapDepartment"/>

<% /* <c:set var="pointsTotal" value="${department.occurrenceCoordinateCount}" scope="request"/>
<c:set var="occurrenceCount" value="${department.occurrenceCount}" scope="request"/>
<c:set var="entityName" scope="request"><gbif:capitalize><spring:message code="country.${department.isoDepartmentCode}"/></gbif:capitalize></c:set>
<c:set var="extraParams" scope="request"><gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/></c:set>
<tiles:insert name="overviewMapDepartment"/>
<!--<tiles:insert name="geographyOverviewMap"/>--> */ %>