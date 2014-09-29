<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8"%>
<div id="exampleSearches">
<h4><spring:message code="occurrence.search.filter.example.searches"/></h4>
<ul id="exampleSearches" class="genericList" style="margin:0px;">

<li><a href="${pageContext.request.contextPath}/occurrences/search.htm?c[0].s=0&c[0].p=0&c[0].o=Puma+concolor&c[1].s=38&c[1].p=0&c[1].o=CO-AMA&c[2].s=17&c[2].p=0&c[2].o=7"><spring:message code="occurrence.search.filter.example.searches.pumaconcolor"/></a></li>

<li><a href="${pageContext.request.contextPath}/occurrences/search.htm?c[0].s=0&c[0].p=0&c[0].o=Didelphis+marsupialis&c[1].s=25&c[1].p=0&c[1].o=3&c[2].s=17&c[2].p=0&c[2].o=7"><spring:message code="occurrence.search.filter.example.searches.didelphismarsupialis"/></a></li>
</ul>
</div>