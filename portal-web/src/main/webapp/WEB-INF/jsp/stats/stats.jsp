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
    	table.addColumn('number', 'Registros biológicos georreferenciados', 'Registros biológicos georreferenciados');
		table.addColumn('number', 'Registros biológicos', 'Registros biológicos');
		
    	table.addRows(rows);
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#a8d4dc', colors: ['#f2ddb0', '#ec7532'] , datalessRegionColor:'#a6b361', height:'500', width:'800'};
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
                plotShadow: false,
				borderRadius: 20,
				height:350,
				width:950,
				style: {
					fontFamily: '"Open Sans", Arial, Helvetica, sans-serif',
					fontSize: '15px',
				}
            },
			colors: ['#b55232', '#a4d8f2','#556116', '#ec5d2d', '#ffdd69', '#009bde', '#ef7f4a', '#a7b165', '#6dc8ef', '#34bce0','#fed743', '#3F7C8F', '#f5b22f', '#1888c9'],
           // title: {text: 'Especies por publicador'},
            credits: {
                enabled: false
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 1
            },
			legend:{
				borderWidth:0,
				layout:'vertical',
				align:'right',
				verticalAlign:'middle',
				itemMarginTop:2,
				itemMarginBottom:2,
				symbolWidth:20,
				style: {
					fontFamily: '"Open Sans", Arial, Helvetica, sans-serif',
					color:'#6B6B6B',
				},
				itemStyle: {
					fontSize: '13px',
					color: '#6B6B6B',
				},
			},
			title: {
			   text: ''
			},
            plotOptions: {
                pie: {
					size: '90%',
					borderWidth:0,
					shadow: false,
					hover : {
						brightness: 0.5,
						enabled: true,
						lineWidth: 0,
					},
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
    	lnt=aNumO.length;
    	var arow= new Array();
    	for(j=0;j<3;j++){
    		arow.push(aNumO[(lnt)-(3-j)]);
    	}
    	table.addRows(arow);
    	
    	//table.addRows(aNumO);
        var options = {
                //title : 'Registros publicados por cada publicador',
                vAxis: {title: "Registros", color:"#6B6B6B", logScale:"true", textStyle:{color: '#6B6B6B'}, format:'#'},
                hAxis: {title: "Mes", color:"#6B6B6B", textStyle:{color: '#6B6B6B'}},
                seriesType: "bars",
                fontSize: "13",
				fontName: 'Open Sans',
				bar: {groupWidth:'80%'},
               // axisTitlesPosition:'in',
                chartArea:{width:"60%",height:"85%", left:"120"},
                colors:['#a7b165', '#fed743','#34bce0', '#ef7f4a', '#3F7C8F', '#6b3d11', '#1888c9', '#f5b22f', '#b55232', '#a4d8f2','#556116', '#ec5d2d', '#ffdd69', '#0098d9'],
                legend:{position: 'right', textStyle: {color: '#6B6B6B'}},
				areaOpacity:0,
				height:'450',
				width:'950',
				animation: {easing:'inAndOut' }
              };
        
        var chart = new google.visualization.ComboChart(document.getElementById('chart_stat'));
        chart.draw(table, options);
	}
	
	google.setOnLoadCallback(drawVisualization);
</script>

Tree map de google 
<script type="text/javascript">
	var rowst=[];
	rowst.push(['Publicadores',null,0,0]);
	<c:forEach items="${dataTree}" var="dataTree">
		var datat ='${dataTree}'.split("|");
		//alert(datat.length);
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
                minColor: '#A9E2F3',
                midColor: '#ddd',
                maxColor: '#01A9DB',
                maxColorValue: '200000',
                minColorValue: '500',
                headerHeight: 20,
                fontColor: 'black',
                fontName: 'Open Sans',
                showScale: true,
                showTooltips: true
                
          };
		
		var tree = new google.visualization.TreeMap(document.getElementById('chart_tree'));
		
        google.visualization.events.addListener(tree, 'select', function() {
          });
		
		tree.draw(tableTree, options);    
	}
</script>

<div class="subcontainer stats">
<div>
	<h4>Registros biológicos por departamento</h4>
	<div id="chart_div" style=" width:720px; float:left;"></div>
     <p><img src="${pageContext.request.contextPath}/images/legend_map.png" /></p>
    <p><strong>Haz click sobre el departamento de tu interés para ver los registros en nuestro <a href="htttp://data.sibcolombia.net" target="_blank">Portal de datos</a></strong></p>
   
    <p>El tamaño de los círculos es proporcional al total de registros por departamento. El color es indicativo del número de registros con coordenadas geográficas</p>
   
</div>

<div><h4>Número de registros por publicador en los últimos meses</h4>
	<div id="chart_stat"></div>
</div>

<div>
	<div id="chart_tree" style="width: 720px; height: 500px;"></div>
</div>

<!--
<div><h4>Número de registros por publicador en los últimos meses</h4>
	<div id="pchart"></div>
</div> -->

</div>

