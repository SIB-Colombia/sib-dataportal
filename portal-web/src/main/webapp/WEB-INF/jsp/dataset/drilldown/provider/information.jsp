<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>

<script type='text/javascript'>
 var url='http://gbrds.gbif.org/registry/organisation/'+'${dataProvider.uuid}'+'.json';

 $(function(){
	 var url1='http://gbrds.gbif.org/registry/organisation/'+'${dataProvider.uuid}'+'.json';
	 var url2='http://gbrds.gbif.org/registry/organisation/'+'${dataProvider.uuid}'+'.json?op=contacts'; 
	 
	 $.ajax({
		    url: url1,
		    dataType: 'jsonp',
		    success: function(data){
		    	url3 = data.homepageURL;
		    	$('#webSite').append(url3);
		    	
		    	
		    	//var name='${dataProvider.name}';
		    	if((data.name!=undefined)&&(data.name.length!=0)){
		    		$('#name').append(data.name.replace(/'/g, "&apos;").replace(/"/g, "&quot;"));
		    	}else if(name.length!=0){
		    		$('#name').append('${fn:escapeXml(dataProvider.name)}');
		    	}else {
		    		$('#name').remove();
		    	}
		    	
		    	
		    	
		    	var webUrl='${fn:escapeXml(dataProvider.websiteUrl)}';
		    	if((data.homepageURL!=undefined)&&(data.homepageURL.length!=0)){
		    		$('#webSiteUrl').append('<a href="'+data.homepageURL+'">'+data.homepageURL+'</a>'); 
		    	}else if(webUrl.length!=0){
		    		$('#webSiteUrl').append('<a href="'+webUrl+'">'+webUrl+'</a>');
		    	}else {
		    		$('#webSiteUrl').remove();
		    	}
		    	
		    	
		    	if((data.nodeName!=undefined)&&(data.nodeName.length!=0)){
		    		$('#nodeApprover').append(data.nodeName.replace(/'/g, "&apos;").replace(/"/g, "&quot;")); 
		    	}else if(nodeApprover.length!=0){
		    		$('#nodeApprover').append('${fn:escapeXml(dataProvider.gbifApprover)}');
		    	}else {
		    		$('#nodeApprover').remove();
		    	}
		    	
		    	
		    	
		    	if((data.description!=undefined)&&(data.description.length!=0)){
		    		$('#descr').append(data.description.replace(/'/g, "&apos;").replace(/"/g, "&quot;")); 
		    	}else if(descrp.length!=0){
		    		$('#descr').append('${fn:escapeXml(dataProvider.description)}');
		    	}else {
		    		$('#descr').remove();
		    	}
		    	
		    	
		    	
		    	if((data.primaryContactAddress!=undefined)&&(data.primaryContactAddress.length!=0)){
		    		$('#addrs').append(data.primaryContactAddress.replace(/'/g, "&apos;").replace(/"/g, "&quot;")); 
		    	}else if(addr.length!=0){
		    		$('#addrs').append('${fn:escapeXml(dataProvider.address)}');
		    	}else {
		    		$('#addrs').remove();
		    	}
		    	
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
		    	
		    	
		    	if((data.primaryContactPhone!=undefined)&&(data.primaryContactPhone.length!=0)){
		    		$('#telph').append(data.primaryContactPhone.replace(/'/g, "&apos;").replace(/"/g, "&quot;")); 
		    	}else if(tel.length!=0){
		    		$('#telph').append('${fn:escapeXml(dataProvider.telephone)}');
		    	}else {
		    		$('#telph').remove();
		    	}
		    },
		    error: function (xhr, ajaxOptions, thrownError) {
		    	console.log(xhr.statusText);
		    	console.log(thrownError);
		    	$('#name').append('${fn:escapeXml(dataProvider.name)}');
		    	var webUrl='${fn:escapeXml(dataProvider.websiteUrl)}';
		    	$('#webSiteUrl').append('<a href="'+webUrl+'">'+webUrl+'</a>');
		    	$('#nodeApprover').append('${fn:escapeXml(dataProvider.gbifApprover)}');
		    	$('#descr').append('${fn:escapeXml(dataProvider.description)}');
		    	$('#addrs').append('${fn:escapeXml(dataProvider.address)}');
		    	$('#telph').append('${fn:escapeXml(dataProvider.telephone)}');
		    		
		    }
		});
	 
	});
</script>

<h4><spring:message code="dataset.information"/></h4>
<fieldset>
<!--  
<c:if test="${not empty dataProvider.name}"><p><label><spring:message code="name"/>:</label>${dataProvider.name}</p></c:if>
<c:if test="${not empty dataProvider.websiteUrl}"><p><label><spring:message code="website"/>:</label><a href="${dataProvider.websiteUrl}">${dataProvider.websiteUrl}</a></p></c:if>	
<c:if test="${not empty dataProvider.gbifApprover}"><p><label><spring:message code="gbif.participant"/>:</label>${dataProvider.gbifApprover}</p></c:if>
<c:if test="${not empty dataProvider.description}"><p><label><spring:message code="description"/>:</label><gbif:formatText content="${dataProvider.description}"/></p></c:if>
<c:if test="${not empty dataProvider.address}"><p><label><spring:message code="address"/>:</label>${dataProvider.address}</p></c:if>	
<c:if test="${not empty dataProvider.isoCountryCode}"><p><label><spring:message code="country" text=""/>:</label><spring:message code="country.${dataProvider.isoCountryCode}" text=""/></p></c:if>
<c:if test="${not empty dataProvider.email}"><p><label><spring:message code="email"/>:</label><gbiftag:emailPrint email="${dataProvider.email}"/></p></c:if>	
<c:if test="${not empty dataProvider.telephone}"><p><label><spring:message code="telephone"/>:</label>${dataProvider.telephone}</p></c:if>	
<c:if test="${not empty dataProvider.created}"><p><label><spring:message code="date.added"/>:</label><fmt:formatDate value="${dataProvider.created}"/></p></c:if>	
<c:if test="${not empty dataProvider.modified}"><p><label><spring:message code="last.modified"/>:</label><fmt:formatDate value="${dataProvider.modified}"/></p></c:if>
-->


<p id="name"><label><spring:message code="name"/>:</label></p>
<p id="webSiteUrl"><label><spring:message code="website"/>:</label></p>
<p id="nodeApprover"><label><spring:message code="gbif.participant"/>:</label></p>
<p id="descr"><label><spring:message code="description"/>:</label></p>
<p id="addrs"><label><spring:message code="address"/>:</label></p>
<c:if test="${not empty dataProvider.uuid}"><p><label><spring:message code="gbif.link"/>:</label><a href="http://gbrds.gbif.org/browse/agent?uuid=${dataProvider.uuid}">http://gbrds.gbif.org/browse/agent?uuid=${dataProvider.uuid}<br></a></p></c:if>
<c:if test="${not empty dataProvider.isoCountryCode}"><p><label><spring:message code="country" text=""/>:</label><spring:message code="country.${dataProvider.isoCountryCode}" text=""/></p></c:if>
<!-- <p id="eMail"><label><spring:message code="email"/>:</label></p> -->
<c:if test="${not empty dataProvider.email}"><p><label><spring:message code="email"/>:</label><gbiftag:emailPrint email="${dataProvider.email}"/></p></c:if>
<p id="telph"><label><spring:message code="telephone"/>:</label></p>
<c:if test="${not empty dataProvider.created}"><p><label><spring:message code="date.added"/>:</label><fmt:formatDate value="${dataProvider.created}"/></p></c:if>	
<c:if test="${not empty dataProvider.modified}"><p><label><spring:message code="last.modified"/>:</label><fmt:formatDate value="${dataProvider.modified}"/></p></c:if>	
</fieldset>

