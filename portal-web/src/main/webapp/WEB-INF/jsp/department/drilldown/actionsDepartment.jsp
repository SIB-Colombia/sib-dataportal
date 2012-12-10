<%@ include file="/common/taglibs.jsp"%>
<c:if test="${department.occurrenceCount>0}">	
<div id="furtherActions">
	<table cellspacing="1" class="actionsList">
		<tbody>
			<tr valign="top">
				<td><b><spring:message code="actions.explore"/></b></td>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"><spring:message code="explore.occurrences"/></a>
						</li>						
						<li>
							<c:set var="a0">
								<span class='subject'><gbif:capitalize><spring:message code="department.${department.isoDepartmentCode}"/></gbif:capitalize></span>
							</c:set>
							<a href="${pageContext.request.contextPath}/species/browse/department/${department.isoDepartmentCode}"><spring:message code="geography.drilldown.view.taxonomy" text="Explore species recorded in "/> <span class="subject"><spring:message code="department.${department.isoDepartmentCode}"/></span></a>
						</li>
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<td><b><spring:message code="actions.list"/></b></td>
				<td>
					<ul class="actionsListInline">
						<li>
							<c:set var="a0">
								<span class='subject'><gbif:capitalize><spring:message code="department.${department.isoDepartmentCode}"/></gbif:capitalize></span>
							</c:set>
							<a href="${pageContext.request.contextPath}/occurrences/searchResources.htm?<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"><spring:message code="geography.drilldown.list.resources" arguments="${a0}"/></a>
						</li>
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<td><b><spring:message code="actions.download"/></b></td>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/department/celldensity/department-celldensity-${department.isoDepartmentCode}.kml"><spring:message code="download.google.earth.celldensity"/></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/department/placemarks/department-placemarks-${department.isoDepartmentCode}.kml"><spring:message code="download.google.earth.placemarks"/></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/ws/rest/occurrence/list/?originIsoDepartmentCode=${department.isoDepartmentCode}&format=darwin"><spring:message code="download.darwin.core"/></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/ws/rest/occurrence/list/?hostIsoDepartmentCode=${department.isoDepartmentCode}&format=darwin"><spring:message code="download.darwin.core.from.served.by.providers"/> <span class='subject'><gbif:capitalize><spring:message code="department.${department.isoDepartmentCode}"/></gbif:capitalize></span></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/ws/rest/provider/list?isoDepartmentcode=${department.isoDepartmentCode}"><spring:message code="download.metadata.for.providers" text="Download metadata for data providers in "/> <span class='subject'><gbif:capitalize><spring:message code="department.${department.isoDepartmentCode}"/></gbif:capitalize></span></a>
						</li>
					</ul>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</c:if>