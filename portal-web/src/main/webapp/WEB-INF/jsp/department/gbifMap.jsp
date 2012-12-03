<%@ include file="/common/taglibs.jsp"%>
<script src="${pageContext.request.contextPath}/javascript/mapserver.js" type="text/javascript" language="javascript"></script>
<c:set var="minMapLat" scope="request">${minMapLat==null ? -90 : minMapLat}</c:set>
<c:set var="maxMapLat" scope="request">${maxMapLat==null ? 90 : maxMapLat}</c:set>
<c:set var="minMapLong" scope="request">${minMapLong==null ? -180 : minMapLong}</c:set>
<c:set var="maxMapLong" scope="request">${maxMapLong==null ? 180 : maxMapLong}</c:set>	
<c:set var="zoom" scope="request">${zoom==null ? 1 : zoom}</c:set> <!-- department -->
<c:set var="extent" scope="request">${extent==null ? param.extent : extent}</c:set>
<c:set var="mapWidth" scope="request">${mapWidth==null ? 721 : mapWidth}</c:set>
<c:set var="mapHeight" scope="request">${mapHeight==null ? 362 : mapHeight}</c:set>

<script type="text/javascript">
<%
	String ua = (String) request.getHeader( "User-Agent" );
	boolean isMSIE = ( ua != null && ua.indexOf( "MSIE" ) != -1 );
	pageContext.setAttribute("isMSIE", isMSIE);
%>
<c:if test="${isMSIE}">isIE=true;</c:if>

<c:if test='${zoom ==2}'>
	boxWidth = 80;
	boxHeight = 40;    
</c:if>	

<c:if test='${zoom ==3}'>
	boxWidth = 180;
	boxHeight = 90;    
</c:if>	

<c:if test='${zoom ==4}'>
	boxWidth = 360;
	boxHeight = 180;    
</c:if>	
	
	minMapLat = ${minMapLat};
	maxMapLat = ${maxMapLat};
	minMapLong = ${minMapLong};
	maxMapLong = ${maxMapLong};		
	zoom = ${zoom};

<c:if test='${zoom>4}'>
	boxWidth = 72;
	boxHeight = 36;    
	snapHalf=false;        
</c:if>	

<c:if test='${zoom == 5}'>
	boxWidthInDegrees=2;
	boxHeightInDegrees=1;
</c:if>

<c:if test='${zoom == 6}'>
	nudge = 1;
	boxWidth = 36;
	boxWidthInDegrees=0.1;
	boxHeightInDegrees=0.1;
</c:if>

	var extraParams="${extraParams}";
	var unescapeMapLayerUrl="${unEscapedMapLayerUrl}";

	document.onmousemove = mouseMove;
	
	//Redirects to filter search with bounding box
	function redirectToCell (minX, minY, maxX, maxY){
		document.location.href = "${pageContext.request.contextPath}/occurrences/boundingBoxWithCriteria.htm?"
				+extraParams				
				+"&minX="+minX
				+"&minY="+minY
				+"&maxX="+maxX
				+"&maxY="+maxY;
	}
</script>
<c:choose>
<c:when test="${pointsTotal==0}">
<h7 id="noGeoreferencedPoints"><spring:message code="maps.no.georeferenced.points"/> ${entityName}</h7>
</c:when>
<c:otherwise>

<table class="gbifMap">
	<tr class="top">
		<td class="first"/>
		<td class="labelLeft">${minMapLong}</td>
		<td class="up">
			<c:if test='${maxMapLat < 90}'>
				<a href="javascript:nudgeUp()" 
					<c:if test="${zoom<6}">	title="<spring:message code="maps.move.fivedegree.north"/>"</c:if>
					<c:if test="${zoom==6}">	title="<spring:message code="maps.move.onedegree.north"/>"</c:if>					
					><img src="${pageContext.request.contextPath}/<spring:theme code="shared.root"/>/images/icons/up.gif"/></a>
			</c:if>
		</td>
		<td align="right" class="labelRight">${maxMapLong}</td>
		<td class="zoom">
			<c:if test='${zoom>1}'>
				<a href="javascript:zoomOut()"  title="Zoom out"><img src="${pageContext.request.contextPath}/<spring:theme code="shared.root"/>/images/icons/zoom_out.png"/></a>
		    </c:if>
		</td>	
		<td class="key"/>
	</tr>
	<tr class="firstRow">
		<td class="labelTopLeft">${maxMapLat}</td>
		<td class="map" colspan="3" rowspan="3" align="center" valign="middle">
			<c:if test="${pointsTotal==0}">
				<h5 id="noGeoreferencedPoints"><spring:message code="maps.no.georeferenced.points"/> ${entityName}</h5>
			</c:if>	
			<img id="overviewMap" 
					class="overviewMap" 
					alt="${mapTitle} occurrences distribution map" 
					name="${mapTitle} occurrences distribution map" 
					title="${mapTitle} occurrences distribution map" 
					<c:if test="${zoom==1}">
					src="${geoServerUrl}?request=GetMap&bgcolor=0x2ca8b5&styles=,,&layers=gbif:country_fill,gbif:tabDensityLayer,gbif:country_borders&srs=EPSG:4326&filter=()(<Filter><PropertyIsEqualTo><PropertyName>url</PropertyName><Literal><![CDATA[${mapLayerUrl}]]></Literal></PropertyIsEqualTo></Filter>)()&width=${mapWidth}&height=${mapHeight}&Format=image/png&bbox=${minMapLong},${minMapLat},${maxMapLong},${maxMapLat}"
					</c:if>
					<%-- Ignoring bluemarble layer
					<c:if test="${zoom>1 && zoom<6}">
					src="${geoServerUrl}?request=GetMap&bgcolor=0x2ca8b5&styles=,,,&layers=gbif:country_fill,gbif:tabDensityLayer,gbif:country_borders,gbif:country_names&srs=EPSG:4326&filter=()(<Filter><PropertyIsEqualTo><PropertyName>url</PropertyName><Literal><![CDATA[${mapLayerUrl}]]></Literal></PropertyIsEqualTo></Filter>)()()&width=${mapWidth}&height=${mapHeight}&Format=image/png&bbox=${minMapLong},${minMapLat},${maxMapLong},${maxMapLat}"
					</c:if>		
					<c:if test="${zoom==6}">
					src="${geoServerUrl}?request=GetMap&bgcolor=0x2ca8b5&styles=,,country_borders_black,country_names_blue&layers=bluemarble,gbif:tabDensityLayer,gbif:country_borders,gbif:country_names&srs=EPSG:4326&filter=()(<Filter><PropertyIsEqualTo><PropertyName>url</PropertyName><Literal><![CDATA[${mapLayerUrl}]]></Literal></PropertyIsEqualTo></Filter>)()()&width=${mapWidth}&height=${mapHeight}&Format=image/png&bbox=${minMapLong},${minMapLat},${maxMapLong},${maxMapLat}"
					</c:if>	 --%> 
					<c:if test="${zoom>1 && zoom<=6}">
					src="${geoServerUrl}?request=GetMap&bgcolor=0x2ca8b5&styles=,,,&layers=gbif:country_fill,gbif:tabDensityLayer,gbif:country_borders,gbif:country_names&srs=EPSG:4326&filter=()(<Filter><PropertyIsEqualTo><PropertyName>url</PropertyName><Literal><![CDATA[${mapLayerUrl}]]></Literal></PropertyIsEqualTo></Filter>)()()&width=${mapWidth}&height=${mapHeight}&Format=image/png&bbox=${minMapLong},${minMapLat},${maxMapLong},${maxMapLat}"
					</c:if>
					<%-- src="${mapServerUrl}?dtype=box&imgonly=1&path=${mapLayerUrl}&extent=${extent}&mode=browse&refresh=Refresh&layer=countryborders<c:if test="${zoom>1}">&layer=countrylabels</c:if><c:if test="${zoom==6}">&degree=0.1</c:if>" --%> 
					<c:choose>
						<c:when test="${pointsTotal>0}">
								onMouseOver='javascript:capture=true;' 
								onMouseOut='javascript:capture=false;'
							<c:choose>
								<c:when test='${zoom == 6}'>
									onclick="javascript:occurrenceSearch();"
								</c:when> 
								<c:otherwise>
									onclick="javascript:selectBox();"
								</c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
			/>
		</td>
		<td class="labelTopRight">${maxMapLat}</td>
		<td class="key"/>
	</tr>
	<tr>
		<td class="left">
			<c:if test='${minMapLong > -180}'>
				<a href="javascript:nudgeLeft()"  
					<c:if test="${zoom<6}">	title="<spring:message code="maps.move.fivedegree.west"/>"</c:if>
					<c:if test="${zoom==6}">	title="<spring:message code="maps.move.onedegree.west"/>"</c:if>					
				><img src="${pageContext.request.contextPath}/<spring:theme code="shared.root"/>/images/icons/left.gif"/></a>
			</c:if>
		</td>				
		<td class="right">
			<c:if test='${maxMapLong < 180}'>
				<a href="javascript:nudgeRight()"  
					<c:if test="${zoom<6}">	title="<spring:message code="maps.move.fivedegree.east"/>"</c:if>
					<c:if test="${zoom==6}">	title="<spring:message code="maps.move.onedegree.east"/>"</c:if>					
				><img src="${pageContext.request.contextPath}/<spring:theme code="shared.root"/>/images/icons/right.gif"/></a>
			</c:if>
		</td>
		<td>
			<table class="mapKey">
				<c:choose>
					<c:when test='${zoom == 6}'>
						<caption><spring:message code="maps.count.pointone.cell"/></caption>
					</c:when>
				    <c:otherwise>
						<caption><spring:message code="maps.count.onedeg.cell"/></caption>
				    </c:otherwise>
				</c:choose>
				<tr><td class="key" bgcolor="#ffff00"/><td class="detail">1 - 9</td></tr>
				<tr><td class="key" bgcolor="#ffcc00"/><td class="detail">10 - 99</td></tr>
				<tr><td class="key" bgcolor="#ff9900"/><td class="detail">100 - 999</td></tr>
				<tr><td class="key" bgcolor="#ff6600"/><td class="detail">1000 - 9999</td></tr>
				<tr><td class="key" bgcolor="#ff3300"/><td class="detail">10000 - 99999</td></tr>
				<tr><td class="key" bgcolor="#cc0000"/><td class="detail">100000+</td></tr>
			</table>
			<br/><br/>
			<ul id="markerPosition">
				<li id="northCoordinate">90</li>
				<li id="westCoordinate">-180</li>
				<li id="eastCoordinate">180</li>
				<li id="southCoordinate">-90</li>
			</ul>			
		</td>				
	</tr>
	<tr  class="lastRow">
		<td class="labelBottomLeft">${minMapLat}</td>
		<td class="labelBottomRight">${minMapLat}</td>
		<td class="key"/>
	</tr>
	<tr class="bottom">
		<td class="first"/>
		<td class="labelLeft">${minMapLong}</td>
		<td class="down">
			<c:if test='${minMapLat>-90}'>
				<a href="javascript:nudgeDown()"  
					<c:if test="${zoom<6}">	title="<spring:message code="maps.move.fivedegree.south"/>"</c:if>
					<c:if test="${zoom==6}">	title="<spring:message code="maps.move.onedegree.south"/>"</c:if>					
				><img src="${pageContext.request.contextPath}/<spring:theme code="shared.root"/>/images/icons/down.gif"/></a>
			</c:if>
		</td>
		<td class="labelRight">${maxMapLong}</td>
		<td class="last"/>
	</tr>
	
</table>
</c:otherwise>
</c:choose>


<div id="mapSelector" 
	class="zoom${zoom}"
	onMouseOver='javascript:capture=true;' 
	onMouseOut='javascript:capture=false;'
	<c:choose>
		<c:when test='${zoom == 6}'>
			onclick="javascript:occurrenceSearch();"
		</c:when> 
		<c:otherwise>
			onclick="javascript:selectBox();"
		</c:otherwise>
	</c:choose>
	>
	&nbsp;
</div>