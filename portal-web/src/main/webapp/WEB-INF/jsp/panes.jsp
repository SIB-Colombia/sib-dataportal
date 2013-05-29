<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>

<div id="fb-root"></div>
<div id="fb-root"></div>
<div id="fb-root"></div>

<div id="panes">
  <div id="quickSearch">
    <h1><spring:message code="find"/></h1>
            <tiles:insert page="blanketSearch.jsp"/>
          <a href="${pageContext.request.contextPath}/occurrences"><spring:message code="topmenu.occurrences"/></a>
    </div>
    <div class="white_rounded_frame intro">
   <!--<h1><spring:message code="welcome.tip.of.the.day.title"/></h1> -->
   <img src="${pageContext.request.contextPath}/skins/standard/images/bienvenido.png" width=alt="<spring:message code="portal.header.dataportal.title.alt"/>" />
   <p><strong><spring:message code="portal.header.dataportal.title.message"/></strong></p>
   
<!--<spring:message code="welcome.tip.of.the.day.2" arguments="${link1}"/><br/>
 <spring:message code="welcome.tip.of.the.day.3" arguments="${link2}"/><br/>
<spring:message code="welcome.tip.of.the.day.4" arguments="${link3}"/><br/>
<a href="version.htm"><spring:message code="version" text="Version"/>
<gbif:propertyLoader bundle="portal" property="version"/></a>-->

</p>
    </div>
	<div id="taxonomypane" class="panes_div">
		<tiles:insert page="/WEB-INF/jsp/taxonomy/introduction.jsp"/>
	</div>
	<div id ="datasetpane"  class="panes_div">
		<tiles:insert page="/WEB-INF/jsp/dataset/introduction.jsp"/>
	</div>	
	<div id ="geographypane"  class="panes_div">
		<tiles:insert page="/WEB-INF/jsp/geography/introduction.jsp"/>
	</div>
	<hr class="hr_clear" />
    
    
    <div class="white_rounded_frame">
    <img src="${pageContext.request.contextPath}/skins/standard/images/sib_logo_bola.png" alt="<spring:message code="portal.header.dataportal.title.alt"/>" style="float:left; margin-right:20px"/>
    
	<c:set var="link1">
	<em><a href="${pageContext.request.contextPath}/tutorial/introduction"><spring:message code="topmenu.about"/></a></em>
</c:set>
<c:set var="link2">
	<em><a href="${pageContext.request.contextPath}/settings.htm"><spring:message code="topmenu.settings"/></a></em>
</c:set>
<c:set var="link3">
	<em><a href="${pageContext.request.contextPath}/terms.htm"><spring:message code="dataagreement.title"/></a></em>
</c:set>

<p style="margin:0px 10px 10px 0; width:70%; display:inline-block">
<fmt:formatNumber var="geoTotal" type="number" value="${totalGeoreferencedOccurrenceRecords}" />
<fmt:formatNumber var="speciesTotal" type="number" value="${totalSpecies}" />

<fmt:formatNumber var="totalCO" type="number" value="${totalOcurrenceRecordsCO}" />
<fmt:formatNumber var="total" type="number" value="${totalOccurrenceRecords}" />
<fmt:formatNumber var="totalSpecies" type="number" value="${totalSpecies}" />
<fmt:formatNumber var="speciesCountryCO" type="number" value="${speciesCountryCO}" />
<spring:message code="welcome.tip.of.the.day.1" arguments="${totalCO}%%%${total}%%%${totalSpecies}%%%${speciesCountryCO}" argumentSeparator="%%%"/><br/>
	<!--  
	<c:set var="req" value="${pageContext.request}" />
	<c:set var="uri" value="${req.requestURI}" />
	<c:set var="url">${req.requestURL}</c:set>
	<c:set var="urlt" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}"/>
	<p>${urlt}</p>
	--> 
	<div style="display:inline-block; vertical-align:top; margin:0px;">
	<!-- tweet-button-->
	<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://data.sibcolombia.net/inicio.htm?utm_source=home&utm_medium=twitter&utm_campaign=impacto_redes" data-via="sibcolombia" data-lang="es">Twittear</a>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);
	js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
	</script>
	<!-- tweet-button-->
	
	<!-- facebok-button-->
	<iframe scrolling="no" frameborder="0" allowtransparency="true" style="border:none; overflow:hidden; width:140px; height:40px;" src="//www.facebook.com/plugins/follow.php?href=https%3A%2F%2Fwww.facebook.com%2FSibColombia&amp;layout=standard&amp;show_faces=false&amp;colorscheme=light&amp;locale=es_ES&amp;font=segoe+ui&amp;width=140&amp;height=35&amp;appId=191630764244997"></iframe>
	<!-- facebok-button-->
    </div>
<small> <spring:message code="portal.frontpage.images.credits"/></small>
</div><!-- End panes-->	


<script type="text/javascript">
  var uvOptions = {};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/lBPZH9vrbtDdBpMQsEctag.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
</script>

