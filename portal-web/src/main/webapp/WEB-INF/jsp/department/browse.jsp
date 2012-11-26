<%@ include file="/common/taglibssibcolombia.jsp"%>
<div id="twopartheader">	
	<h2><spring:message code="departments.list.main.title"/></h2>
	<gbif:alphabetLink rootUrl="/departments/browse/" selected="${selectedChar}" listClass="flatlist" letters="${alphabet}" messageSource="${messageSource}"/>
</div>
<p>
<spring:message code="departments.list.iso.explaination"/>
</p>
<c:choose><c:when test="${selectedChar!=48}"><h2 id="selectedChar">${selectedChar}</h2></c:when><c:otherwise><br/></c:otherwise></c:choose>
<c:choose>
	<c:when test="${fn:length(alphabet)==0}">Currently no departments within the system.</c:when>
	<c:otherwise>
	<display:table name="departments" export="false" class="statistics" id="department">
	  <display:column titleKey="departments.drilldown.main.title" class="name">
	  	<a href="${pageContext.request.contextPath}/departments/${department.isoDepartmentCode}">${department.departmentName}</a>
	  </display:column>	  
	  <display:column titleKey="dataset.list.occurrence.count" class="countrycount">
	  	<c:if test="${department.occurrenceCount>0}"><a href="${pageContext.request.contextPath}/departments/search.htm?<gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"></c:if><fmt:formatNumber value="${department.occurrenceCount}" pattern="###,###"/><c:if test="${department.occurrenceCount>0}"></a></c:if>
	  	(<c:if test="${department.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/departments/search.htm?<gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"></c:if><fmt:formatNumber value="${department.occurrenceCoordinateCount}" pattern="###,###"/><c:if test="${department.occurrenceCoordinateCount>0}"></a></c:if>)
	  </display:column>
	  <display:column titleKey="dataset.speciesCount" class="countrycount">
	  	<c:if test="${department.speciesCount>0}"><a href="${pageContext.request.contextPath}/departments/searchSpecies.htm?<gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"></c:if><fmt:formatNumber value="${department.speciesCount}" pattern="###,###"/><c:if test="${department.speciesCount>0}"></a></c:if>
  	  </display:column>
	  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
	  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
	</display:table>
	</c:otherwise>
</c:choose>