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
    	table.addColumn('number', 'Registros biológicos georreferenciados', 'Registros biológicos georreferenciados');
		table.addColumn('number', 'Registros biológicos', 'Registros biológicos');
		
    	table.addRows(rows);
        var options = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#a8d4dc', colors: ['#f2ddb0', '#ec7532'] , datalessRegionColor:'#a6b361', height:'500', width:'800'};
        var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
        google.visualization.events.addListener(chart, 'select', function() {
            var selection = chart.getSelection();
            if (selection.length == 1) {
              var selectedRow = selection[0].row;
              var selectedDepartment = table.getValue(selectedRow, 2);
              //console.log(selectedDepartment);
              window.location.href="${pageContext.request.contextPath}"+"/departments/"+isoCodeDep[selectedDepartment];
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
    	table_1.addColumn('number', 'Especies por departamento', 'Especies por departamento');
    	table_1.addRows(rows_1);
        var options_1 = {region: 'CO', resolution: 'provinces' , displayMode: 'markers', enableRegionInteractivity: true, backgroundColor: '#a8d4dc', colors: ['#deed97', '#9ba85c'] , datalessRegionColor:'#fdf6c6', height:'500', width:'800'};
        var chart_1 = new google.visualization.GeoChart(document.getElementById('chart_div_1'));
        google.visualization.events.addListener(chart_1, 'select', function() {
            var selection_1 = chart_1.getSelection();
            if (selection_1.length == 1) {
              var selectedRow_1 = selection_1[0].row;
              var selectedDepartment_1 = table_1.getValue(selectedRow_1, 2);
              window.location.href="${pageContext.request.contextPath}"+"/departments/"+isoCodeDep_1[selectedDepartment_1];
              geochart.setSelection();
            }
          });
        chart_1.draw(table_1, options_1);
    };
</script>
  
<script type='text/javascript'>
$(function () {
	var rowst=[];
	<c:forEach items="${providersRes}" var="providersRes">
		var dataPR="${providersRes}".split("|");
		//alert(dataPR[0]+" "+dataPR[1]);
		rowst.push([dataPR[0], parseInt(dataPR[1])]);
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
            	formatter: function() {
                    return '<b>'+ this.point.name +
                        '</b> : <b>'+ this.y +'</b>';
                }
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

<script type='text/javascript'>
	
	var rowst_1=[];
	var taxonConcepts = new Array();
	var numTaxons=0;
	
	<c:forEach items="${taxonRes}" var="taxonRes">
		var dataTX ="${taxonRes}".split("|");
		//alert(dataTX[0]+" "+dataTX[1]);
		rowst_1.push([dataTX[0],parseInt(dataTX[1])]);
	</c:forEach>
	
	google.load('visualization', '1', {packages: ['corechart']});
	google.setOnLoadCallback(drawVisualization);
	
	function drawVisualization() {
		var tableTX = new google.visualization.DataTable();
		tableTX.addColumn('string', 'Taxon');
		tableTX.addColumn('number', 'Registros');
		tableTX.addRows(rowst_1);

        var options = {
                vAxis: {title: "Cantidad de registros", color:"#6B6B6B", logScale:"true", textStyle:{color: '#6B6B6B'}, format:'#',titleTextStyle:{bold:true}},
                hAxis: {title: "Grupo biológico", color:"#6B6B6B", textStyle:{color: '#6B6B6B'},titleTextStyle:{bold:true}},
                seriesType: "bars",
                fontSize: "13",
				fontName: 'Open Sans',
				bar: {groupWidth:'70%'},
                colors:[ '#F1C593'],
                legend:{position: 'right', textStyle: {color: '#6B6B6B'}},
				areaOpacity:0,
				height:'450',
				width:'950',
				dataOpacity: 0.8,
				backgroundColor: 'none'
              };
        
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_stat_1'));
        chart.draw(tableTX, options);
	}
	
	
</script>

<script type='text/javascript'>
	
	var rowst_2=[];
	var providerType = new Array();
	var numTaxons=0;
	
	<c:forEach items="${providersTypeRes}" var="providersTypeRes">
		var dataPT ="${providersTypeRes}".split("|");
		//alert(dataPT[0]+" "+dataPT[1]);
		rowst_2.push([dataPT[0],parseInt(dataPT[1])]);
	</c:forEach>
	
	google.load('visualization', '1', {packages: ['corechart']});
	google.setOnLoadCallback(drawVisualization);
	
	function drawVisualization() {
		var tablePT = new google.visualization.DataTable();
		tablePT.addColumn('string', 'Tipo');
		tablePT.addColumn('number', 'Especies');
		tablePT.addRows(rowst_2);

        var options = {
                vAxis: {title: "Cantidad de especies", color:"#6B6B6B", logScale:"true", textStyle:{color: '#6B6B6B'}, format:'#',titleTextStyle:{bold:true}},
                hAxis: {title: "Tipo de publicador", color:"#6B6B6B", textStyle:{color: '#6B6B6B'},titleTextStyle:{bold:true}},
                seriesType: "bars",
                fontSize: "13",
				fontName: 'Open Sans',
				bar: {groupWidth:'70%'},
                colors:[ '#A8D4DC'],
                legend:{position: 'right', textStyle: {color: '#6B6B6B'}},
				areaOpacity:0,
				height:'450',
				width:'950',
				dataOpacity: 0.8,
				backgroundColor: 'none'
              };
        
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_stat_2'));
        chart.draw(tablePT, options);
	}
	
	
</script>


<script type='text/javascript'>
	
	var rowst_3=[];
	var monthTrimester = new Array();
	var numTaxons=0;
	
	<c:forEach items="${monthsTrimesterRes}" var="monthsTrimesterRes">
		var dataMT ="${monthsTrimesterRes}".split("|");
		//alert(dataMT[0]+" "+dataMT[1]);
		rowst_3.push([dataMT[0],parseInt(dataMT[1])]);
	</c:forEach>
	
	google.load('visualization', '1', {packages: ['corechart']});
	google.setOnLoadCallback(drawVisualization);
	
	function drawVisualization() {
		var tableMT = new google.visualization.DataTable();
		tableMT.addColumn('string', 'Trimester');
		tableMT.addColumn('number', 'Registros');
		tableMT.addRows(rowst_3);

        var options = {
                vAxis: {title: "Cantidad de registros", color:"#6B6B6B", logScale:"true", textStyle:{color: '#6B6B6B'}, format:'#',titleTextStyle:{bold:true}},
                hAxis: {title: "Trimestre", color:"#6B6B6B", textStyle:{color: '#6B6B6B'},titleTextStyle:{bold:true}},
                seriesType: "bars",
                fontSize: "13",
				fontName: 'Open Sans',
				bar: {groupWidth:'70%'},
                colors:[ '#CDDC88'],
                legend:{position: 'right', textStyle: {color: '#6B6B6B'}},
				areaOpacity:0,
				height:'450',
				width:'950',
				dataOpacity: 0.8,
				backgroundColor: 'none'
              };
        
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_stat_3'));
        chart.draw(tableMT, options);
	}
	
	
</script>

<script type='text/javascript'>
	
	var rowst_4=[];
	var monthAccumulative = new Array();
	var numTaxons=0;
	
	<c:forEach items="${monthsAccumulativeRes}" var="monthsAccumulativeRes">
		var dataMA ="${monthsAccumulativeRes}".split("|");
		//alert(dataMA[0]+" "+dataMA[1]);
		rowst_4.push([dataMA[0],parseInt(dataMA[1])]);
	</c:forEach>
	
	google.load('visualization', '1', {packages: ['corechart']});
	google.setOnLoadCallback(drawVisualization);
	
	function drawVisualization() {
		var tableMA = new google.visualization.DataTable();
		tableMA.addColumn('string', 'Mes');
		tableMA.addColumn('number', 'Registros');
		tableMA.addRows(rowst_4);

        var options = {
                vAxis: {title: "Cantidad de registros", color:"#6B6B6B", logScale:"true", textStyle:{color: '#6B6B6B'}, format:'#',titleTextStyle:{bold:true}},
                hAxis: {title: "Mes", color:"#6B6B6B", textStyle:{color: '#6B6B6B'},titleTextStyle:{bold:true}},
                fontSize: "13",
				fontName: 'Open Sans',
                colors:[ '#ED652D'],
                legend:{position: 'right', textStyle: {color: '#6B6B6B'}},
				areaOpacity:0,
				height:'450',
				width:'950',
				dataOpacity: 0.8,
				backgroundColor: 'none'
              };
        
        var chart = new google.visualization.LineChart(document.getElementById('chart_stat_4'));
        chart.draw(tableMA, options);
	}
	
	
</script>


<div class="subcontainer stats">

	<div><h4>Número de registros en el portal de datos por mes (acumulado)</h4>
		<div id="chart_stat_4"></div>
	</div>
	
	<div><h4>Número de registros en el portal de datos por trimestre</h4>
		<div id="chart_stat_3"></div>
	</div>
		
	<div>
		<h4>Registros biológicos por departamento</h4>
		<div id="chart_div" style=" width:720px; float:left;"></div>
	     <p><img src="${pageContext.request.contextPath}/images/legend_map.png" /></p>
	    <p><strong>Haz click sobre el departamento de tu interés para ver los registros en nuestro <a href="htttp://data.sibcolombia.net" target="_blank">Portal de datos</a></strong></p>
	   
	    <p>El tamaño y color de los círculos es proporcional al total de registros por departamento. El color es indicativo del número de registros con coordenadas geográficas</p>
	</div>

	<%--<div><h4>Número de registros por publicador en los últimos meses</h4>
		<div id="chart_stat"></div>
	</div>

	<div><h4>Número de Conjuntos de datos por publicador</h4>
		<div id="pchart"></div>
	</div> 

	<div>
		<h4>Conjuntos de datos por publicador</h4>
		<div id="chart_tree" style="width: 720px; height: 500px; float:left;"></div>
		<p><img src="${pageContext.request.contextPath}/images/treemap_guide.png" /></p>
		<p><strong>Haz click sobre un publicador para ver los conjuntos de datos que ha publicado</strong></p>
		<p>El color más oscuro indica mayor cantidad de registros georeferenciados, y el tamaño del cuadro muestra la proporción de registros comparados con los demas publicadores, o publicaciones </p>
	</div>--%>
	
	<div>
		<h4>Especies por departamento</h4>
		<div id="chart_div_1" style=" width:720px; float:left;"></div>
	     <p><img src="${pageContext.request.contextPath}/images/legend_map_2.png" /></p>
	    <p><strong>Haz click sobre el departamento de tu interés para ver las especies en nuestro <a href="htttp://data.sibcolombia.net" target="_blank">Portal de datos</a></strong></p>
	    <p>El tamaño y el color de los círculos son proporcional al total de especies por departamento.</p>
	</div>
	
	<div><h4>Número de registros en el portal de datos por grupo biológico</h4>
		<div id="chart_stat_1"></div>
	</div>
	
	<div><h4>Número de especies en el portal de datos por tipo de publicador</h4>
		<div id="chart_stat_2"></div>
	</div>
	
</div>