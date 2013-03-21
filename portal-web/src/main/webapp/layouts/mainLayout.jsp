<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
 <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
 <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js"></script>
 <script src="${pageContext.request.contextPath}/javascript/jconf.jquery.js" type="text/javascript" language="javascript"></script>

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
	
	if(('${pge}'!='/terms.htm')&&('${pge}'!='/stats.htm')&&('${pge}'!='/settings.htm')){
		
		if(readCookie('GbifTermsAndConditions')===null){
			
			$().jConfirmAction({question : '${question}'+'<br/><a href="${urlt}/terms.htm">${urlt}/terms.htm</a>', yesAnswer :'${accept}', cancelAnswer : '${cancel}', url:'${pageContext.request.contextPath}/welcome.htm'});
			
		}
	}else{
		$('#dialog-confirm').hide();
	}
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
		<!--  
		<div id="dialog-confirm" class="some" title="${terms}"></div>
		-->
		<!-- jquery dialog div-->
	
	    <div id="skipNav">
			<ul title="<spring:message code="accessibility.title" text="Accessibility options"/>">
	  		<li><a href="#mainContent" accesskey="C"><spring:message code="accessibility.skip.to.content" text="Skip to Content"/></a></li>
	  		<li><a href="#sidebar" accesskey="S"><spring:message code="accessibility.skip.to.sidebar" text="Skip to Sidebar"/></a></li>
			</ul> 
	    </div>
		<div id="cocoon">
			<div id="container">
				<tiles:insert name="header"/>
				<tiles:insert name="topmenu"/>
				<div id="content">
				
</c:if>       				
					<tiles:insert name="content"/>
<c:if test="${param['noHeaders']!=1}">					
					<tiles:insert name="breadcrumbs"/>
				</div><!--End content -->				
				<tiles:insert name="footer"/>
			</div><!-- End container-->
		</div><!-- End cocoon-->	
	<script type="text/javascript">
	  var uvOptions = {};
	  (function() {
	    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
	    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/lBPZH9vrbtDdBpMQsEctag.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
	  })();
	</script>
		
	</body>
</html>
</c:if>
