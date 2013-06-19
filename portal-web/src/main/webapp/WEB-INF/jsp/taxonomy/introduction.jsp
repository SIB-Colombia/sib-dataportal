<%@ include file="/common/taglibs.jsp"%>


<a href="${pageContext.request.contextPath}/especies/" class="confirm">

<span><h2>
  <spring:message code="taxonomy.intro.heading"/>
 </h2>
<p>
  <strong><spring:message code="taxonomy.intro.description"/></strong>
</p></span>
<div>
  <h3>
    <spring:message code="taxonomy.intro.summary"/>
  </h3>
  <p>
    <spring:message code="taxonomy.intro.description1"/>
  </p>
</div>
 </a>
<div>
  <a href="${pageContext.request.contextPath}/especies/Puma_concolor" >
    <h4>
    <spring:message code="taxonomy.intro.latestspeciesadded"/>
  </h4>
  <i>Puma concolor</i> (Linnaeus, 1771)</a></div>
