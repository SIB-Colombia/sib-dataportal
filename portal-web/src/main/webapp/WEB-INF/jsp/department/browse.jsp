<%@ include file="/common/taglibssibcolombia.jsp"%>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
     var rows=[];
 	<c:forEach items="${departments}" var="department">
 		rows.push(["<c:out value="${department.departmentName}"/>", parseInt("<c:out value="${department.occurrenceCount}"/>"), parseInt("<c:out value="${department.occurrenceCoordinateCount}"/>")]);
 	</c:forEach>
 	google.load('visualization', '1', {'packages': ['geochart']});
    google.setOnLoadCallback(drawMarkersMap);
      function drawMarkersMap() {
    	var table = new google.visualization.DataTable();  
    	table.addColumn('string', 'DEPARTAMENTO', 'Departamento');
		table.addColumn('number', 'Registros Biológicos', 'Registros Biológicos');
		table.addColumn('number', 'Registros Biológicos Georeferenciados', 'Registros Biológicos Georeferenciados');
    	table.addRows(rows);
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#C2EBF6', colors: ['#FFFFFF', '#fcd360']};   //, displayMode: 'markers'
        var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
        chart.draw(table, options);
    };
</script>
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
	<fmt:setLocale value="en_US"/>
	<table id="country" class="statistics">
		<thead>
			<tr>
				<th><spring:message code="departments.country.list.main.title"/></th>
				<th><spring:message code="dataset.list.occurrence.count.nongeoreferenced"/></th>
				<th><spring:message code="dataset.list.occurrence.count.georeferenced"/></th>
				<th><spring:message code="dataset.speciesCount"/></th>
			</tr>
		</thead>
		<tbody>
			<tr class="odd">
				<td class="name">
					<img src="${pageContext.request.contextPath}/images/flags/<string:lowerCase>${country.isoCountryCode}</string:lowerCase>.gif"/>&nbsp;<a href="${pageContext.request.contextPath}/countries/${country.isoCountryCode}"><gbif:capitalize><spring:message code="country.${country.isoCountryCode}"/></gbif:capitalize></a>
				</td>
				<td class="countrycount">
					<c:if test="${country.occurrenceCount>0}"><a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>"></c:if><fmt:formatNumber value="${country.occurrenceCount}" pattern="###,###"/><c:if test="${country.occurrenceCount>0}"></a></c:if>
				</td>
				<td class="countrycount">
					<c:if test="${country.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"></c:if><fmt:formatNumber value="${country.occurrenceCoordinateCount}" pattern="###,###"/><c:if test="${country.occurrenceCoordinateCount>0}"></a></c:if>
				</td>
				<td class="countrycount">
					<c:if test="${country.speciesCount>0}"><a href="${pageContext.request.contextPath}/occurrences/searchSpecies.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>"></c:if><fmt:formatNumber value="${country.speciesCount}" pattern="###,###"/><c:if test="${country.speciesCount>0}"></a></c:if>
				</td>
			</tr>
		</tbody>
	</table>
	<p>
		<spring:message code="departments.list.link.countries" arguments="${pageContext.request.contextPath}/countries/"/>
	</p>
	<display:table name="departments" export="false" class="statistics sortable" id="department">
	  <display:column titleKey="deparments.drilldown.main.title" class="name">
	  	<a href="${pageContext.request.contextPath}/departments/${department.isoDepartmentCode}">${department.departmentName}</a>
	  </display:column>	  
	  <display:column titleKey="dataset.list.occurrence.count.nongeoreferenced" class="countrycount">
	  	<c:if test="${department.occurrenceCount>0}"><a href="${pageContext.request.contextPath}/departments/search.htm?<gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"></c:if><fmt:formatNumber value="${department.occurrenceCount}" pattern="###,###"/><c:if test="${department.occurrenceCount>0}"></a></c:if>
	  </display:column>
	  <display:column titleKey="dataset.list.occurrence.count.georeferenced" class="countrycount">
	  	<c:if test="${department.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/departments/search.htm?<gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"></c:if><fmt:formatNumber value="${department.occurrenceCoordinateCount}" pattern="###,###"/><c:if test="${department.occurrenceCoordinateCount>0}"></a></c:if>
	  </display:column>
	  <display:column titleKey="dataset.speciesCount" class="countrycount">
	  	<c:if test="${department.speciesCount>0}"><a href="${pageContext.request.contextPath}/departments/searchSpecies.htm?<gbif:criterion subject="5" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"></c:if><fmt:formatNumber value="${department.speciesCount}" pattern="###,###"/><c:if test="${department.speciesCount>0}"></a></c:if>
  	  </display:column>
	  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
	  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
	</display:table>
	</c:otherwise>
</c:choose>

<div id="container"style="width: 750px; height: 468px; ">
	<h4><spring:message text="Mapa de registros por departamentos"/></h4>
	<div id="chart_div" style="width: 750px; height: 468px;  margin-left: -375px; left: 50%"></div>
</div>
<br></br>