<%@ include file="/common/taglibs.jsp"%>

<a href="${pageContext.request.contextPath}/departments/">
<img src="skins/standard/images/mariposas.jpg" width="320" height="215" alt="MARIPOSAS" />
<h2>
  <spring:message code="departments.intro.heading"/>
  </h2>
<p>
  <spring:message code="departments.intro.description"/>
</p>
<div>
  <h3>
    <spring:message code="departments.intro.summary"/>
  </h3>
  <p>
    <c:set var="a0">
  <div class="subject">
    <fmt:formatNumber value="${noOfCountries}" pattern="###,###"/>
  </div>
  </c:set>
  <c:set var="a1">
  <div class="subject">0</div>
  </c:set>
  <c:set var="a2">
  <div class="subject">0</div>
  </c:set>
  <spring:message code="geography.intro.description1" arguments="${a0},${a1},${a2}"/>
</div>
</a>
<div>
  <h3>
    <spring:message code="geography.intro.seedatafor"/>
  </h3>
   <a href="${pageContext.request.contextPath}/departments/CO-AMA">
      <spring:message code="department.CO-AMA" text="Amazonas"/></a>
</div>
