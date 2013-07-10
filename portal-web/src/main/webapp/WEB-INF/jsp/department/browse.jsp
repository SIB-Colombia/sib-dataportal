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
		table.addColumn('number', 'Registros Biol�gicos', 'Registros Biol�gicos');
		table.addColumn('number', 'Registros Biol�gicos Georeferenciados', 'Registros Biol�gicos Georeferenciados');
    	table.addRows(rows);
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#C2EBF6', colors: ['#FFFFFF', '#fcd360']};   //, displayMode: 'markers'
        var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
        chart.draw(table, options);
    };
</script> */ %>
<div id="twopartheader">	
	<h2><spring:message code="departments.list.main.title"/>: <span class="subject"><gbif:capitalize><string:lowerCase><spring:message code="country.${country.isoCountryCode}"/></string:lowerCase></gbif:capitalize></span>
	</h2>
	
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
        <div class="menu_amarillo"><p>
    <spring:message code="departments.list.link.countries" arguments="${pageContext.request.contextPath}/paises/"/>
	</p></div>
	</div>
	
	<fmt:setLocale value="en_US"/>
	
	<display:table name="departments" export="false" class="statistics" id="department" cellspacing="0">
	  <display:column titleKey="deparments.drilldown.main.title" class="name">
	  	<a href="${pageContext.request.contextPath}/departments/${department.isoDepartmentCode}">${department.departmentName}</a>
	  </display:column>	  
	  <display:column titleKey="dataset.list.occurrence.count.nongeoreferenced" class="countrycount">
	  	<c:if test="${department.occurrenceCount>0}"><a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"></c:if><fmt:formatNumber value="${department.occurrenceCount}" pattern="###,###"/><c:if test="${department.occurrenceCount>0}"></a></c:if>
	  </display:column>
	  <display:column titleKey="dataset.list.occurrence.count.georeferenced" class="countrycount">
	  	<c:if test="${department.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"></c:if><fmt:formatNumber value="${department.occurrenceCoordinateCount}" pattern="###,###"/><c:if test="${department.occurrenceCoordinateCount>0}"></a></c:if>
	  </display:column>
	  <display:column titleKey="dataset.speciesCount" class="countrycount">
	  	<c:if test="${department.speciesCount>0}"><a href="${pageContext.request.contextPath}/especies/browse/department/${department.isoDepartmentCode}" index="0"/></c:if><fmt:formatNumber value="${department.speciesCount}" pattern="###,###"/><c:if test="${department.speciesCount>0}"></a></c:if>
  	  </display:column>
	  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
	  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
	</display:table>
	</c:otherwise>
</c:choose>

<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	var oTable = $('#department').dataTable( {
        "iDisplayLength": 100,
        "bLengthChange": false,
        "bAutoWidth": false,
        "aaSorting": [[ 0, "asc" ]],
        "oLanguage": {
            "sEmptyTable": '<spring:message code="dataset.list.semptytable"/>',
            "sZeroRecords":'<spring:message code="dataset.list.szerorecords"/> ',
            "sInfo": '<spring:message code="dataset.list.sinfo" arguments="_START_,_END_,_TOTAL_"/>',
            "sInfoEmpty": '<spring:message code="dataset.list.sinfoempty"/>',
            "sInfoFiltered": '<spring:message code="dataset.list.sinfofiltered" arguments="_MAX_"/> ',
            "sSearch": '<spring:message code="dataset.list.ssearch"/>',
            "oPaginate": {
                "sNext": '<spring:message code="dataset.list.snext"/>',
                "sPrevious": '<spring:message code="dataset.list.sprevious" />'
            }
        },"aoColumnDefs": [{ 'bSortable': true, 'aTargets': [ 0 ] }], 
		"fnDrawCallback": function(){
      	  if(this.fnSettings().fnRecordsDisplay()<=$('#department tr').length){
    		  $('#department_paginate').hide();
    	  }else{
    		  $('#department_paginate').show();  
    	  }
      	},"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
      		if($(nRow).attr('class')=='odd even'){
      			$(nRow).attr('class', 'even');
      		}
      		if($(nRow).attr('class')=='even odd'){
      			$(nRow).attr('class', 'odd');
      		}
      	}
    } );
} );
</script>
<br></br>

<% /* SIB Colombia Commenting code to show map at the bottom
<div id="container"style="width: 750px; height: 468px; margin-bottom: 30px;">
	<h4><spring:message text="Mapa de registros por departamentos"/></h4>
	<div id="chart_div" style="width: 750px; height: 468px;  margin-left: -375px; left: 50%"></div>
</div> */ %>