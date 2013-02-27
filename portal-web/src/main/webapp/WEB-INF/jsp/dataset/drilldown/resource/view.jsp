<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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
		    	
		    	if((data.name!=undefined)&&(data.name.length!=0)){
		    		$('#name').append(data.name);
		    	}else if(name.length!=0){
		    		$('#name').append('${dataResource.name}');
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
		    	
		    	if((data.description!=undefined)&&(data.description.length!=0)){
		    		$('#descr').append(data.description); 
		    	}else if(descrp.length!=0){
		    		$('#descr').append('${dataResource.description}');
		    	}else {
		    		$('#descr').remove();
		    	}
		    	
		    	var aName='';
		    	if((data.primaryContactName!=undefined)&&(data.primaryContactName.length!=0)){
		    		aName=data.primaryContactName; 
		    	}else if((('${fn:length(agents)}')>0)&&('${agents[0].agentName}'.length!=0)){
		    		aName='${agents[0].agentName}';
		    	}
		    	
		    	var aAddress='';
		    	if((data.primaryContactAddress!=undefined)&&(data.primaryContactAddress.length!=0)){
		    		aAddress=data.primaryContactAddress; 
		    	}else if('${agents[0].agentAddress}'.length!=0){
		    		aAddress='${agents[0].agentAddress}';
		    	}
		    	
		    	var aEmail='';
		    	if((data.primaryContactEmail!=undefined)&&(data.primaryContactEmail.length!=0)){
		    		aEmail=data.primaryContactEmail; 
		    	}else if('${agents[0].agentEmail}'.length!=0){
		    		aEmail='${agents[0].agentEmail}';
		    	}
		    	
		    	var aTelephone='';
		    	if((data.primaryContactPhone!=undefined)&&(data.primaryContactPhone.length!=0)){
		    		aTelephone=data.primaryContactPhone; 
		    	}else if('${agents[0].agentTelephone}'.length!=0){
		    		aTelephone='${agents[0].agentTelephone}';
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
		    	$('#name').append('${dataResource.name}');
		    	var webUrl='${dataResource.websiteUrl}';
		    	$('#webSiteUrl').append('<a href="'+webUrl+'">'+webUrl+'</a>');
		    	$('#descr').append('${dataResource.description}');
		    	var aName='${agents[0].agentName}';
		    	var aAddress='${agents[0].agentAddress}';
		    	var aEmail='${agents[0].agentEmail}';
		    	var aTelephone='${agents[0].agentTelephone}';
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
		<!-- tweet-button-->
		<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/?utm_source=&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es" data-text="" >Twittear</a>
		<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
		js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
		</script>
	</h2>
	<h3 style="font-size: 1.1em"><spring:message code="dataset.providedby"/> <a href="${pageContext.request.contextPath}/datasets/provider/${dataProvider.key}">${dataProvider.name}</a></h3>
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