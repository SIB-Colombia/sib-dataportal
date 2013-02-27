<%@ include file="/common/taglibs.jsp"%>
<c:if test="${fn:length(dataResources) > 0}">
<h4><spring:message code="dataset.provider.resources"/></h4>


<!--<ul id="resources" class="genericList">-->
	<fieldset>
	<c:forEach items="${dataResources}" var="dataResource" varStatus="status">
		
		<!--<li>-->
		
			<p><a href="${pageContext.request.contextPath}/datasets/resource/${dataResource.key}/">${dataResource.name}</a></p>
		
		<!--</li>-->
		
	</c:forEach>
	</fieldset>
<!--</ul>-->
	
</c:if>