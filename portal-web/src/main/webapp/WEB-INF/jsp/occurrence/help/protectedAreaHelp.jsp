<%@ include file="/common/taglibs.jsp"%>
<div class="geospatialFilterHelp">
<p>
<c:set var="addFilterMsg"><spring:message code="search.filter.add.filter"/></c:set>
<spring:message code="occurrence.protectedArea.help1" arguments="${addFilterMsg}" argumentSeparator="$$$"/>
</p>
<p>
<spring:message code="occurrence.protectedArea.help2"/>
</p>
<p>
<spring:message code="occurrence.protectedArea.help3"/>
</p>
</div>