<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %><%@ include file="/common/taglibs.jsp"%>
<META NAME="country" CONTENT="Colombia">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta property="og:title" content="Portal de Datos del Sistema de Información sobre Biodiversidad en Colombia" />
<meta property="og:type" content="website" />
<meta property="og:description" content="El portal de datos del SiB Colombia es un servicio que permite acceder ágilmente a registros biológicos que han sido publicados por nuestra red de socios" />
<meta property="og:url" content="http://data.sibcolombia.net/" />
<meta property="og:image" content="http://data.sibcolombia.net/skins/standard/images/logo.png" />
<meta property="og:site_name" content="Sib Colombia" />
<meta property="og:locale" content="es_ES" />
<META NAME="Keywords" CONTENT="portal de datos, sib colombia, informática de biodiversidad, búsqueda de especies, gbif colombia, conjunto de datos, dataset, especies de colombia, especies por departamento, 
Sistema de información sobre biodiversidad de Colombia, biodiversidad, biodiversidad en colombia, especies amenazadas, especies amenazadas en colombia, catálogo de especies, biologia, conservacion, especies, nombre cientifico, biota, biota colombiana, especies en via de extincion, fauna colombiana, flora colombiana ">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
 <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>
 <script src="${pageContext.request.contextPath}/javascript/jconf.jquery.js" type="text/javascript" language="javascript"></script>

<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="urlt" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}"/>


<script type="text/javascript">
<spring:message code="sib.terms.dialog.question" var="question"/>
<spring:message code="sib.terms.dialog.accept" var="accept"/>
<spring:message code="sib.terms.dialog.cancel" var="cancel"/>
$(document).ready(function() {
	//alert(readCookies());
	if(readCookie('GbifTermsAndConditions')===null){
		$('.confirm').jConfirmAction({question : '${question}'+'<br/><a href="${urlt}/terms.htm" class="newtab">${urlt}/terms.htm</a>', yesAnswer : '${accept}', cancelAnswer : '${cancel}', url:''});
	}
});
</script>

<!DOCTYPE HTML>
<c:if test="${param['noHeaders']!=1}">
<html>
	<!-- GBIF Portal Version: <gbif:propertyLoader bundle="portal" property="version"/> -->	
	<head>
    	<tiles:insert name="headcontent" flush="true"/>	
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	
		<c:if test="${not empty points}">
			<meta name="geo.position" content="<c:forEach items="${points}" var="point">${point.latitude};${point.longitude}</c:forEach>">
		</c:if> 		
		
		<tiles:insert name="keywords"/>
		<title>
			<tiles:insert name="subtitle"/>
				- 			
			<c:set var="title" scope="page"><tiles:getAsString name="title"/></c:set>
			<spring:message code="${title}"/> 
		</title>
		<c:set var="title" scope="request"><tiles:insert name="subtitle" flush="false"/></c:set>		
	</head>
	<body>
	<spring:message code="sib.terms.dialog.terms" var="terms"/>
	
	<!-- jquery dialog div-->
	 
	<div id="dialog-confirm" class="some" title="${terms}"></div>
	<!-- jquery dialog div-->	
		
	</body>
	    <div id="skipNav">
			<ul title="<spring:message code="accessibility.title" text="Accessibility options"/>">
	  		<li><a href="#mainContent" accesskey="C"><spring:message code="accessibility.skip.to.content" text="Skip to Content"/></a></li>
	  		<li><a href="#sidebar" accesskey="S"><spring:message code="accessibility.skip.to.sidebar" text="Skip to Sidebar"/></a></li>
			</ul> 
	    </div>

	    <header class="sib">
		        <tiles:insert name="header"/>
		        <nav>
				<tiles:insert name="topmenu"/>
		        </nav>
        </header>

		<div id="cocoon">
			<div id="container">	

				<div id="content">
</c:if>       				
					<tiles:insert name="content"/>
<c:if test="${param['noHeaders']!=1}">					
					<tiles:insert name="breadcrumbs"/>
				</div><!--End content -->				
			</div><!-- End container-->
		</div><!-- End cocoon-->	
		<tiles:insert name="footer"/>

</html>
</c:if>