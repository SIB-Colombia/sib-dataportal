<%@ include file="/common/taglibs.jsp"%>


<a href="${pageContext.request.contextPath}/conjuntos/" class="confirm">
<span><h2>
  <spring:message code="dataset.intro.heading"/>
  </h2>
  <p>
    <spring:message code="dataset.intro.description"/>
  </p>
</span>
<div>
<h3>
  <spring:message code="dataset.intro.summary"/>
</h3>
<p>
  <c:set var="a0">
  <strong class="subject">${dataResourceCount}</strong>
  </c:set>
  <c:set var="a1">
  <strong class="subject">${dataProviderCount}</strong>
  </c:set>
  <spring:message code="dataset.intro.description.counts" arguments="${a0},${a1}"/>
  <c:if test="${latestResource!=null}">
</p>
</div>
</a>

<div>
<a href="${pageContext.request.contextPath}/datasets/resource/${latestResource.key}/"  >
<h3>
  <spring:message code="dataset.intro.latestresourceadded"/>
</h3>
${latestResource.name}</a>
</c:if>
</div>