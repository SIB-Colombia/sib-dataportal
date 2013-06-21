<%@ include file="/common/taglibs.jsp"%>
<!--<h4><spring:message code="agents.title"/></h4>-->
<!--  
<display:table
	name="agents" 
	class="results" 
	uid="agent" 
	sort="external"
	defaultsort="1"
>
  <display:column property="agentName" titleKey="name"/>
  <display:column titleKey="role">
		<c:choose>
			<c:when test="${agent.agentType==1}">
				<spring:message code="agents.role.administrative"/>
			</c:when>	
			<c:when test="${agent.agentType==2}">
				<spring:message code="agents.role.technical"/>
			</c:when>
		</c:choose> 
		<c:if test="${not empty dataProvider.uuid}"><p><label><spring:message code="website"/>:</label><a href="${dataProvider.uuid}">${dataProvider.uuid}</a></p></c:if> 	
  </display:column>
  <display:column property="agentAddress" titleKey="address" />
  <display:column titleKey="email">
		<gbiftag:emailPrint email="${agent.agentEmail}" />  
  </display:column>
  <display:column property="agentTelephone" titleKey="telephone" />
</display:table>
-->


<!--<c:if test="${not empty dataProvider.uuid}"><p><label><spring:message code="gbif.link"/>:</label><a href="http://gbrds.gbif.org/browse/agent?uuid=${dataProvider.uuid}">http://gbrds.gbif.org/browse/agent?uuid=${dataProvider.uuid}</a></p></c:if>-->
<p class="termsHelp">







