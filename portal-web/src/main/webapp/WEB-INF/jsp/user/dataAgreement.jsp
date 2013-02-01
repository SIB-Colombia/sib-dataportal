<%@ include file="/common/taglibs.jsp"%>
<div id="twopartheader">
	<h2><spring:message code="dataagreement.title" text="Data Use Agreement"/></h2>
</div>

<div class="white_rounded_frame" style="margin-top:-40px;">
<spring:message code="dataagreement.content" text="Data Use Agreement Content"/>

<form method="post" action="terms.htm" form="acceptForm" class="acceptForm">
  <input type="hidden" name="forwardUrl" value="${param['forwardUrl']}"/>
  <input type="submit" name="acceptedTerms" value="<spring:message code="dataagreement.accept"/>"/>
  <input type="submit" name="refuseTerms" value="<spring:message code="dataagreement.cancel"/>"/>
</form>

<p><spring:message code="dataagreement.cookie.warning" text="Depending on your browser settings, a cookie may be stored to acknowledge your acceptance of these terms."/></p>
</div>