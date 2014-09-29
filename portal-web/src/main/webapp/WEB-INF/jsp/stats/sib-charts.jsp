<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/common/taglibssibcolombia.jsp"%>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
<style>
#defs path {
  stroke-width:1; /* control the countries borders width */
  stroke:#ffffff !important; /* choose a color for the border */
}
</style>
<script type='text/javascript'>
     var rows=[];
     var isoCodeDep=[];
 	<c:forEach items="${departments}" var="department">
 		
 		//rows.push(["<c:out value="${department.departmentName}"/>", parseInt("<c:out value="${department.occurrenceCount}"/>"), parseInt("<c:out value="${department.occurrenceCoordinateCount}"/>")]);
 		rows.push([parseFloat("<c:out value="${department.departmentLat}"/>"),parseFloat("<c:out value="${department.departmentLng}"/>"),"<c:out value="${department.departmentName}"/>", parseInt("<c:out value="${department.occurrenceCoordinateCount}"/>"), parseInt("<c:out value="${department.occurrenceCount}"/>")]);
 		//console.log("${department.departmentName}"+" : "+"${department.isoDepartmentCode}");
 		isoCodeDep["${department.departmentName}"]="${department.isoDepartmentCode}";
 	</c:forEach>
 	google.load('visualization', '1', {'packages': ['geochart']});
    google.setOnLoadCallback(drawMarkersMap);
      function drawMarkersMap() {
    	var table = new google.visualization.DataTable();  
    	table.addColumn('number', 'Lat');
    	table.addColumn('number', 'Long');
    	table.addColumn('string', 'DEPARTAMENTO', 'Departamento');
    	table.addColumn('number', 'Georreferenciados', 'Georreferenciados');
		table.addColumn('number', 'Registros', 'Registros');
		
    	table.addRows(rows);
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: 'transparent', colors: ['#fff0eb', '#e05629'] , datalessRegionColor:'#b55232', height:'600', width:'900'};
        var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
        google.visualization.events.addListener(chart, 'select', function() {
            var selection = chart.getSelection();
            if (selection.length == 1) {
              var selectedRow = selection[0].row;
              var selectedDepartment = table.getValue(selectedRow, 2);
              //console.log(selectedDepartment);
              //window.location.href="${pageContext.request.contextPath}"+"/departments/"+isoCodeDep[selectedDepartment];
              geochart.setSelection();
            }
          });
        chart.draw(table, options);
    };
</script>

<script type='text/javascript'>
     var rows_1=[];
     var isoCodeDep_1=[];
 	 <c:forEach items="${departmentsCounts}" var="departmentCounts">
 		rows_1.push([parseFloat("<c:out value="${departmentCounts.departmentLat}"/>"),parseFloat("<c:out value="${departmentCounts.departmentLng}"/>"),"<c:out value="${departmentCounts.departmentName}"/>",  parseInt("<c:out value="${departmentCounts.occurrenceCount}"/>")]);
 		isoCodeDep_1["${departmentCounts.departmentName}"]="${departmentCounts.isoDepartmentCode}";
 	 </c:forEach>
  	 google.load('visualization', '1', {'packages': ['geochart']});
     google.setOnLoadCallback(drawMarkersMap_1);
     function drawMarkersMap_1() {
     	var table_1 = new google.visualization.DataTable();  
    	table_1.addColumn('number', 'Lat');
    	table_1.addColumn('number', 'Long');
    	table_1.addColumn('string', 'DEPARTAMENTO', 'Departamento');
    	table_1.addColumn('number', 'Nº de Especies', 'Nº de Especies');
    	table_1.addRows(rows_1);
        var options_1 = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: 'transparent', colors: ['#f9cc5c', '#e05629'] , datalessRegionColor:'#594f4f', height:'600', width:'900'};
        var chart_1 = new google.visualization.GeoChart(document.getElementById('chart_div_1'));
        google.visualization.events.addListener(chart_1, 'select', function() {
            var selection_1 = chart_1.getSelection();
            if (selection_1.length == 1) {
              var selectedRow_1 = selection_1[0].row;
              var selectedDepartment_1 = table_1.getValue(selectedRow_1, 2);
              //window.location.href="${pageContext.request.contextPath}"+"/departments/"+isoCodeDep_1[selectedDepartment_1];
              geochart.setSelection();
            }
          });
        chart_1.draw(table_1, options_1);
    };
</script>
 
<script type="text/javascript">
   
	var rowst=[];
	rowst.push(['Publicadores',null,0,0]);
	<c:forEach items="${dataTree}" var="dataTree">
		var datat ='${dataTree}'.split("|");
		rowst.push([datat[0],datat[1],parseInt(datat[2]),parseInt(datat[3])]);
	</c:forEach>
	
	google.load("visualization", "1", {packages:["treemap"]});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var tableTree = new google.visualization.DataTable();
		tableTree.addColumn('string', 'Nombre', 'Nombre');
		tableTree.addColumn('string', 'Parent', 'Parent');
		tableTree.addColumn('number', 'Registros biológicos', 'Registros biológicos');
		tableTree.addColumn('number', 'Registros biológicos georreferenciados', 'Registros biológicos georreferenciados');
		tableTree.addRows(rowst);
		
		var options = {
                //title : 'Registros publicados por cada publicador',
                minColor: '#ffdd69',
                midColor: '#f0801e',
                maxColor: '#ec642d',
                maxColorValue: '80000',
                minColorValue: '50',
                headerHeight: 30,
                fontColor: '#555555',
                fontName: 'Open Sans',
                fontSize: 13,
                showScale: true,
                showTooltips: true,
                headerColor: '#ffffff',
                maxHighlightColor:'#b3dff3'
                
          };
		
		var tree = new google.visualization.TreeMap(document.getElementById('chart_tree'));
		
        google.visualization.events.addListener(tree, 'select', function() {
          });
		
		tree.draw(tableTree, options);    
	}
</script>

	<div>
		<div id="chart_div"></div>
	</div>
	
	<div>
		<div id="chart_div_1"></div>
	</div>