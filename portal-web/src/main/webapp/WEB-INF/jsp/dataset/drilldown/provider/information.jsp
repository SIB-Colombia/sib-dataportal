<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>

<script type='text/javascript'>
 //alert("${dataProvider.uuid}");
 var url="http://gbrds.gbif.org/registry/organisation/"+"${dataProvider.uuid}"+".json";
 
 function getObjects(obj, key, val) {
	    var objects = [];
	    for (var i in obj) {
	        if (!obj.hasOwnProperty(i)) continue;
	        if (typeof obj[i] == 'object') {
	            objects = objects.concat(getObjects(obj[i], key, val));
	        } else if (i == key && obj[key] == val) {
	            objects.push(obj);
	        }
	    }
	    return objects;
	}
 
 var url3="";
 //$(function(){
	 var url1="http://gbrds.gbif.org/registry/organisation/"+"${dataProvider.uuid}"+".json";
	 var url2="http://gbrds.gbif.org/registry/organisation/"+"${dataProvider.uuid}"+".json?op=contacts"; 
	 
	 $.ajax({
		    url: url1,
		    dataType: 'jsonp',
		    success: function(data){
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
		    	
		    	var tel="${dataProvider.telephone}";
		    	if((data.primaryContactPhone!=undefined)&&(data.primaryContactPhone.length!=0)){
		    		$('#telph').append(data.primaryContactPhone); 
		    	}else if(tel.length!=0){
		    		$('#telph').append(tel);
		    	}else {
		    		$('#telph').remove();
		    	}
		    }
		});
	 
	 var url2=encodeURI("http://gbrds.gbif.org/registry/organisation/15b278a8-1356-4f7b-ba32-3c733c3d0aac.json?op=contacts");
	 //alert(encodeURI(url2));
	 var url3=encodeURI(url2);
	 function jsonpCallback(response){
		 alert(JSON.stringify(response));
		 alert("!");
	 }
	 
	 $.ajax({ 
		 url: encodeURI("http://gbrds.gbif.org/registry/organisation/15b278a8-1356-4f7b-ba32-3c733c3d0aac.json?op=contacts"),
		 jsonp: false,
		 dataType: 'jsonp', 
		 type: 'GET',
		 cache: 'true',
		 success: jsonpCallback
	 });
	 	//complete: function(data){alert(url2); alert(JSON.stringify(data));}});
		
		 
	 
	//});
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

