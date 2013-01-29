<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/common/taglibssibcolombia.jsp"%>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
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
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#a8d4dc', colors: ['#f2ddb0', '#ec7532'] , datalessRegionColor:'#a6b361', legend:'none', height:'450', width:'450'};
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

<script type='text/javascript'>

$(function () {
	var rowst=[];
	<c:forEach items="${dataProviders}" var="dataProviders">
 		//rows.push(["<c:out value="${department.departmentName}"/>", parseInt("<c:out value="${department.occurrenceCount}"/>"), parseInt("<c:out value="${department.occurrenceCoordinateCount}"/>")]);
 		rowst.push(["<c:out value="${dataProviders.name}"/>", parseInt("<c:out value="${dataProviders.occurrenceCount}"/>")]);
 	</c:forEach>
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'pchart',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: true
            },
            title: {
                text: 'Especies por publicador'
            },
            credits: {
                enabled: false
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                type: 'pie',
                name: 'Porcentaje de Registros',
                data: rowst
            }]
        });
    });
    
});
</script>



<script type='text/javascript'>
	
	var months= new Array();
	var numMonths=0;
	var numPublishers=0;
	var publishers = new Array();
	var dataOcurrences = new Array();
	var values = new Array();
	<c:forEach items="${dataDate}" var="dataDate">
		var data ="${dataDate}".split("|");
		if(months.indexOf(data[0])==-1){
			months.push(data[0]);
			numMonths++;
			if(publishers.indexOf(data[1])==-1){
				publishers.push(data[1]);
				numPublishers++;
				values.push(data[2]+"|"+(numMonths-1)+"|"+(numPublishers-1));
			}else{
				values.push(data[2]+"|"+(numMonths-1)+"|"+(publishers.indexOf(data[1])));
			}
		}else{
			if(publishers.indexOf(data[1])==-1){
				publishers.push(data[1]);
				numPublishers++;
				values.push(data[2]+"|"+months.indexOf(data[0])+"|"+(numPublishers-1));
			}else{
				values.push(data[2]+"|"+months.indexOf(data[0])+"|"+(publishers.indexOf(data[1])));
			}
		}
	</c:forEach>
	
	var aNumO= new Array(numMonths);
	
	for (i=0;i<numMonths;i++){
		var aNumOP= new Array(numPublishers+1);
		for(k=0;k<aNumOP.length;k++){
			aNumOP[k]=0;
		}
		aNumOP[0]=months[i];
		aNumO[i]=aNumOP;
	}
	
	
	for (i=0;i<values.length;i++){
		num=parseInt(values[i].split("|")[0]);
		mo=parseInt(values[i].split("|")[1]);
		pu=parseInt(values[i].split("|")[2])+1;
		aNumO[parseInt(mo)][parseInt(pu)]=num;
	}
	
	
	for (i=1;i<aNumO.length;i++){
		for(j=1;j<aNumO[i].length;j++){;
			aNumO[i][j]=aNumO[i][j]+aNumO[i-1][j];
		}
	}
	
	google.load('visualization', '1', {packages: ['corechart']});
	
	function drawVisualization() {
		var table = new google.visualization.DataTable();
    	table.addColumn('string', 'Mes', 'Mes');
    	for(i=0;i<publishers.length;i++){
    		table.addColumn('number', publishers[i], publishers[i]);
    	}
    	table.addRows(aNumO);
        var options = {
                title : 'Registros publicados por cada publicador',
                vAxis: {title: "Registros"},
                hAxis: {title: "Mes"},
                seriesType: "bars",
                fontSize: 8,
                axisTitlesPosition:'in',
                chartArea:{width:"70%",height:"85%"}
              };
        
        var chart = new google.visualization.ComboChart(document.getElementById('chart_stat'));
        chart.draw(table, options);
	}
	
	google.setOnLoadCallback(drawVisualization);
	
</script>


<div class="subcontainer">
<div id="chart_stat" style="width: 500px; height: 500px; float:left;"></div>
<div id="pchart" style="width: 450px; height: 450px; float:left;"></div>
<div id="chart_div" style="min-width: 400px; height: 150px; clear : both;"></div>
</div>

