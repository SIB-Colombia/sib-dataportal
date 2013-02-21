<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
	var dp=encodeURI("${department.departmentName}");	
	var rot="departments/"+"${department.isoDepartmentCode}";
	var urlt="http://data.sibcolombia.net/"+rot+"?utm_source="+dp+"&utm_medium=twitter&utm_campaign=impacto_redes";
	$(".twitter-share-button").attr("data-url", urlt);
	});
</script>

<div id="twopartheader">
	<h2><spring:message code="geography.drilldown.list.resource.search"/>: <span class="subject"><gbif:capitalize><string:lowerCase><spring:message code="department.${department.isoDepartmentCode}"/></string:lowerCase></gbif:capitalize></span>
	<!-- tweet-button-->
	<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/?utm_source=&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es">Twittear</a>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
	js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
	</script>
	</h2>
	
</div>	

<tiles:insert page="actionsDepartment.jsp"/>

<div class="subcontainer">
	<h4><spring:message code="occurrence.overview"/></h4>
	<tiles:insert page="occurrences.jsp"/>
	<div>
	<c:set var="occurrenceSearchSubject" value="5" scope="request"/> 
    <c:set var="occurrenceSearchValue" value="${department.isoDepartmentCode}" scope="request"/>
	<c:set var="showNonGeoreferencedCount" value="true" scope="request"/>
	<tiles:insert page="dataRecord.jsp"/>
	<tiles:insert page="countryCounts.jsp"/>
	</div> 
</div>