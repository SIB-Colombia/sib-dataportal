<%@ include file="/common/taglibs.jsp"%>

<a href="${pageContext.request.contextPath}/especies/" title="<spring:message code='topmenu.species.title'/>">
	<spring:message code='topmenu.species'/>
</a>
<%--<li><a href="${pageContext.request.contextPath}/countries/" title="<spring:message code='topmenu.countries.title'/>"><spring:message code='topmenu.countries'/></a>--%>
<a href="${pageContext.request.contextPath}/conjuntos/" title="<spring:message code='topmenu.datasets.title'/>">
	<spring:message code='topmenu.datasets'/>
</a>
<a href="${pageContext.request.contextPath}/departamentos/" title="<spring:message code='topmenu.departments.title'/>">
	<spring:message code='topmenu.departments'/>
</a>
<a href="${pageContext.request.contextPath}/publicadores/" title="<spring:message code='topmenu.occurrences.title'/>">
	<spring:message code='topmenu.occurrences'/>
</a>

<div class="share_icons">


	<a href="#"><img src="${pageContext.request.contextPath}/skins/standard/images/ico_search.png" /></a> <span></span> <a href="http://www.sibcolombia.net" title="<spring:message code='portal.header.sibcolombia.title'/>" target="_blank"><img src="${pageContext.request.contextPath}/skins/standard/images/ico_portal.png" alt="<spring:message code='portal.header.sibcolombia.title.alt'/>" /></a> <span></span> <a href="#"><img src="${pageContext.request.contextPath}/skins/standard/images/ico_twitter.png" /></a> <a href="#"><img src="${pageContext.request.contextPath}/skins/standard/images/ico_fb.png" /></a> <a href="#"><img src="${pageContext.request.contextPath}/skins/standard/images/ico_youtube.png" /></a> </div>
<%--<li><a href="${pageContext.request.contextPath}/settings.htm" title="<spring:message code='topmenu.settings.title'/>"><spring:message code='topmenu.settings'/></a>
<li><a href="${pageContext.request.contextPath}/tutorial/" title="<spring:message code='topmenu.about.title'/>"><spring:message code='topmenu.about'/></a>--%>
