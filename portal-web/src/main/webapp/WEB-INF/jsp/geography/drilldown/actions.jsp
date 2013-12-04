<%@ include file="/common/taglibs.jsp"%>
<c:if test="${country.occurrenceCount>0}">	
<div id="furtherActions">
	<%-- title hidden  <h4><spring:message code='actions.for'/> <gbif:capitalize><spring:message code="country.${country.isoCountryCode}"/>	</gbif:capitalize></h4> --%>
	<table cellspacing="0" class="actionsList">
		<tbody>
			<tr valign="top">
				<th><spring:message code="actions.explore"/></th>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/search.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>"><spring:message code="explore.occurrences"/></a>
						</li>						
						<li>
							<a href="${pageContext.request.contextPath}/species/browse/country/${country.isoCountryCode}"><spring:message code="geography.drilldown.view.taxonomy.registered"/></a>
						</li>
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<th><spring:message code="actions.list"/></th>
				<td>
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/searchResources.htm?<gbif:criterion subject="5" predicate="0" value="${country.isoCountryCode}" index="0"/>"><spring:message code="geography.drilldown.list.data.resources"/></a>
						</li>
					</ul>
				</td>
			</tr>
			<tr valign="top">
				<th><spring:message code="actions.download"/></th>
				<td>	
					<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/country/celldensity/country-celldensity-${country.isoCountryCode}.kml"><spring:message code="download.google.earth.celldensity"/></a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/occurrences/country/placemarks/country-placemarks-${country.isoCountryCode}.kml"><spring:message code="download.google.earth.placemarks"/></a>
						</li>	
	
						<li>
							<a href="${pageContext.request.contextPath}/ws/rest/provider/list?isocountrycode=${country.isoCountryCode}"><spring:message code="download.metadata.for.publishers"/></a>
						</li>
					</ul>
				</td>
			</tr>
				<!--
				<tr valign="top">
					<th><spring:message code="actions.webservice"/></th>
						<td>
						<ul class="actionsListInline">
						<li>
							<a href="${pageContext.request.contextPath}/ws/rest/occurrence/list/?originIsoCountryCode=${country.isoCountryCode}&format=darwin"><spring:message code="download.darwin.core"/></a>
						</li>	
						<%--<li>
							<a href="${pageContext.request.contextPath}/ws/rest/occurrence/list/?hostIsoCountryCode=${country.isoCountryCode}&format=darwin"><spring:message code="download.darwin.core.from.served.by.providers"/> <span class='subject'><gbif:capitalize><spring:message code="country.${country.isoCountryCode}"/></gbif:capitalize></span></a>
						</li>--%>
						</ul>
					</td>
				</tr>	
				-->
		</tbody>
	</table>
</div>
</c:if>