<%@ include file="/common/taglibs.jsp"%>
<!--<h3><spring:message code="blanket.search"/></h3>
<p><spring:message code="blanket.search.hint"/></p> -->

<form name="quickSearchForm" method="get" onsubmit="return submitQuickSearch(false);" action="${pageContext.request.contextPath}/search/blanketSearch.htm">
	<input id="query" name="keyword" <c:if test="${not empty searchString}">value="${searchString}"</c:if> placeholder="<spring:message code="blanket.search.placeholder"/>" autosave="gbif.blanketsearch" results="5" tabindex="1"/>
	<a href="javascript:submitFromLinkQuickSearch();" id="go"><!--<spring:message code="blanket.search.go"/>--></a>
	<a href="${pageContext.request.contextPath}/occurrences" class="adv_busqueda">
		<img src="${pageContext.request.contextPath}/skins/standard/images/ico_lupita.png" />
  <spring:message code="topmenu.occurrences"/>
  </a>
</form>

<script type="text/javascript">
	document.getElementById("query").focus();
	
	function submitQuickSearch(formSubmit){
		//check for empty value
		var textValue = document.getElementById('query').value;
		if(textValue!=null && textValue.length>0){
			if(formSubmit)
				document.quickSearchForm.submit();
			return true;
		}
		return false;
	}
	
	function submitFromLinkQuickSearch(){
		//check for empty value
		var textValue = document.getElementById('query').value;
		if(textValue!=null && textValue.length>0){
				document.quickSearchForm.submit();
		}
	}	
	
</script>