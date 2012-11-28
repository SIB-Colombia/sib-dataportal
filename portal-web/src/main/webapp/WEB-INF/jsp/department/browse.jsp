<%@ include file="/common/taglibssibcolombia.jsp"%>
<% /* SIB Colombia Commenting code to show map at the bottom
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
</script> */ %>
<div id="twopartheader">	
	<h2><spring:message code="departments.list.main.title"/>: <span class="subject"><gbif:capitalize><string:lowerCase><spring:message code="country.${country.isoCountryCode}"/></string:lowerCase></gbif:capitalize></span></h2>
	<p style="padding-left: 10px;">
	<spring:message code="departments.list.iso.explaination"/>
	</p>
	<% // SIB Colombia, disable show alphabet option %>
	<% //<gbif:alphabetLink rootUrl="/departments/browse/" selected="${selectedChar}" listClass="flatlist" letters="${alphabet}" messageSource="${messageSource}"/> %>
</div>
<c:choose><c:when test="${selectedChar!=48}"><h2 id="selectedChar">${selectedChar}</h2></c:when><c:otherwise></c:otherwise></c:choose>
<c:choose>
	<c:when test="${fn:length(alphabet)==0}">Currently no departments within the system.</c:when>
	<c:otherwise>
	
	<% // SIB Colombia, details of Colombia %>
	<tiles:insert page="actions.jsp"/>
	
	<div class="subcontainer">
		<tiles:insert page="occurrences.jsp"/>
	</div>
	
	<fmt:setLocale value="en_US"/>
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
<br></br>

<% /* SIB Colombia Commenting code to show map at the bottom
<div id="container"style="width: 750px; height: 468px; margin-bottom: 30px;">
	<h4><spring:message text="Mapa de registros por departamentos"/></h4>
	<div id="chart_div" style="width: 750px; height: 468px;  margin-left: -375px; left: 50%"></div>
</div> */ %>