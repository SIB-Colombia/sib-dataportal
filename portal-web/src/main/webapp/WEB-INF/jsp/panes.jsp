<%@ include file="/common/taglibs.jsp"%>


<div id="panes">

  <div id="quickSearch">
    <h1>Encuentra</h1>
            <tiles:insert page="blanketSearch.jsp"/>
          <a href="${pageContext.request.contextPath}/occurrences"><spring:message code="topmenu.occurrences"/></a>
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
</div><!-- End panes-->	

<div id="announce">
<%-- welcome message hidden since it is now on the footer
<h3><spring:message code="welcome.tip.of.the.day.title"/></h3>--%>
<c:set var="link1">
	<em><a href="${pageContext.request.contextPath}/tutorial/introduction"><spring:message code="topmenu.about"/></a></em>
</c:set>
<c:set var="link2">
	<em><a href="${pageContext.request.contextPath}/settings.htm"><spring:message code="topmenu.settings"/></a></em>
</c:set>
<p>
<fmt:formatNumber var="total" type="number" value="${totalOccurrenceRecords}" />
<fmt:formatNumber var="geoTotal" type="number" value="${totalGeoreferencedOccurrenceRecords}" />
<spring:message code="welcome.tip.of.the.day.1" arguments="${total}%%%${geoTotal}" argumentSeparator="%%%"/><br/>
<spring:message code="welcome.tip.of.the.day.2" arguments="${link1}"/><br/>
<spring:message code="welcome.tip.of.the.day.3" arguments="${link2}"/><br/>
<a href="version.htm"><spring:message code="version" text="Version"/> <gbif:propertyLoader bundle="portal" property="version"/></a></p>
</div>

<script type="text/javascript">
  var uvOptions = {};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/lBPZH9vrbtDdBpMQsEctag.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
</script>