<%@ include file="/common/taglibs.jsp"%>

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

<aside>
<a href="http://www.sibcolombia.net" target="_blank"> <img src="${pageContext.request.contextPath}/skins/standard/images/ico_sib_portal.png" alt="<spring:message code='portal.header.dataportal.title.alt'/>"/>
  <h4>IR AL PORTAL GENERAL</h4>
  </a>
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
    js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));</script>
      <div class="fb-follow" data-href="https://www.facebook.com/SibColombia" data-show-faces="false" data-width="100"></div>
      <!-- facebok-button--> 

  </div>
  <hr/>
  <a class="cifras" href="${pageContext.request.contextPath}/stats.htm" target="_self">
  <img src="${pageContext.request.contextPath}/skins/standard/images/ico_cifras.png" alt="<spring:message code='portal.header.dataportal.title.alt'/>"/>
    <c:set var="link1">
    <em>
    <spring:message code="topmenu.about"/>
    </em>
    </c:set>
    <c:set var="link2">
    <em>
    <spring:message code="topmenu.settings"/>
    </em>
    </c:set>
    <c:set var="link3">
    <em>
    <spring:message code="dataagreement.title"/>
    </em>
    </c:set>
    
    <p>
      <fmt:formatNumber var="geoTotal" type="number" value="${totalGeoreferencedOccurrenceRecords}" />
      <fmt:formatNumber var="speciesTotal" type="number" value="${totalSpecies}" />
      <fmt:formatNumber var="totalCO" type="number" value="${totalOcurrenceRecordsCO}" />
      <fmt:formatNumber var="total" type="number" value="${totalOccurrenceRecords}" />
      <fmt:formatNumber var="totalSpecies" type="number" value="${totalSpecies}" />
      <fmt:formatNumber var="speciesCountryCO" type="number" value="${speciesCountryCO}" />
      <spring:message code="welcome.tip.of.the.day.1" arguments="${totalCO}%%%${total}%%%${totalSpecies}%%%${speciesCountryCO}" argumentSeparator="%%%"/>
    </p>
      <!--  
  <c:set var="req" value="${pageContext.request}" />
  <c:set var="uri" value="${req.requestURI}" />
  <c:set var="url">${req.requestURL}</c:set>
  <c:set var="urlt" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}"/>
  <p>${urlt}</p>
  --> 
  </a>
  <hr/> 
  <a class='tut_selector' href="#inline_content">&iquest;C&oacute;mo usar el portal de datos?</a>
  <hr/>
  </aside>

<div id="searchpane">
	<form name="quickSearchForm" method="get" onsubmit="return javascript:submitFromLinkQuickSearch();" action="${pageContext.request.contextPath}/search/blanketSearch.htm">
		<input type="text" id="query" name="keyword" placeholder="Busca en el portal de datos" autosave="gbif.blanketsearch" results="5" tabindex="1"/>		
		<a href="${pageContext.request.contextPath}/busqueda/" class="floating_search">Búsqueda<br/>avanzada</a>
		<input type="submit" name="buscar_home" id="buscar_home" value="">
	</form>
    <hr/>
    <div class="results">
         <a>
             <img src="http://data.sibcolombia.net/skins/standard/images/esp_ico.png"/>
             <h1>Ara severus</h1>
             <strong>Colección de sonidos ambientales</strong>
             <p>Instituto alexander von Humboldt</p>
         </a>
         <a>
             <img src="http://data.sibcolombia.net/skins/standard/images/esp_ico.png"/>
             <h1>Ara severus</h1>
             <strong>Colección de sonidos ambientales</strong>
             <p>Instituto alexander von Humboldt</p>
         </a>
         <a>
             <img src="http://data.sibcolombia.net/skins/standard/images/esp_ico.png"/>
             <h1>Ara severus</h1>
             <strong>Colección de sonidos ambientales</strong>
             <p>Instituto alexander von Humboldt</p>
         </a>
         <a>
             <img src="http://data.sibcolombia.net/skins/standard/images/esp_ico.png"/>
             <h1>Ara severus</h1>
             <strong>Colección de sonidos ambientales</strong>
             <p>Instituto alexander von Humboldt</p>
         </a>
        
    </div>
</div>

<div id="geographypane" class="panes_div">
  <tiles:insert page="/WEB-INF/jsp/geography/introduction.jsp"/>
</div>
<div id ="datasetpane"  class="panes_div">
  <tiles:insert page="/WEB-INF/jsp/dataset/introduction.jsp"/>
</div>
<div id ="publisherpane"  class="panes_div">
  <tiles:insert page="/WEB-INF/jsp/publisher/introduction.jsp"/>
</div>


<small>
  <spring:message code="portal.frontpage.images.credits"/>
</small>
  
<script type="text/javascript">
document.getElementById("query").focus();

function submitQuickSearch(formSubmit){
	//check for empty value
	var textValue = document.getElementById('query').value;
	if(textValue!=null && textValue.length>0){
		if(formSubmit)
			document.quickSearchForm.submit();
		return true;
	}
	return false;
}

function submitFromLinkQuickSearch(){
	//check for empty value
	var textValue = document.getElementById('query').value;
	if(textValue!=null && textValue.length>0){
			document.quickSearchForm.submit();
	}
}	
  var uvOptions = {};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/lBPZH9vrbtDdBpMQsEctag.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
 
</script> 
