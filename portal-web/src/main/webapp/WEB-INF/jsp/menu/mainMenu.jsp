<%@ include file="/common/taglibs.jsp"%>


<%--a href="${pageContext.request.contextPath}/especies/" title="<spring:message code='topmenu.species.title'/>"><spring:message code='topmenu.species'/></a--%>
<%--<a href="${pageContext.request.contextPath}/countries/" title="<spring:message code='topmenu.countries.title'/>"><spring:message code='topmenu.countries'/></a>--%>
<a href="${pageContext.request.contextPath}/conjuntos/" title="<spring:message code='topmenu.datasets.title'/>"><spring:message code='topmenu.datasets'/></a>
<a href="http://maps.sibcolombia.net/" title="<spring:message code='topmenu.explorer.title'/>"><spring:message code='topmenu.explorer'/></a>
<a href="${pageContext.request.contextPath}/departamentos/" title="<spring:message code='topmenu.departments.title'/>"><spring:message code='topmenu.departments'/></a>
<a href="${pageContext.request.contextPath}/publicadores/" title="<spring:message code='topmenu.publishers.title'/>"><spring:message code='topmenu.publishers'/></a>
<%--<a href="${pageContext.request.contextPath}/busqueda/" title="<spring:message code='topmenu.occurrences.title'/>"><spring:message code='topmenu.occurrences'/></a>--%>


<div class="share_icons">
	<div id="quickSearch">
		<tiles:insert page="blanketSearch.jsp"/>
	</div>
	 <span></span>
	 <a href="http://www.sibcolombia.net" title="<spring:message code='portal.header.sibcolombia.title'/>" target="_blank"><img src="${pageContext.request.contextPath}/skins/standard/images/ico_portal.png" alt="<spring:message code='portal.header.sibcolombia.title.alt'/>" /></a>
	 <span></span>
	 <a href="https://twitter.com/sibcolombia" target="_blank" ><img src="${pageContext.request.contextPath}/skins/standard/images/ico_twitter.png" /></a>
	 <a href="https://www.facebook.com/SibColombia" target="_blank" ><img src="${pageContext.request.contextPath}/skins/standard/images/ico_fb.png" /></a>
	 <a href="http://www.youtube.com/user/sibcolombia" target="_blank" ><img src="${pageContext.request.contextPath}/skins/standard/images/ico_youtube.png" /></a>

</div>
