<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	$(function(){
		var version='0.9';
		var dp=encodeURI('${dataResource.name}');	
		var dpn='${dataResource.name}';
		if(dpn.length>80){
			dpn=dpn.substring(0,80)+"...";
		}
		var rot='datasets/resource/'+'${dataResource.key}';
		var urlt="http://data.sibcolombia.net/"+rot+"?utm_source="+dp+"&utm_medium=twitter&utm_campaign=impacto_redes";
		$(".twitter-share-button").attr("data-url", urlt);
		$(".twitter-share-button").attr("data-text", dpn);
		
		
		 var url1="http://api.gbif.org/v"+version+"/dataset/"+"${dataResource.gbifRUuid}";
		 var url2="http://api.gbif.org/v"+version+"/dataset/"+"${dataResource.gbifRUuid}"+"/contact";
		 
		 $.ajax({
			    url: url1,
			    success: function(data){
			    	
			    	var name='${fn:escapeXml(dataResource.name)})';
			    	if((data.title!=undefined)&&(data.title.length!=0)){
			    		$('#name').append(data.title.replace(/'/g, "&apos;").replace(/"/g, "&quot;"));
			    	}else if(name.length!=0){
			    		$('#name').append(name);
			    	}else {
			    		$('#name').remove();
			    	}
			    	
			    	var rights='${fn:escapeXml(dataResource.rights)})';
			    	if((data.rights!=undefined)&&(data.rights.length!=0)){
			    		$('#rights').append(data.rights.replace(/'/g, "&apos;").replace(/"/g, "&quot;"));
			    	}else if(rights.length!=0){
			    		$('#rights').append(rights);
			    	}else {
			    		$('#rights').remove();
			    	}
			    	
			    	var webUrl='${dataResource.websiteUrl}';
			    	if((data.homepage!=undefined)&&(data.homepage.length!=0)){
			    		$('#webSiteUrl').append('<a href="'+data.homepage+'">'+data.homepage+'</a>'); 
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
			    	
			    	var citation='${fn:escapeXml(dataResource.citation)})';
			    	if((data.citation.text!=undefined)&&(data.citation.text!=0)){
			    		$('#citation').prepend(data.citation.text.replace(/'/g, "&apos;").replace(/"/g, "&quot;"));
			    	}else if(citation.length!=0){
			    		$('#citation').append(citation);
			    	}else {
			    		$('#citation').remove();
			    	}
			    	var ident='';
			    	if((data.endpoints[0].url!=undefined)&&(data.endpoints[0].url!=0)){
			    		$('#ident').append('<a href="'+data.endpoints[0].url.replace(/'/g, "&apos;").replace(/"/g, "&quot;")+'">'+data.endpoints[0].url.replace(/'/g, "&apos;").replace(/"/g, "&quot;")+'</a>');
			    	}else if(ident.length!=0){
			    		$('#ident').append(ident);
			    	}else {
			    		$('#ident').remove();
			    	}
			    	
			    	var metadata='';
			    	if((data.endpoints[0].url!=undefined)&&(data.endpoints[0].url!=0)&&(data.endpoints[0].url.indexOf("http://ipt.sibcolombia.net/")===0)){
			    		$('#metadata').append('<a href="'+data.endpoints[0].url.replace(/'/g, "&apos;").replace(/"/g, "&quot;").replace('archive','resource').replace('eml','resource').replace('rtf','resource')+'">'+data.endpoints[0].url.replace(/'/g, "&apos;").replace(/"/g, "&quot;").replace('archive','resource').replace('eml','resource').replace('rtf','resource')+'</a>');
			    	}else if(ident.length!=0){
			    		$('#metadata').append(ident);
			    	}else {
			    		$('#metadata').remove();
			    	}

			    	var aName='';
			    	if((data.contacts[0].firstName!=undefined)&&(data.contacts[0].firstName.length!=0)){
			    		aName=data.contacts[0].firstName.replace(/'/g, "&apos;").replace(/"/g, "&quot;");
			    		if((data.contacts[0].lastName!=undefined)&&(data.contacts[0].lastName.length!=0)){
			    			aName = aName + ' ' +  data.contacts[0].lastName.replace(/'/g, "&apos;").replace(/"/g, "&quot;");
			    		}
			    	}else if((('${fn:length(agents)}')>0)&&('${agents[0].agentName}'.length!=0)){
			    		aName='${fn:escapeXml(agents[0].agentName)}';
			    	}
	
			    	var aAddress='';
			    	if((data.contacts[0].address!=undefined)&&(data.contacts[0].address.length!=0)){
			    		aAddress=data.contacts[0].address.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
			    	}else if('${agents[0].agentAddress}'.length!=0){
			    		aAddress='${fn:escapeXml(agents[0].agentAddress)}';
			    	}
			    	
			    	var aEmail='';
			    	if((data.contacts[0].email!=undefined)&&(data.contacts[0].email.length!=0)){
			    		aEmail=data.contacts[0].email.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
			    	}else if('${agents[0].agentEmail}'.length!=0){
			    		aEmail='${fn:escapeXml(agents[0].agentEmail)}';
			    	}
			    	
			    	var aTelephone='';
			    	if((data.contacts[0].phone!=undefined)&&(data.contacts[0].phone.length!=0)){
			    		aTelephone=data.contacts[0].phone.replace(/'/g, "&apos;").replace(/"/g, "&quot;"); 
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
			    	$('#rights').append('${fn:escapeXml(dataResource.rights)}');
			    	$('#citation').append('${fn:escapeXml(dataResource.citation)}');
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
<c:if test="${dataResource.logoUrl!=null && fn:startsWith(dataResource.logoUrl, 'http://')}">
		<c:if test="${dataResource.websiteUrl!=null}"><a href="${dataResource.websiteUrl}"></c:if>
		<gbiftag:scaleImage imageUrl="${dataResource.logoUrl}" maxWidth="200" maxHeight="70" addLink="false" imgClass="logo_dataset"/>	
		<c:if test="${dataResource.websiteUrl!=null}"></a></c:if>	
	</c:if>
	<h2><spring:message code="dataset.resource"/>: <span class="subject">${dataResource.name}</span>
	</h2>
	<h3 style="font-size: 1.1em">
		<spring:message code="dataset.providedby"/> 
		<a href="${pageContext.request.contextPath}/datasets/provider/${dataProvider.key}">${dataProvider.name}</a>
	</h3>
</div>



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