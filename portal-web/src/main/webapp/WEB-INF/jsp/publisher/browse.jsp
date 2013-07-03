<%@ include file="/common/taglibssibcolombia.jsp"%>
<script type="text/javascript">
	$(function(){
		if(($("#chosen").text()).length>1){
		var len="${totalOcurrenceCount}".length;
		var lenc="${totalOcurrenceCoordinateCount}".length;
		var numb="";
		var numbc="";
		var lent=$('#dataProvider >tbody >tr').length;
		if(len>3){
		numb="${totalOcurrenceCount}".substring(0,len-3)+","+"${totalOcurrenceCount}".substring(len-3,len);
		}else{
			numb="${totalOcurrenceCount}";
		}
		if(lenc>3){
			numbc="${totalOcurrenceCoordinateCount}".substring(0,len-3)+","+"${totalOcurrenceCoordinateCount}".substring(len-3,len);
			}else{
				numbc="${totalOcurrenceCoordinateCount}";
			}
		if(lent%2==1){
			$("#dataProvider").find('tfoot')
	    	.append($('<tr class="even">')
	     	   .append($('<td><b>Total</b></td><td><b>'+numb+'</b></td><td><b>'+numbc+'</b></td>')
	     	   )
	    	);
		}else{
			$("#dataProvider").find('tfoot')
	    	.append($('<tr class="odd">')
	     	   .append($('<td><b>Total</b></td><td><b>'+numb+'</b></td><td><b>'+numbc+'</b></td>')
	     	   )
	    	);
		}
	}
	});
</script>
<div id="twopartheader">	
<h2><spring:message code="publisher.list.main.title"/>
	<!-- tweet-button-->
	<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/publicadores/?utm_source=datasets&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es" data-text="Publicadores" >Twittear</a>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
	js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
	</script>
</h2>
	<gbif:alphabetLink rootUrl="/publicadores/browse/" selected="${selectedChar}" listClass="flatlist" letters="${alphabet}" messageSource="${messageSource}"/>
</div>
<c:choose><c:when test="${selectedChar!=48}"><h2 id="selectedChar">${selectedChar}</h2></c:when><c:otherwise><br/></c:otherwise></c:choose>
	<c:choose>
	<c:when test="${fn:length(alphabet)==0}">Currently no data resources/providers within the system.</c:when>
	<c:otherwise>
	


<fmt:setLocale value="en_US"/>
<display:table name="dataProviders" export="false" class="statistics sortable" id="dataProvider" cellspacing="0">
  <display:column titleKey="dataset.providers.list.title" class="name">
  	<a href="${pageContext.request.contextPath}/publicadores/provider/${dataProvider.key}">${dataProvider.name}</a>
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
	<display:footer> </display:footer>
  <display:setProperty name="basic.msg.empty_list"> </display:setProperty>	  
  <display:setProperty name="basic.empty.showtable">false</display:setProperty>	  
</display:table>



	</c:otherwise>
</c:choose>