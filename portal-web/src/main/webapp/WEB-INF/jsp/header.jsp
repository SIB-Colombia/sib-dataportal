<%@ include file="/common/taglibs.jsp"%>
<div id="header">
<a href="${pageContext.request.contextPath}" title="Portal de datos - SiB Colombia"><img src="${pageContext.request.contextPath}/skins/standard/images/logo.png" width="350" height="104" alt="PORTAL DE DATOS - SIB COLOMBIA" /></a>

	<!--<h3 id="blurb"><spring:message code="portal.header.subtitle"></spring:message></h3> -->

    <a href="http://www.sibcolombia.net" style="float:right; margin:-20px 20px 0 20px;" title="Ir al portal del SiB Colombia" target="_blank"><img src="${pageContext.request.contextPath}/skins/standard/images/btn_sib.png" width="197" height="51" alt="PORTAL DE DATOS - SIB COLOMBIA" />
    </a>

	<div id="quickSearch">
		<tiles:insert page="blanketSearch.jsp"/>
	</div>
</div> <!-- End header-->