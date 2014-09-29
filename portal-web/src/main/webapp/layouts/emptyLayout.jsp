<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
 <script src="${pageContext.request.contextPath}/javascript/jquery-1.9.1.js" type="text/javascript" language="javascript"></script>
 <script src="${pageContext.request.contextPath}/javascript/jconf.jquery.js" type="text/javascript" language="javascript"></script>
 

<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set> 
<c:set var="cpth">${pageContext.request.contextPath}</c:set>
<c:set var="pth">${requestScope['javax.servlet.forward.request_uri']}</c:set>
<c:set var="pge">${fn:substring(pth,fn:length(cpth),fn:length(pth))}</c:set>
<c:set var="urlt" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}"/>

<!DOCTYPE HTML >
<c:if test="${param['noHeaders']!=1}">
<html>
	<!-- GBIF Portal Version: <gbif:propertyLoader bundle="portal" property="version"/> -->	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	
	</head>
	<body>
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
	</body>
</html>		
</c:if> 