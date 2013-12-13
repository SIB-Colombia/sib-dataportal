<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %><%@ include file="/common/taglibs.jsp"%>
<META NAME="country" CONTENT="Brasil">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta property="og:title" content="Portal da Biodiversidade do Sistema da Informação sobre a Biodiversidade Brasileira" />
<meta property="og:type" content="website" />
<meta property="og:description" content="O Sistema da Informação sobre a Biodiversidade Brasileira é um serviço que permite acesso a registros biológicos publicados por nossa rede de parceiros e pelo GBIF" />
<meta property="og:url" content="http://localhost/portal-dev" />
<meta property="og:image" content="http://data.sibcolombia.net/skins/standard/images/logo.png" />
<meta property="og:site_name" content="Sistema da Informação sobre a Biodiversidade Brasileira" />
<meta property="og:locale" content="pt_BR" />
<META NAME="Keywords" CONTENT="portal de dados, sib brasil, informática de biodiversidade, busca de especies, gbif brasil, conjunto de dados, sibbr, espécies do Brasil, espécies por estados, 
Sistema da Informação sobre a Biodiversidade Brasileira, biodiversidade, biodiversidade no Brasil, espécies ameaçadas, espécies ameaçadas no brasil, catálogo de espécies, biologia, conservação, nome científico, fauna, flora">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/javascript/jconf.jquery.js" type="text/javascript" language="javascript"></script>
<script src="${pageContext.request.contextPath}/javascript/jquery.colorbox-min.js" type="text/javascript" language="javascript"></script>

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
		//Examples of how to assign the Colorbox event to elements
		$(".group1").colorbox({rel:'group1', transition:"fade"});
		$(".group2").colorbox({rel:'group2', transition:"fade"});
		$(".group3").colorbox({rel:'group3', transition:"fade"});
		$(".group4").colorbox({rel:'group4', transition:"fade"});
		$(".group5").colorbox({rel:'group5', transition:"fade"});
		$(".tut_selector").colorbox({inline:true, width:"50%"});
		
		$(".g1").click(function() {$(".group1").colorbox({open:true})});
		$(".g2").click(function() {$(".group2").colorbox({open:true})});
		$(".g3").click(function() {$(".group3").colorbox({open:true})});
		$(".g4").click(function() {$(".group4").colorbox({open:true})});
		$(".g5").click(function() {$(".group5").colorbox({open:true})});
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