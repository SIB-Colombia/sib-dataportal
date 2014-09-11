<%@ include file="/common/taglibs.jsp"%>


<a href="${pageContext.request.contextPath}/publicadores/" class="confirm">
<span><h2>
  <spring:message code="publisher.intro.heading"/>
  </h2>
  <p>
    <strong><spring:message code="publisher.intro.description"/></strong>
  </p>
</span>
<div>
<p>
  <c:set var="a0">
  <strong class="subject">${dataResourceCount}</strong>
  </c:set>
  <c:set var="a1">
  <strong class="subject">${dataProviderCount}</strong>
  </c:set>
  <spring:message code="publisher.intro.description.counts" arguments="${a1}"/>
  <c:if test="${latestProvider!=null}">
</p>
</div>
</a>
<div>
<a href="${pageContext.request.contextPath}/publicadores/provider/${latestProvider.key}/" class="confirm" >
<h4>
  <spring:message code="publisher.intro.latestresourceadded"/>
</h4>
${latestProvider.name}</a>
</c:if>
</div>