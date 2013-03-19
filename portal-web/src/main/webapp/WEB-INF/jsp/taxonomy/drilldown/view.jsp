<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	$(function(){
	//alert("<gbif:taxonPrint concept="${taxonConcept}"/>");	
	var dpn="<gbif:taxonPrint concept="${taxonConcept}"/>";

	var rot="species/1";
	var urlt="http://data.sibcolombia.net/"+rot+"?utm_source="+dpn+"&utm_medium=twitter&utm_campaign=impacto_redes";
	$(".twitter-share-button").attr("data-url", urlt);
	$(".twitter-share-button").attr("data-text", dpn);
	
	if((dpn!="Animalia")&&(dpn!="Plantae")){
		$(".twitter-share-button").remove();
	}
	
	});
</script>
<div id="twopartheader">
	<h2>
		<string:capitalize><spring:message code="taxonrank.${taxonConcept.rank}" /></string:capitalize>: 
		<span class="subject"><gbif:taxonPrint concept="${taxonConcept}"/> <c:if test="${not empty taxonConcept.author}">${taxonConcept.author}</c:if></span>
		<!-- tweet-button-->
		<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/?utm_source=&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es"  >Twittear</a>
		<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
		js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
		</script>
	</h2>
	<h3>
		<c:choose>
	    <c:when test="${not empty taxonConcept.acceptedTaxonName}">
        synonym for <a href="${pageContext.request.contextPath}/species/${taxonConcept.acceptedConceptKey}">${taxonConcept.acceptedTaxonName}</a>
        <c:choose>
					<c:when test="${not empty commonName}">
						<gbif:capitalize>(${commonName})</gbif:capitalize>
					</c:when>
					<c:when test="${not empty taxonConcept.commonName}">
						<gbif:capitalize>(${taxonConcept.commonName})</gbif:capitalize>
					</c:when>
        </c:choose>
    	</c:when>
			<c:when test="${not empty commonName}">
				<gbif:capitalize>${commonName}</gbif:capitalize>
			</c:when>
			<c:otherwise>
				<gbif:capitalize>${taxonConcept.commonName}</gbif:capitalize>
			</c:otherwise>
		</c:choose>
	</h3>
    <tiles:insert page="hierarchy.jsp"/>
</div>



<tiles:insert page="actions.jsp"/>

<tiles:insert page="names.jsp"/>

<tiles:insert page="specimenTypifications.jsp"/>

<tiles:insert page="warnings.jsp"/>

<gbif:isMajorRank concept="${taxonConcept}">
<div class="subcontainer" title="${taxonConcept.taxonName}<c:if test="${not empty commonName}">(${commonName})</c:if> occurrences distribution map">
	<h4><spring:message code="occurrence.overview"/></h4>
	<tiles:insert page="occurrences.jsp"/>
</div><!-- occurrence overview sub container -->	
</gbif:isMajorRank>

<tiles:insert page="images.jsp"/>