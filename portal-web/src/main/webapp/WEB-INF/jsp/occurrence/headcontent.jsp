<%@ include file="/common/taglibs.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='speciesGlobal.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='filters.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='tables.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='googlemap.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='gbifmap.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='tree.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='autocomplete.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='wizards.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='download.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='occurrenceSpecial.css'/>"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/<spring:theme code='jquery-ui-1.10.2.custom.css'/>"/>
<link rel="Shortcut Icon" href="${pageContext.request.contextPath}/favicon.ico" />

<script src="${pageContext.request.contextPath}/javascript/jquery.colorbox-min.js" type="text/javascript" language="javascript"></script>

<script type="text/javascript">
$(document).ready(function() {
		//Examples of how to assign the Colorbox event to elements
		$(".group1").colorbox({rel:'group1', transition:"fade"});
		$(".group2").colorbox({rel:'group2', transition:"fade"});
		$(".group3").colorbox({rel:'group3', transition:"fade"});
		$(".group4").colorbox({rel:'group4', transition:"fade"});
		$(".group5").colorbox({rel:'group5', transition:"fade"});
		$(".tut_selector").colorbox({inline:true, width:"50%"});

		$('.faq').click(function() {
        $(".g5").colorbox({open:true});
     });
	});

</script>

<tiles:insert page="/common/scripts.jsp"/>
