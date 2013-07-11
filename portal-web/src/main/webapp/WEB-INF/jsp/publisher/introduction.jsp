<%@ include file="/common/taglibs.jsp"%>


<a href="${pageContext.request.contextPath}/publicadores/" class="confirm">
<span><h2>
  <spring:message code="publisher.intro.heading"/>
  </h2>
  <p>
    <spring:message code="publisher.intro.description"/>
  </p>
</span>
<div>
<h3>
  <spring:message code="publisher.intro.summary"/>
</h3>
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
<h3>
  <spring:message code="publisher.intro.latestresourceadded"/>
</h3>
${latestProvider.name}</a>
</c:if>
</div>