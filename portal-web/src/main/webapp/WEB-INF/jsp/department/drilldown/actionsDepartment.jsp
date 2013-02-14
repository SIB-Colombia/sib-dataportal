<%@ include file="/common/taglibs.jsp"%>
<c:if test="${department.occurrenceCount>0}">	
<div id="furtherActions">
	<table cellspacing="0" class="actionsList">
		<tbody>
			<tr valign="top">
				<th><spring:message code="actions.explore"/></th>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"><spring:message code="explore.occurrences"/></a>
						</li>	
						
						<li>
							<a href="${pageContext.request.contextPath}/species/search.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>&<gbif:criterion subject="9" predicate="0" value="7000" index="1"/>"><spring:message code="taxonomy.browser.species.recorded"/></a>						
						</li>						
						<li>
							<a href="${pageContext.request.contextPath}/species/search.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>"><spring:message code="taxonomy.browser.taxa.recorded"/></a>						
						</li>					
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<th><spring:message code="actions.list"/></th>
				<td>
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/searchResources.htm?<gbif:criterion subject="38" predicate="0" value="${department.isoDepartmentCode}" index="0"/>"><spring:message code="geography.drilldown.list.data.resources"/></a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/species/browse/department/${department.isoDepartmentCode}"><spring:message code="geography.drilldown.view.taxonomy.registered"/></a>
						</li>
						
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<th><spring:message code="actions.download"/></th>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/department/celldensity/department-celldensity-${department.isoDepartmentCode}.kml"><spring:message code="download.google.earth.celldensity"/></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/department/placemarks/department-placemarks-${department.isoDepartmentCode}.kml"><spring:message code="download.google.earth.placemarks"/></a>
						</li>	

						
						<li>
							<a href="${pageContext.request.contextPath}/species/downloadSpreadsheet.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>&<gbif:criterion subject="9" predicate="0" value="7000" index="1"/>"><spring:message code="taxonomy.browser.species.recorded"/></a>						
						</li>						
						<li>
							<a href="${pageContext.request.contextPath}/species/downloadSpreadsheet.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>"><spring:message code="taxonomy.browser.taxa.recorded"/></a>						
						</li>
						
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<th><spring:message code="actions.webservice"/></th>
				<td>
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/ws/rest/occurrence/list/?originIsoDepartmentCode=${department.isoDepartmentCode}&format=darwin"><spring:message code="download.darwin.core"/></a>
						</li>
					</ul>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</c:if>