<%@ include file="/common/taglibs.jsp"%>
<div id="twopartheader">	
	<h2><spring:message code="geography.drilldown.list.resource.search"/>
		<!-- tweet-button-->
		<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/paises/?utm_source=home&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es">Twittear</a>
		<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
		js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
		</script>
	</h2>
		<c:set var="ignores"><spring:message code="country.alphabet.skips"/></c:set>
		<gbif:alphabetLink rootUrl="/countries/browse/" selected="${selectedChar}" listClass="flatlist" ignores="${ignores}" letters="${alphabet}"/>
</div>
<div class="menu_amarillo"><p>
<spring:message code="geography.list.iso.explaination"/>
</p></div>
<h2 id="selectedChar">${selectedChar}</h2>
<c:choose>
	<c:when test="${fn:length(alphabet)==0}">Currently no countries within the system.</c:when>
	<c:otherwise>
	<fmt:setLocale value="en_US"/>
	<display:table name="countries" export="false" class="statistics sortable" id="country" cellspacing="0">
	  <display:column titleKey="geography.drilldown.main.title" class="name">
		  <img src="${pageContext.request.contextPath}/images/flags/<string:lowerCase>${country.isoCountryCode}</string:lowerCase>.gif"/>&nbsp;<a href="${pageContext.request.contextPath}/countries/${country.isoCountryCode}"><gbif:capitalize><spring:message code="country.${country.isoCountryCode}"/></gbif:capitalize>
		  </a>
	  </display:column>	  
	  <display:column titleKey="dataset.list.occurrence.count.nongeoreferenced" class="countrycount">
	  	<c:if test="${country.occurrenceCount>0}"><a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>"></c:if><fmt:formatNumber value="${country.occurrenceCount}" pattern="###,###"/><c:if test="${country.occurrenceCount>0}"></a></c:if>
	  </display:column>
	  <display:column titleKey="dataset.list.occurrence.count.georeferenced" class="countrycount">
	  	<c:if test="${country.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"></c:if><fmt:formatNumber value="${country.occurrenceCoordinateCount}" pattern="###,###"/><c:if test="${country.occurrenceCoordinateCount>0}"></a></c:if>
	  </display:column>	 
	  <display:column titleKey="dataset.speciesCount" class="countrycount">
	  	<c:if test="${country.speciesCount>0}"><a href="${pageContext.request.contextPath}/busqueda/searchSpecies.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>"></c:if><fmt:formatNumber value="${country.speciesCount}" pattern="###,###"/><c:if test="${country.speciesCount>0}"></a></c:if>
  	  </display:column>
	  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
	  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
	</display:table>
	</c:otherwise>
</c:choose>

<div id="countryLinks">
<p>
<ul class="genericList">
<li><a href="${pageContext.request.contextPath}/countries/datasharing"><spring:message code="repat.title"/></a></li>
</ul>
</p>	
</div>