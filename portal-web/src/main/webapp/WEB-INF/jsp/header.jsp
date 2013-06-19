<%@ include file="/common/taglibs.jsp"%>

   <a class="logo" href="http://data.sibcolombia.net" title="<spring:message code='portal.header.dataportal.title'/>"><img src="${pageContext.request.contextPath}/skins/standard/images/logo_dataportal.png" alt="<spring:message code='portal.header.dataportal.title.alt'/>" /></a>


	<div id="quickSearch">
		<tiles:insert page="blanketSearch.jsp"/>
	</div>
<!-- End header-->