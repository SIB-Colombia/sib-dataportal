<%@ include file="/common/taglibssibcolombia.jsp"%>

<div id="twopartheader">	
<h2><spring:message code="dataset.list.main.title"/>
	<!-- tweet-button-->
	<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/conjuntos/?utm_source=datasets&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es" data-text="Conjuntos de datos" >Twittear</a>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
	js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
	</script>
</h2>
	<gbif:alphabetLink rootUrl="/datasets/browse/" selected="${selectedChar}" listClass="flatlist" letters="${alphabet}" messageSource="${messageSource}"/>
</div>
<c:choose><c:when test="${selectedChar!=48}"><h2 id="selectedChar">${selectedChar}</h2></c:when><c:otherwise><br/></c:otherwise></c:choose>
	<c:choose>
	<c:when test="${fn:length(alphabet)==0}">Currently no data resources/providers within the system.</c:when>
	<c:otherwise>
	

<% /* <display:table name="resourceNetworks" export="false" class="statistics" id="resourceNetwork">
  <display:column titleKey="dataset.networks.list.title" class="name">
  	<a href="${pageContext.request.contextPath}/datasets/network/${resourceNetwork.key}"><gbiftag:resourceNetworkPrint resourceNetwork="${resourceNetwork}"/></a>
  </display:column>	  
  <display:column titleKey="dataset.list.occurrence.count" class="singlecount">
  	<fmt:formatNumber value="${resourceNetwork.occurrenceCount}" pattern="###,###"/><c:if test="${resourceNetwork.occurrenceCount==null}">0</c:if>
  	(<fmt:formatNumber value="${resourceNetwork.occurrenceCoordinateCount}" pattern="###,###"/><c:if test="${resourceNetwork.occurrenceCoordinateCount==null}">0</c:if>)
	</display:column>	  
  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
</display:table>*/
%>
<fmt:setLocale value="en_US"/>
<!-- 
<display:table name="dataProviders" export="false" class="statistics sortable" id="dataProvider" cellspacing="0">
  <display:column titleKey="dataset.providers.list.title" class="name">
  	<a href="${pageContext.request.contextPath}/conjuntos/provider/${dataProvider.key}">${dataProvider.name}</a>
  	<c:if test='${dataProvider.isoCountryCode!=null}'>
  	<p class="resultsDetails">
			<a href="${pageContext.request.contextPath}/paises/${dataProvider.isoCountryCode}"><spring:message code="country.${dataProvider.isoCountryCode}" text=""/></a>
		</p>  				
		</c:if>
  </display:column>	  
  <display:column titleKey="dataset.list.occurrence.count.nongeoreferenced" class="singlecount">
    <c:choose>
      <c:when test="${dataProvider.occurrenceCount>0}">
      	<a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="25" predicate="0" value="${dataProvider.key}" index="0"/>"><fmt:formatNumber value="${dataProvider.occurrenceCount}" pattern="###,###"/></a>
      </c:when>
	  <c:otherwise>
	    <p class="notApplicable">
		  	<c:choose>
		  	  <c:when test="${dataProvider.conceptCount>0}">
		  	  	<spring:message code="dataset.not.applicable"/>
		  	  </c:when>
		  	  <c:otherwise>
		  	  	<spring:message code="dataset.not.yet.indexed"/>
		  	  </c:otherwise>
		  	</c:choose>
		 </p>
	  </c:otherwise>
	</c:choose>
	</display:column>
	<display:column titleKey="dataset.list.occurrence.count.georeferenced" class="singlecount">
    <c:choose>
      <c:when test="${dataProvider.occurrenceCount>0}">
      	<c:choose>
      	  <c:when test="${dataProvider.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="25" predicate="0" value="${dataProvider.key}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"><fmt:formatNumber value="${dataProvider.occurrenceCoordinateCount}" pattern="###,###"/></a></c:when>
      	  <c:otherwise>0</c:otherwise>
      	</c:choose>
      </c:when>
	  <c:otherwise>
	    <p class="notApplicable">
		  	<c:choose>
		  	  <c:when test="${dataProvider.conceptCount>0}">
		  	  	<spring:message code="dataset.not.applicable"/>
		  	  </c:when>
		  	  <c:otherwise>
		  	  	<spring:message code="dataset.not.yet.indexed"/>
		  	  </c:otherwise>
		  	</c:choose>
		 </p>
	  </c:otherwise>
	</c:choose>
	</display:column>  
  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
</display:table>
-->

<display:table name="dataResources" export="false" class="statistics" id="dataResource" cellspacing="0">
  <display:column sortProperty="dataResource.name" titleKey="dataset.resources.list.title" class="name">
  	<a href="${pageContext.request.contextPath}/conjuntos/resource/${dataResource.key}">${dataResource.name}</a>
  	<p class="resultsDetails"><a href="${pageContext.request.contextPath}/conjuntos/provider/${dataResource.dataProviderKey}">${dataResource.dataProviderName}</a></p>
  </display:column>
  <display:column titleKey="dataset.list.occurrence.count.nongeoreferenced" class="bigcount">
    <c:choose>
      <c:when test="${dataResource.occurrenceCount>0}">
  	    <a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="24" predicate="0" value="${dataResource.key}" index="0"/>"><fmt:formatNumber value="${dataResource.occurrenceCount}" pattern="###,###"/></a>
		  </c:when>
		  <c:otherwise>
		    <p class="notApplicable">
			  	<c:choose>
			  	  <c:when test="${dataResource.conceptCount>0}">
			  	  	<spring:message code="dataset.not.applicable"/>
			  	  </c:when>
			  	  <c:otherwise>
			  	  	<spring:message code="dataset.not.yet.indexed"/>
			  	  </c:otherwise>
			  	</c:choose>
			 </p>
		  </c:otherwise>
		</c:choose>
  </display:column>
  <display:column titleKey="dataset.list.occurrence.count.georeferenced" class="bigcount">
    <c:choose>
      <c:when test="${dataResource.occurrenceCount>0}">
      	<c:choose>
      	  <c:when test="${dataResource.occurrenceCoordinateCount>0}"><a href="${pageContext.request.contextPath}/busqueda/search.htm?<gbif:criterion subject="24" predicate="0" value="${dataResource.key}" index="0"/>&<gbif:criterion subject="28" predicate="0" value="0" index="1"/>"><fmt:formatNumber value="${dataResource.occurrenceCoordinateCount}" pattern="###,###"/></a></c:when>
      	  <c:otherwise>0</c:otherwise>
      	</c:choose>
		  </c:when>
		  <c:otherwise>
		    <p class="notApplicable">
			  	<c:choose>
			  	  <c:when test="${dataResource.conceptCount>0}">
			  	  	<spring:message code="dataset.not.applicable"/>
			  	  </c:when>
			  	  <c:otherwise>
			  	  	<spring:message code="dataset.not.yet.indexed"/>
			  	  </c:otherwise>
			  	</c:choose>
			 </p>
		  </c:otherwise>
		</c:choose>
  </display:column> 
  <display:column titleKey="dataset.list.taxonconcept.count" class="count">
     <c:if test="${dataResource.conceptCount>0}">
  	 	<fmt:formatNumber value="${dataResource.conceptCount}" pattern="###,###"/>
  	 </c:if> 
  </display:column>
  <display:column titleKey="dataset.speciesCount" class="count">
     <c:if test="${dataResource.speciesCount>0}">
		 <fmt:formatNumber value="${dataResource.speciesCount}" pattern="###,###"/> 
  	 </c:if> 
  </display:column>
  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
</display:table>

	</c:otherwise>
</c:choose>

<script type="text/javascript" charset="utf-8"> 
$(document).ready(function() {
    $('#dataResource').dataTable( {
        "iDisplayLength": 20,
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
        }, 
        "aoColumnDefs": [
            { 'bSortable': true, 'aTargets': [ 0 ] }
        ]
    } );
} );
</script>