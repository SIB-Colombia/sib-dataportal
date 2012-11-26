<%@ include file="/common/taglibs.jsp"%>
<div class="geospatialFilterHelp">
<p>
<c:set var="addFilterMsg"><spring:message code="search.filter.add.filter"/></c:set>
<spring:message code="occurrence.department.help1" arguments="${addFilterMsg}" argumentSeparator="$$$"/>
</p>
<p>
<spring:message code="occurrence.department.help2"/>
</p>
</div>