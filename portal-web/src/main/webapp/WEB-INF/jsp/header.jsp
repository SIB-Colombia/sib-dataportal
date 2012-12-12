<%@ include file="/common/taglibs.jsp"%>
<div id="header">
<a href="${pageContext.request.contextPath}" title="<spring:message code="portal.header.dataportal.title"/>"><img src="${pageContext.request.contextPath}/skins/standard/images/logo.png" width="350" height="104" alt="<spring:message code="portal.header.dataportal.title.alt"/>" /></a>

	<!--<h3 id="blurb"><spring:message code="portal.header.subtitle"></spring:message></h3> -->

    <a href="http://www.sibcolombia.net" style="float:right; margin:-20px 20px 0 20px;" title="<spring:message code="portal.header.sibcolombia.title"/>" target="_blank"><img src="${pageContext.request.contextPath}/skins/standard/images/btn_sib.png" width="197" height="51" alt="<spring:message code="portal.header.sibcolombia.title.alt"/>" />
    </a>

	<div id="quickSearch">
		<tiles:insert page="blanketSearch.jsp"/>
	</div>
</div> <!-- End header-->