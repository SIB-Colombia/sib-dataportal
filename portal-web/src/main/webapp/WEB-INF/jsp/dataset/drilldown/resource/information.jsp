<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>

<script type='text/javascript'>
 

 $(function(){
	 var url1="http://gbrds.gbif.org/registry/resource/"+"${dataResource.gbifRUuid}"+".json";
	  
	 
	 $.ajax({
		    url: url1,
		    dataType: 'jsonp',
		    contentType: "application/json; charset=iso-8859-1",
		    success: function(data){
		    	alert(data.description);
		    	alert("${dataResource.gbifRUuid}");
		    	/*
		    	url3 = data.homepageURL;
		    	$('#webSite').append(url3);
		    	
		    	var name="${dataProvider.name}";
		    	if((data.name!=undefined)&&(data.name.length!=0)){
		    		$('#name').append(data.name);
		    	}else if(name.length!=0){
		    		$('#name').append(name);
		    	}else {
		    		$('#name').remove();
		    	}
		    	
		    	var webUrl="${dataProvider.websiteUrl}";
		    	if((data.homepageURL!=undefined)&&(data.homepageURL.length!=0)){
		    		$('#webSiteUrl').append('<a href="'+data.homepageURL+'">'+data.homepageURL+'</a>'); 
		    	}else if(webUrl.length!=0){
		    		$('#webSiteUrl').append('<a href="'+webUrl+'">'+webUrl+'</a>');
		    	}else {
		    		$('#webSiteUrl').remove();
		    	}
		    	
		    	var nodeApprover="${dataProvider.gbifApprover}";
		    	if((data.nodeName!=undefined)&&(data.nodeName.length!=0)){
		    		$('#nodeApprover').append(data.nodeName); 
		    	}else if(nodeApprover.length!=0){
		    		$('#nodeApprover').append(nodeApprover);
		    	}else {
		    		$('#nodeApprover').remove();
		    	}
		    	
		    	var descrp="${dataProvider.description}";
		    	if((data.description!=undefined)&&(data.description.length!=0)){
		    		$('#descr').append(data.description); 
		    	}else if(descrp.length!=0){
		    		$('#descr').append(descrp);
		    	}else {
		    		$('#descr').remove();
		    	}
		    	
		    	var addr="${dataProvider.address}";
		    	if((data.primaryContactAddress!=undefined)&&(data.primaryContactAddress.length!=0)){
		    		$('#addrs').append(data.primaryContactAddress); 
		    	}else if(addr.length!=0){
		    		$('#addrs').append(addr);
		    	}else {
		    		$('#addrs').remove();
		    	}
		    	
		    	var addr="${dataProvider.address}";
		    	if((data.primaryContactAddress!=undefined)&&(data.primaryContactAddress.length!=0)){
		    		$('#addrs').append(data.primaryContactAddress); 
		    	}else if(addr.length!=0){
		    		$('#addrs').append(addr);
		    	}else {
		    		$('#addrs').remove();
		    	}
		    	*/
		    	/*
		    	var mail="${dataProvider.email}";
		    	if((data.primaryContactEmail!=undefined)&&(data.primaryContactEmail.length!=0)){
		    		$('#eMail').append(data.primaryContactEmail); 
		    		alert("1");
		    	}else if(addr.length!=0){
		    		$('#eMail').append(mail);
		    		alert("2");
		    	}else {
		    		$('#eMail').remove();
		    	}
		    	*/
		    	
		    	/*
		    	var tel="${dataProvider.telephone}";
		    	if((data.primaryContactPhone!=undefined)&&(data.primaryContactPhone.length!=0)){
		    		$('#telph').append(data.primaryContactPhone); 
		    	}else if(tel.length!=0){
		    		$('#telph').append(tel);
		    	}else {
		    		$('#telph').remove();
		    	}
		    	*/
		    }
		});
	 

		 
	});
</script>
<fieldset>
<c:if test="${not empty dataResource.name}"><p><label><spring:message code="name"/>:</label>${dataResource.name}</p></c:if>
<c:if test="${not empty dataResource.websiteUrl}"><p><label><spring:message code="website"/>:</label><a href="<c:if test="${fn:length(dataResource.websiteUrl)>6 && !fn:startsWith(dataResource.websiteUrl, 'http://')}">http://</c:if>${dataResource.websiteUrl}">${dataResource.websiteUrl}</a></p></c:if>
<c:if test="${not empty dataResource.description}"><p><label><spring:message code="description"/>:</label>
<table border="0" cellpadding="0" cellspacing="0"><tr><td>
<gbif:formatText content="${dataResource.description}"/>
</td></tr></table>
</p></c:if>
<c:if test="${not empty dataResource.rights}"><p><label><spring:message code="rights"/>:</label><gbif:formatText content="${dataResource.rights}"/></p></c:if>

<%-- 
<c:if test="${not empty dataResource.citation}"><p><label for="description"><spring:message code="citation"/>:</label>${dataResource.citation}</p></c:if>
<c:if test="${not empty citationText}"><p><label for="description"><spring:message code="how.to.cite"/>:</label>${citationText}</p></c:if>
--%> 
 
<c:set var="currentDate"><gbif:currentDate/></c:set>
<c:set var="dataResourceLink"><a href="${urlBase}/datasets/resource/${dataResource.key}">${urlBase}/datasets/resource/${dataResource.key}</a></c:set>
<c:choose>
 <c:when test="${dataResource.overrideCitation}">
    <c:if test="${not empty dataResource.citation}">
		<p><label for="citation"><spring:message code="citation.supplied"/>:</label>${dataResource.citation}</p>
	</c:if>
	<p><label for="citation"><spring:message code="how.to.cite"/>:</label>${dataResource.dataProviderName}, ${dataResource.name} <spring:message code="citation.entry" arguments="${dataResourceLink}%%%${currentDate}" argumentSeparator="%%%"/></p> 
 </c:when>
 <c:when test="${fn:length(dataResource.citation)==0}">
	<p><label for="citation"><spring:message code="how.to.cite"/>:</label>${dataResource.dataProviderName}, ${dataResource.name} <spring:message code="citation.entry" arguments="${dataResourceLink}%%%${currentDate}" argumentSeparator="%%%"/></p>
 </c:when>
 <c:otherwise>
	<p><label for="citation"><spring:message code="how.to.cite"/>:</label>${dataResource.citation} <spring:message code="citation.entry" arguments="${dataResourceLink}%%%${currentDate}" argumentSeparator="%%%"/></p>
 </c:otherwise> 
</c:choose>


<c:if test="${not empty dataResource.basisOfRecord}"><p><label for="basisOfRecord"><spring:message code="basis.of.record"/>:</label><spring:message code="basis.of.record.${dataResource.basisOfRecord}" text="${dataResource.basisOfRecord}"/></p></c:if>
<c:if test="${not empty dataResource.scopeCountryCode}"><p><label for="scopeCountry"><spring:message code="scope.country" text=""/>:</label><a href="${pageContext.request.contextPath}/countries/${dataResource.scopeCountryCode}"><spring:message code="country.${dataResource.scopeCountryCode}" text=""/></a></p></c:if>
<c:if test="${not empty dataResource.scopeContinentCode}"><p><label for="scopeContinentCode"><spring:message code="scope.continent" text=""/>:</label><spring:message code="continent.${dataResource.scopeContinentCode}" text=""/></p></c:if>
<c:if test="${not empty dataResource.rootTaxonRank && not empty dataResource.rootTaxonName}"><p><label for="taxonScope"><spring:message code="scope.taxonomic"/>:</label>${dataResource.rootTaxonRank}: ${dataResource.rootTaxonName}</p></c:if>
<c:forEach items="${resourceAccessPoints}" var="resourceAccessPoint">
	<p><label><spring:message code="dataset.accessPointUrl"/>:</label><a href="${resourceAccessPoint.url}">${resourceAccessPoint.url}</a></p>
</c:forEach>
<c:if test="${not empty dataResource.created}"><p><label><spring:message code="date.added"/>:</label><fmt:formatDate value="${dataResource.created}"/></p></c:if>	
<c:if test="${not empty dataResource.modified}"><p><label><spring:message code="last.modified"/>:</label><fmt:formatDate value="${dataResource.modified}"/></p></c:if>	
</fieldset>
  