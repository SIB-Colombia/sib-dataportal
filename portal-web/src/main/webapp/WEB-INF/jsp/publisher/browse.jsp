<%@ include file="/common/taglibssibcolombia.jsp"%>

<a class="g3 faq" href="#" title="Explorar publicadores">? </a>

<div id="twopartheader">	
	<h2>
		<spring:message code="publisher.list.main.title"/>
	</h2>
</div>

<c:choose>
	<c:when test="${selectedChar!=48}">
		<h2 id="selectedChar">${selectedChar}</h2>
	</c:when>
	<c:otherwise><br/></c:otherwise>
</c:choose>
<div id="boxcontent">  
	
<fmt:setLocale value="en_US"/>
<display:table name="dataProviders" export="false" class="statistics" id="dataProvider" cellspacing="0">
   <display:column titleKey="dataset.providers.list.logo">
  		<c:if test="${dataProvider.logoUrl!=null}">
  			<gbiftag:scaleImage imageUrl="${dataProvider.logoUrl}" maxWidth="200" maxHeight="70" addLink="false" imgClass="logo"/>
  		</c:if>
  </display:column>
  	 
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
</div>



<script type="text/javascript" charset="utf-8">
console.log("${dataProviders}");

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

$(document).ready(function() {
    $('#dataProvider').dataTable( {
        "iDisplayLength": 100,
        "bLengthChange": false,
        "bAutoWidth": false,
        "aaSorting": [[ 1, "asc" ]],
        "oLanguage": {
            "sEmptyTable": '<spring:message code="dataset.list.semptytable"/>',
            "sZeroRecords":'<spring:message code="dataset.list.szerorecords"/> ',
            "sInfo": '<spring:message code="publisher.list.sinfo" arguments="_START_,_END_,_TOTAL_"/>',
            "sInfoEmpty": '<spring:message code="publisher.list.sinfoempty"/>',
            "sInfoFiltered": '<spring:message code="publisher.list.sinfofiltered" arguments="_MAX_"/> ',
            "sSearch": '<spring:message code="dataset.list.ssearch"/>',
            "oPaginate": {
                "sNext": '<spring:message code="dataset.list.snext"/>',
                "sPrevious": '<spring:message code="dataset.list.sprevious" />'
            }
        }, 
        "aoColumns": [ { "bSortable": false },
                       null,
                      { "sType": "num-html" },
                      { "sType": "num-html" }
                  ],
         "fnDrawCallback": function(){
	      	  if(this.fnSettings().fnRecordsDisplay()<=$('#dataProvider tr').length){
	    		  $('#dataProvider_paginate').hide();
	    	  }else{
	    		  $('#dataProvider_paginate').show();  
	    	  } 
	    	}
    } );
} );
</script>