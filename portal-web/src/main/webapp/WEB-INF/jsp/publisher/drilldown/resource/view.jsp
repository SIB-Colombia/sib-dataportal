<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	$(function(){
	var dp=encodeURI('${dataResource.name}');	
	var dpn='${dataResource.name}';
	if(dpn.length>80){
		dpn=dpn.substring(0,80)+"...";
	}
	var rot='datasets/resource/'+'${dataResource.key}';
	var urlt="http://data.sibcolombia.net/"+rot+"?utm_source="+dp+"&utm_medium=twitter&utm_campaign=impacto_redes";
	$(".twitter-share-button").attr("data-url", urlt);
	$(".twitter-share-button").attr("data-text", dpn);
	
	
	 var url1="http://gbrds.gbif.org/registry/resource/"+"${dataResource.gbifRUuid}"+".json";
	 var url2="http://gbrds.gbif.org/registry/resource/"+"${dataResource.gbifRUuid}"+".json?op=contacts";
	 
	 $.ajax({
		    url: url1,
		    dataType: 'jsonp',
		    success: function(data){
		    	
		    	var name='${fn:escapeXml(dataResource.name)})';
		    	if((data.name!=undefined)&&(data.name.length!=0)){
		    		$('#name').append(data.name.replace(/'/g, "&apos;").replace(/"/g, "&quot;"));
		    	}else if(name.length!=0){
		    		$('#name').append(name);
		    	}else {
		    		$('#name').remove();
		    	}
		    	
		    	
		    	var webUrl='${dataResource.websiteUrl}';
		    	if((data.homepageURL!=undefined)&&(data.homepageURL.length!=0)){
		    		$('#webSiteUrl').append('<a href="'+data.homepageURL+'">'+data.homepageURL+'</a>'); 
		    	}else if(webUrl.length!=0){
		    		$('#webSiteUrl').append('<a href="'+webUrl+'">'+webUrl+'</a>');
		    	}else {
		    		$('#webSiteUrl').remove();
		    	}
		    	
		    	var descrp='${fn:escapeXml(dataResource.description)}';
		    	if((data.description!=undefined)&&(data.description.length!=0)){
		    		$('#descr').append(data.description.replace(/'/g, "&apos;").replace(/"/g, "&quot;")); 
		    	}else if(descrp.length!=0){
		    		$('#descr').append(descrp);
		    	}else {
		    		$('#descr').remove();
		    	}
		    	
		    	var aName='';
		    	if((data.primaryContactName!=undefined)&&(data.primaryContactName.length!=0)){
		    		aName=data.primaryContactName.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
		    	}else if((('${fn:length(agents)}')>0)&&('${agents[0].agentName}'.length!=0)){
		    		aName='${fn:escapeXml(agents[0].agentName)}';
		    	}
		    	
		    	var aAddress='';
		    	if((data.primaryContactAddress!=undefined)&&(data.primaryContactAddress.length!=0)){
		    		aAddress=data.primaryContactAddress.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
		    	}else if('${agents[0].agentAddress}'.length!=0){
		    		aAddress='${fn:escapeXml(agents[0].agentAddress)}';
		    	}
		    	
		    	var aEmail='';
		    	if((data.primaryContactEmail!=undefined)&&(data.primaryContactEmail.length!=0)){
		    		aEmail=data.primaryContactEmail.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
		    	}else if('${agents[0].agentEmail}'.length!=0){
		    		aEmail='${fn:escapeXml(agents[0].agentEmail)}';
		    	}
		    	
		    	var aTelephone='';
		    	if((data.primaryContactPhone!=undefined)&&(data.primaryContactPhone.length!=0)){
		    		aTelephone=data.primaryContactPhone.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
		    	}else if('${agents[0].agentTelephone}'.length!=0){
		    		aTelephone='${fn:escapeXml(agents[0].agentTelephone)}';
		    	}
		    	
		    	if(aName!=''){
					$('#agentTable').find('tbody')
			    	.append($('<tr class="odd">')
			     	   .append($('<td>'+aName+'</td><td>'+aAddress+'</td><td>'+aEmail+'</td><td>'+aTelephone+'</td>')
			     	   )
			    	);
		    		
		    	}else{
		    		$('#agentTable').remove();
		    	}
		    	
		    },
		    error: function (xhr, ajaxOptions, thrownError) {
		    	console.log(xhr.statusText);
		    	console.log(thrownError);
		    	$('#name').append('${fn:escapeXml(dataResource.name)}');
		    	var webUrl='${fn:escapeXml(dataResource.websiteUrl)}';
		    	$('#webSiteUrl').append('<a href="'+webUrl+'">'+webUrl+'</a>');
		    	$('#descr').append('${fn:escapeXml(dataResource.description)}');
		    	var aName='${fn:escapeXml(agents[0].agentName)}';
		    	var aAddress='${fn:escapeXml(agents[0].agentAddress)}';
		    	var aEmail='${fn:escapeXml(agents[0].agentEmail)}';
		    	var aTelephone='${fn:escapeXml(agents[0].agentTelephone)}';
		    	if(aName!=''){
					$('#agentTable').find('tbody')
			    	.append($('<tr class="odd">')
			     	   .append($('<td>'+aName+'</td><td>'+aAddress+'</td><td>'+aEmail+'</td><td>'+aTelephone+'</td>')
			     	   )
			    	);
		    		
		    	}else{
		    		$('#agentTable').remove();
		    	}
		    	
		    }
		});
	
	});
</script>
<div id="twopartheader">
	<h2><spring:message code="dataset.resource"/>: <span class="subject">${dataResource.name}</span>
	</h2>
	<h3 style="font-size: 1.1em"><spring:message code="dataset.providedby"/> <a href="${pageContext.request.contextPath}/publicadores/provider/${dataProvider.key}">${dataProvider.name}</a></h3>
</div>

<c:if test="${dataResource.logoUrl!=null && fn:startsWith(dataResource.logoUrl, 'http://')}">
	

	<c:if test="${dataResource.websiteUrl!=null}"><a href="${dataResource.websiteUrl}"></c:if>
	<gbiftag:scaleImage imageUrl="${dataResource.logoUrl}" maxWidth="200" maxHeight="70" addLink="false" imgClass="logo"/>	
	<c:if test="${dataResource.websiteUrl!=null}"></a></c:if>	
</c:if>

<tiles:insert page="actions.jsp"/>

<% //todo need to use the taxonomy provider field %>
<c:if test="${dataResource.basisOfRecord!='taxonomy' && dataResource.basisOfRecord!='nomenclator'}">
<div class="subcontainer">
	<h4><spring:message code="occurrence.overview"/></h4>
	<tiles:insert page="occurrences.jsp"/>
</div>
<div class="subcontainer">
	<tiles:insert page="indexing.jsp"/>	
</div>	
</c:if>
<div class="subcontainer">
	<h4><spring:message code="dataset.information"/></h4>
	<tiles:insert page="information.jsp"/>
</div>
<c:if test="${fn:length(agents) > 0}">
<div class="subcontainer">
	<tiles:insert page="networks.jsp"/>
</div>	
</c:if>
<div class="subcontainer">
	<tiles:insert page="../agentsResource.jsp"/>
</div>	