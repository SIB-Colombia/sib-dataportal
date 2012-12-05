<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/common/taglibssibcolombia.jsp"%>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
     var rows=[];
     var isoCodeDep=[];
 	<c:forEach items="${departments}" var="department">
 		//rows.push(["<c:out value="${department.departmentName}"/>", parseInt("<c:out value="${department.occurrenceCount}"/>"), parseInt("<c:out value="${department.occurrenceCoordinateCount}"/>")]);
 		rows.push(["<c:out value="${department.departmentName}"/>", parseInt("<c:out value="${department.occurrenceCoordinateCount}"/>"), parseInt("<c:out value="${department.occurrenceCount}"/>")]);
 		isoCodeDep["${department.departmentName}"]="${department.isoDepartmentCode}";
 	</c:forEach>
 	google.load('visualization', '1', {'packages': ['geochart']});
    google.setOnLoadCallback(drawMarkersMap);
      function drawMarkersMap() {
    	var table = new google.visualization.DataTable();  
    	table.addColumn('string', 'DEPARTAMENTO', 'Departamento');
    	table.addColumn('number', 'Registros Biológicos Georeferenciados', 'Registros Biológicos Georeferenciados');
		table.addColumn('number', 'Registros Biológicos', 'Registros Biológicos');
		
    	table.addRows(rows);
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#C2EBF6', colors: ['#FFFFFF', '#fcd360']};   //, , datalessRegionColor:'#ff0000', legend:'none', height:'375', width:'375'
        var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
        google.visualization.events.addListener(chart, 'select', function() {
            var selection = chart.getSelection();
            if (selection.length == 1) {
              var selectedRow = selection[0].row;
              var selectedDepartment = table.getValue(selectedRow, 0);
              //alert(selectedDepartment);
              window.location.href="${pageContext.request.contextPath}"+"/departments/"+isoCodeDep[selectedDepartment];
              geochart.setSelection();
            }
          });
        chart.draw(table, options);
    };
</script>


<div id="chart_div" style="width: 600px; height: 375px;"></div>
