<%@ include file="/common/taglibs.jsp"%>
<div class="otherDetailsFilterHelp">
<c:set var="addFilterMsg"><spring:message code="search.filter.add.filter"/></c:set>
<spring:message code="occurrence.basisOfRecord.help1" arguments="${addFilterMsg}" argumentSeparator="$$$"/>
<spring:message code="occurrence.basisOfRecord.help2"/>
<ul class="helpList">
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.observation"/></span> <spring:message code="occurrence.basisOfRecord.observation.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.specimen"/></span> <spring:message code="occurrence.basisOfRecord.specimen.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.living"/></span> <spring:message code="occurrence.basisOfRecord.living.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.germplasm"/></span> <spring:message code="occurrence.basisOfRecord.germplasm.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.fossil"/></span> <spring:message code="occurrence.basisOfRecord.fossil.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.preservedspecimen"/></span> <spring:message code="occurrence.basisOfRecord.preservedspecimen.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.fossilspecimen"/></span> <spring:message code="occurrence.basisOfRecord.fossilspecimen.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.livingspecimen"/></span> <spring:message code="occurrence.basisOfRecord.livingspecimen.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.humanobservation"/></span> <spring:message code="occurrence.basisOfRecord.humanobservation.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.machineobservation"/></span> <spring:message code="occurrence.basisOfRecord.machineobservation.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.stillimage"/></span> <spring:message code="occurrence.basisOfRecord.stillimage.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.movingimage"/></span> <spring:message code="occurrence.basisOfRecord.movingimage.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.soundrecording"/></span> <spring:message code="occurrence.basisOfRecord.soundrecording.description"/></li>
	<li><span class="subject"><spring:message code="occurrence.basisOfRecord.otherspecimen"/></span> <spring:message code="occurrence.basisOfRecord.otherspecimen.description"/></li>
</ul>
</div>