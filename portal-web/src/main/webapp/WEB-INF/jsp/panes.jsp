<%@ include file="/common/taglibs.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>

<div id="fb-root"></div>
<div id="fb-root"></div>
<div id="fb-root"></div>
<div id="panes">

<div> 
  <h1><spring:message code="welcome.tip.of.the.day.title"/></h1>  

  <!--<p><strong>
    <spring:message code="portal.header.dataportal.title.message"/>
    </strong></p><spring:message code="welcome.tip.of.the.day.2" arguments="${link1}"/><br/>
 <spring:message code="welcome.tip.of.the.day.3" arguments="${link2}"/><br/>
<spring:message code="welcome.tip.of.the.day.4" arguments="${link3}"/><br/>
<a href="version.htm"><spring:message code="version" text="Version"/>
<gbif:propertyLoader bundle="portal" property="version"/></a>-->
  


<div id="taxonomypane" class="panes_div">
  <tiles:insert page="/WEB-INF/jsp/taxonomy/introduction.jsp"/>
</div>
<div id ="datasetpane"  class="panes_div">
  <tiles:insert page="/WEB-INF/jsp/dataset/introduction.jsp"/>
</div>
<div id ="publisherpane"  class="panes_div">
  <tiles:insert page="/WEB-INF/jsp/publisher/introduction.jsp"/>
</div>



<aside>
<div> <a href="http://www.sibcolombia.net" target="_blank"> <img src="${pageContext.request.contextPath}/skins/standard/images/ico_sib_portal.png" alt="<spring:message code='portal.header.dataportal.title.alt'/>"/></a>
  <h4>IR AL PORTAL GENERAL</h4>
  </div>
  <hr/>
  <div>
      <!-- tweet-button--> 
      <a href="https://twitter.com/sibcolombia" class="twitter-follow-button" data-show-count="false" data-lang="es">Seguir a @sibcolombia</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
  <br/>
  <br/>
      <!-- facebok-button-->
      <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/es_ES/all.js#xfbml=1&appId=191630764244997";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
      <div class="fb-follow" data-href="https://www.facebook.com/SibColombia" data-layout="button_count" data-show-faces="false" data-width="300"></div>
      <!-- facebok-button--> 

  </div>
  <hr/>
  <div class="cifras">
  <img src="${pageContext.request.contextPath}/skins/standard/images/ico_cifras.png" alt="<spring:message code='portal.header.dataportal.title.alt'/>"/>
    <c:set var="link1">
    <em><a href="${pageContext.request.contextPath}/tutorial/introduction">
    <spring:message code="topmenu.about"/>
    </a></em>
    </c:set>
    <c:set var="link2">
    <em><a href="${pageContext.request.contextPath}/settings.htm">
    <spring:message code="topmenu.settings"/>
    </a></em>
    </c:set>
    <c:set var="link3">
    <em><a href="${pageContext.request.contextPath}/terms.htm">
    <spring:message code="dataagreement.title"/>
    </a></em>
    </c:set>
    
    <p>
      <fmt:formatNumber var="geoTotal" type="number" value="${totalGeoreferencedOccurrenceRecords}" />
      <fmt:formatNumber var="speciesTotal" type="number" value="${totalSpecies}" />
      <fmt:formatNumber var="totalCO" type="number" value="${totalOcurrenceRecordsCO}" />
      <fmt:formatNumber var="total" type="number" value="${totalOccurrenceRecords}" />
      <fmt:formatNumber var="totalSpecies" type="number" value="${totalSpecies}" />
      <fmt:formatNumber var="speciesCountryCO" type="number" value="${speciesCountryCO}" />
      <spring:message code="welcome.tip.of.the.day.1" arguments="${totalCO}%%%${total}%%%${totalSpecies}%%%${speciesCountryCO}" argumentSeparator="%%%"/>
      <!--  
	<c:set var="req" value="${pageContext.request}" />
	<c:set var="uri" value="${req.requestURI}" />
	<c:set var="url">${req.requestURL}</c:set>
	<c:set var="urlt" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}"/>
	<p>${urlt}</p>
	--> 
	</div>
  <hr/> 
  </aside>
  
  <div id ="geographypane"  class="panes_div"><tiles:insert page="/WEB-INF/jsp/geography/introduction.jsp"/>
  </div>
  
  </div>
<!-- End panes--> 
<small>
  <spring:message code="portal.frontpage.images.credits"/>
</small>
  
<script type="text/javascript">
  var uvOptions = {};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/lBPZH9vrbtDdBpMQsEctag.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
</script> 
