<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
	var dp=encodeURI("${dataResource.name}");	
	var dpn="${dataResource.name}";
	if(dpn.length>80){
		dpn=dpn.substring(0,80)+"...";
	}
	var rot="datasets/resource/"+"${dataResource.key}";
	var urlt="http://data.sibcolombia.net/"+rot+"?utm_source="+dp+"&utm_medium=twitter&utm_campaign=impacto_redes";
	$(".twitter-share-button").attr("data-url", urlt);
	$(".twitter-share-button").attr("data-text", dpn);
	
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
	<tiles:insert page="../agents.jsp"/>
</div>	
<div class="subcontainer">
	<tiles:insert page="networks.jsp"/>
</div>	
</c:if>