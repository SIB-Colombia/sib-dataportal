<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
 <script src="${pageContext.request.contextPath}/javascript/jquery-1.9.1.js" type="text/javascript" language="javascript"></script>
 <script src="${pageContext.request.contextPath}/javascript/jquery-ui-1.10.2.custom.js" type="text/javascript" language="javascript"></script>
 <script src="${pageContext.request.contextPath}/javascript/jconf.jquery.js" type="text/javascript" language="javascript"></script>
 <script src="${pageContext.request.contextPath}/javascript/jquery.colorbox-min.js" type="text/javascript" language="javascript"></script>
 

 <c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set> 
<c:set var="cpth">${pageContext.request.contextPath}</c:set>
<c:set var="pth">${requestScope['javax.servlet.forward.request_uri']}</c:set>
<c:set var="pge">${fn:substring(pth,fn:length(cpth),fn:length(pth))}</c:set>
<c:set var="urlt" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}"/>
<script type="text/javascript">
<spring:message code="sib.terms.dialog.question" var="question"/>
<spring:message code="sib.terms.dialog.accept" var="accept"/>
<spring:message code="sib.terms.dialog.cancel" var="cancel"/>

$(document).ready(function() {
	//alert(readCookies());
	if(('${pge}'!='/terms.htm')&&('${pge}'!='/stats.htm')&&('${pge}'!='/settings.htm')){
		
		if(readCookie('GbifTermsAndConditions')===null){
			
			$().jConfirmAction({question : '${question}'+'<br/><a href="${urlt}/terms.htm" class="newtab">${urlt}/terms.htm</a>', yesAnswer :'${accept}', cancelAnswer : '${cancel}', url:'${pageContext.request.contextPath}/welcome.htm'});
			
		}
	}else{
		$('#dialog-confirm').hide();
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

<!DOCTYPE HTML >
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

		
	</body>
</html>
</c:if>
