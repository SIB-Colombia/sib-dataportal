<%@ include file="/common/taglibs.jsp"%>


<h4><spring:message code="agents.title"/></h4>

  
<table id="agentTable" class="results">
<thead>
<tr>
<th class="sorted order1"><spring:message code="name"/></th>
<th><spring:message code="address"/></th>
<th><spring:message code="email"/></th>
<th><spring:message code="telephone"/></th></tr></thead>
<tbody></tbody></table>






<!--<c:if test="${not empty dataProvider.uuid}"><p><label><spring:message code="gbif.link"/>:</label><a href="http://gbrds.gbif.org/browse/agent?uuid=${dataProvider.uuid}">http://gbrds.gbif.org/browse/agent?uuid=${dataProvider.uuid}</a></p></c:if>-->
<p class="termsHelp">







