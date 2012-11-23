<%@ include file="/common/taglibs.jsp"%>

<a href="${pageContext.request.contextPath}/species/">
    <img src="skins/standard/images/rana.jpg" width="320" height="218" alt="ESPECIES" />
<h2>
  <spring:message code="taxonomy.intro.heading"/>
 </h2>
<p>
  <spring:message code="taxonomy.intro.description"/>
</p>
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
  <h3>
    <spring:message code="taxonomy.intro.latestspeciesadded"/>
  </h3>
  <a href="${pageContext.request.contextPath}/species/species/Puma_concolor"><i>Puma concolor</i> (Linnaeus, 1771)</a></div>
