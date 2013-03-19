<%@ include file="/common/taglibs.jsp"%>

<a href="${pageContext.request.contextPath}/datasets/" class="confirm">
<img src="skins/standard/images/1649_ok.jpg" width="320" height="216" alt="DEPARTAMENTOS" />
<h2>
  <spring:message code="dataset.intro.heading"/>
  </h2>
<p>
  <spring:message code="dataset.intro.description"/>
</p>
<div>
<h3>
  <spring:message code="dataset.intro.summary"/>
</h3>
<p>
  <c:set var="a0">
  <span class="subject">${dataResourceCount}</span>
  </c:set>
  <c:set var="a1">
  <span class="subject">${dataProviderCount}</span>
  </c:set>
  <spring:message code="dataset.intro.description.counts" arguments="${a0},${a1}"/>
  <c:if test="${latestResource!=null}">
</p>
</div>
</a>
<div>

<h3>
  <spring:message code="dataset.intro.latestresourceadded"/>
</h3>
<a href="${pageContext.request.contextPath}/datasets/resource/${latestResource.key}/">${latestResource.name}</a>
</c:if>
</div>