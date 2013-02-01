<%@ include file="/common/taglibs.jsp"%>
<c:if test="${resourceNetwork.occurrenceCount>0}">
<div id="furtherActions">
	<%-- title hidden <h4><spring:message code='actions.for'/> ${resourceNetwork.name}</h4>--%>
	<table cellspacing="0" class="actionsList">
		<tbody>
			<tr valign="top">
				<th><spring:message code="actions.explore"/></th>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="26" predicate="0" value="${resourceNetwork.key}" index="0"/>"><spring:message code="explore.occurrences"/></a>
						</li>
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<th><spring:message code="actions.download"/> </th>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/network/celldensity/network-celldensity-${resourceNetwork.key}.kml"><spring:message code="download.google.earth.celldensity"/></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/network/placemarks/network-placemarks-${resourceNetwork.key}.kml"><spring:message code="download.google.earth.placemarks"/></a>
						</li>	
					</ul>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</c:if>