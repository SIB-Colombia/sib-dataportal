/***************************************************************************
 * Copyright (C) 2005 Global Biodiversity Information Facility Secretariat.
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package net.sibcolombia.portal.web.controller.taxonomy;

import org.gbif.portal.dto.taxonomy.BriefTaxonConceptDTO;
import org.gbif.portal.dto.taxonomy.TaxonConceptDTO;
import org.gbif.portal.service.OccurrenceManager;
import org.gbif.portal.service.TaxonomyManager;
import org.gbif.portal.web.controller.RestKeyValueController;
import org.gbif.portal.web.util.TaxonConceptUtils;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sibcolombia.portal.dto.department.DepartmentDTO;
import net.sibcolombia.portal.service.DepartmentManager;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * Department Taxonomy Browser. TODO this class should be factored out and the
 * TaxonomyBrowseController should handle both resource taxonomies and
 * department taxonomies.
 * 
 * @author dmartin
 */
public class DepartmentTaxonomyBrowseController extends RestKeyValueController {

	/** Taxonomy Manager providing tree and taxonConcept lookup */
	protected TaxonomyManager taxonomyManager;
	/** Taxonomy Manager providing tree and taxonConcept lookup */
	protected TaxonConceptUtils taxonConceptUtils;
	/** Department Manager providing department lookup */
	protected DepartmentManager departmentManager;
	/** The request properties taxon concept key */
	protected String departmentPropertyKey = "department";
	/** The request properties taxon concept key */
	protected String taxonConceptPropertyKey = "taxon";
	/** Threshold used to determining rendering */
	protected String taxonPriorityThresholdModelKey = "taxonPriorityThreshold";
	/** Threshold used to determining rendering */
	protected int taxonPriorityThreshold = 20;

	protected MessageSource messageSource;
	
	/** Addition by SiBBr: occurrenceManager for the taxonomy occurrences calculation */
	protected OccurrenceManager occurrenceManager;
	/** Addition by SiBBr: occurrenceManager for the taxonomy occurrences calculation */
	protected String occurrenceManagerModelKey = "occurrenceManager";

	/**
	 * @see org.gbif.portal.web.controller.RestController#handleRequest(java.util.Map,
	 *      javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public ModelAndView handleRequest(Map<String, String> propertiesMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("Viewing department taxonomy");
		String departmentCode = propertiesMap.get(departmentPropertyKey);
		String taxonConceptKey = propertiesMap.get(taxonConceptPropertyKey);
		// Create the view
		ModelAndView mav = resolveAndCreateView(propertiesMap, request, false);
		if (departmentCode == null) {
			return redirectToDefaultView();
		}

		// Locale locale = RequestContextUtils.getLocale(request);
		DepartmentDTO departmentDTO = departmentManager
				.getDepartmentFor(departmentCode);
		logger.debug(departmentDTO);
		if (departmentDTO == null)
			redirectToDefaultView();
		mav.addObject("department", departmentDTO);
		mav.addObject("messageSource", messageSource);

		if (taxonConceptKey != null && departmentCode != null) {
			TaxonConceptDTO selectedConcept = taxonomyManager
					.getTaxonConceptFor(taxonConceptKey);
			mav.addObject("selectedConcept", selectedConcept);
			if (logger.isDebugEnabled()) {
				logger.debug(selectedConcept);
			}
			if (selectedConcept == null)
				redirectToDefaultView();
			List<BriefTaxonConceptDTO> concepts = taxonomyManager
					.getClassificationForDepartment(taxonConceptKey, false,
							departmentCode, true);
			List<BriefTaxonConceptDTO> childConcepts = taxonomyManager
					.getChildConceptsForDepartment(taxonConceptKey,
							departmentCode, true);
			taxonConceptUtils.organiseUnconfirmedNames(request,
					selectedConcept, concepts, childConcepts,
					taxonPriorityThreshold);
			mav.addObject("concepts", concepts);
		} else if (departmentCode != null) {
			List<BriefTaxonConceptDTO> concepts = taxonomyManager
					.getRootTaxonConceptsForDepartment(departmentCode);
			mav.addObject("concepts", concepts);
		} else {
			return redirectToDefaultView();
		}

		// Addition by SiBBr: #issue31 fixing Department Taxonomy Browse
		mav.addObject(occurrenceManagerModelKey, occurrenceManager);
		return mav;
	}

	/**
	 * @param departmentManager
	 *            the departmentManager to set
	 */
	public void setDepartmentManager(DepartmentManager departmentManager) {
		this.departmentManager = departmentManager;
	}

	/**
	 * @param countryPropertyKey
	 *            the countryPropertyKey to set
	 */
	public void setDepartmentPropertyKey(String departmentPropertyKey) {
		this.departmentPropertyKey = departmentPropertyKey;
	}

	/**
	 * @param messageSource
	 *            the messageSource to set
	 */
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	/**
	 * @param taxonConceptPropertyKey
	 *            the taxonConceptPropertyKey to set
	 */
	public void setTaxonConceptPropertyKey(String taxonConceptPropertyKey) {
		this.taxonConceptPropertyKey = taxonConceptPropertyKey;
	}

	/**
	 * @param taxonConceptUtils
	 *            the taxonConceptUtils to set
	 */
	public void setTaxonConceptUtils(TaxonConceptUtils taxonConceptUtils) {
		this.taxonConceptUtils = taxonConceptUtils;
	}

	/**
	 * @param taxonomyManager
	 *            the taxonomyManager to set
	 */
	public void setTaxonomyManager(TaxonomyManager taxonomyManager) {
		this.taxonomyManager = taxonomyManager;
	}

	/**
	 * @param taxonPriorityThreshold
	 *            the taxonPriorityThreshold to set
	 */
	public void setTaxonPriorityThreshold(int taxonPriorityThreshold) {
		this.taxonPriorityThreshold = taxonPriorityThreshold;
	}

	/**
	 * @param taxonPriorityThresholdModelKey
	 *            the taxonPriorityThresholdModelKey to set
	 */
	public void setTaxonPriorityThresholdModelKey(
			String taxonPriorityThresholdModelKey) {
		this.taxonPriorityThresholdModelKey = taxonPriorityThresholdModelKey;
	}

	/**
	 * Addition by SiBBr: #issue31 fixing Department Taxonomy Browse
	 * 
	 * @param occurrenceManager
	 *            the occurrenceManager to set
	 */
	public void setOccurrenceManager(OccurrenceManager occurrenceManager) {
		this.occurrenceManager = occurrenceManager;
	}
}