<%@ include file="/common/taglibs.jsp"%>
<a href="${pageContext.request.contextPath}/departamentos/" class="confirm">
<span>
    <h2>
      <spring:message code="departments.intro.heading"/>
      </h2>
       <p>
    <strong><spring:message code="departments.intro.description"/></strong>
  </p>
</span>
<div>
  <p>
    <c:set var="a0">
  <div class="subject"></div>
    <fmt:formatNumber value="${noOfCountries}" pattern="###,###"/>
  </c:set>
  <c:set var="a1">
  <div class="subject">0</div>
  </c:set>
  <c:set var="a2">
  <div class="subject">0</div>
  </c:set>
  <spring:message code="geography.intro.description1" arguments="${a0},${a1},${a2}"/>
  </p>

</div>
</a>
<div>alala</div>




  <%-- This was commented since it must be a recognition of the userDepartment in Colombia  
  <c:choose>
    <c:when test="${not empty userCountry}">
      </p>
      <a href="${pageContext.request.contextPath}/countries/${userCountry.isoCountryCode}">
      <spring:message code="country.${userCountry.isoCountryCode}"/>
      </a> </c:when>
    <c:otherwise> <a href="${pageContext.request.contextPath}/countries/FR">
      <spring:message code="country.FR"/>
      </a> </c:otherwise>
  </c:choose>
  --%>

