<%@ include file="/common/taglibs.jsp"%>
<div id="taxonomy" class="taxonomyContainer">
	<div id="twopartheader">
		<h2>
		<c:choose>
			<c:when test="${selectedConcept!=null}">
				<spring:message code="taxonomy.browser.classification.of"/> 
				<span class="subject"><string:capitalize><spring:message code="taxonrank.${selectedConcept.rank}"/></string:capitalize>: 
				<gbif:taxonPrint concept="${selectedConcept}"/></span> 
				${selectedConcept.author}
			</c:when>
			<c:otherwise>
				<spring:message code="taxonomy.browser.classification"/>
			</c:otherwise>
		</c:choose>
		</h2>
		<h3>
			<spring:message code="taxonomy.browser.species.recorded.in"/>:
			<a href="${pageContext.request.contextPath}/departments/${department.isoDepartmentCode}"><gbif:capitalize>${department.departmentName}</gbif:capitalize></a>
		</h3>
	</div>
	<c:choose>
		<c:when test="${not empty concepts}">
			<div id="furtherActions">
				<table cellspacing="0" class="actionsList">
					<tbody>
						<tr valign="top">
							<td><b><spring:message code="actions.explore"/></b></td>
							<td>	
								<ul class="actionsListInline">
									<li>
										<a href="${pageContext.request.contextPath}/species/search.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>&<gbif:criterion subject="9" predicate="0" value="7000" index="1"/>"><spring:message code="taxonomy.browser.species.recorded"/></a>						
									</li>						
									<li>
										<a href="${pageContext.request.contextPath}/species/search.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>"><spring:message code="taxonomy.browser.taxa.recorded.in"/></a>						
									</li>						
								</ul>
							</td>
						</tr>					
						<tr valign="top">
							<td><b><spring:message code="actions.download"/></b></td>
							<td>	
								<ul class="actionsListInline">
									<li>
										<a href="${pageContext.request.contextPath}/species/downloadSpreadsheet.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>&<gbif:criterion subject="9" predicate="0" value="7000" index="1"/>"><spring:message code="taxonomy.browser.species.recorded.in"/></a>						
									</li>						
									<li>
										<a href="${pageContext.request.contextPath}/species/downloadSpreadsheet.htm?<gbif:criterion subject="13" predicate="0" value="${department.isoDepartmentCode}"/>"><spring:message code="taxonomy.browser.taxa.recorded"/></a>						
									</li>						
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</div><!--end further actions-->		
			<div class="smalltree">
				<gbif:smallbrowser concepts="${concepts}" selectedConcept="${selectedConcept}" rootUrl="/species/browse/department/${department.isoDepartmentCode}" markConceptBelowThreshold="${dataProvider.key==nubProvider.key}" highestRank="kingdom" messageSource="${messageSource}" occurrenceManager="${occurrenceManager}"/>
			</div><!--end smalltree-->		
		</c:when>
		<c:otherwise>		
			<spring:message code="taxonomy.browser.notree"/> <gbif:capitalize>${department.departmentName}</gbif:capitalize>
		</c:otherwise>	
	</c:choose>	
</div>	