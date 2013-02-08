<%@ include file="/common/taglibs.jsp"%>
<c:if test="${dataProvider.occurrenceCount>0 || (not empty dataResources && dataResources[0].sharedTaxonomy)}">	
<div id="furtherActions">
	<%-- title hidden <h4><spring:message code='actions.for'/> ${dataProvider.name}</h4> --%>
	<table cellspacing="0" class="actionsList">
		<tbody>
			<tr valign="top">
				<th><spring:message code="actions.explore"/></th>
				<td>	
					<ul class="actionsListInline">
						<c:if test="${dataProvider.occurrenceCount>0}">	
							<li>
								<a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="25" predicate="0" value="${dataProvider.key}" index="0"/>"><spring:message code="explore.occurrences"/></a>
							</li>
						</c:if>
						<c:if test="${not empty dataResources && dataResources[0].sharedTaxonomy}">
							<li>
								<a href="${pageContext.request.contextPath}/species/browse/provider/${dataProvider.key}"><spring:message code="dataset.taxonomytreelink" arguments="${dataProvider.name}" argumentSeparator="%%%%"/></a>
							</li>
						</c:if>
					</ul>
				</td>
			</tr>
			<c:if test="${dataProvider.occurrenceCoordinateCount>0}">
				<tr valign="top">
					<th><spring:message code="actions.download"/></th>
					<td>	
						<ul class="actionsListInline">
								
							<li>
								<a href="${pageContext.request.contextPath}/occurrences/provider/celldensity/provider-celldensity-${dataProvider.key}.kml" onclick="_gaq.push(['_trackEvent', 'publisher', 'download', 'kml'])"><spring:message code="download.google.earth.celldensity"/></a>
							</li>	
							<li>
								<a href="${pageContext.request.contextPath}/occurrences/provider/placemarks/provider-placemarks-${dataProvider.key}.kml" onclick="_gaq.push(['_trackEvent', 'publisher', 'download', 'kml']);" ><spring:message code="download.google.earth.placemarks"/></a>
							</li>
						</ul>
					</td>
				</tr>
				<tr valign="top">
					<th><spring:message code="actions.webservice"/></th>
						<td>
						<ul class="actionsListInline">
							<li>
								<a href="${pageContext.request.contextPath}/ws/rest/occurrence/list/?dataProviderKey=${dataProvider.key}&format=darwin" onclick="_gaq.push(['_trackEvent', 'publisher', 'download', 'DwC']);"><spring:message code="download.darwin.core"/></a>
							</li>
						</ul>
					</td>
				</tr>	
			</c:if>	
		</tbody>
	</table>
</div>
</c:if>