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
package org.gbif.portal.web.controller.filter;

import org.gbif.portal.dto.PropertyStoreTripletDTO;
import org.gbif.portal.dto.util.SearchConstraints;
import org.gbif.portal.io.OutputProperty;
import org.gbif.portal.service.triplet.TripletQueryManager;
import org.gbif.portal.util.propertystore.PropertyStore;
import org.gbif.portal.web.content.filter.TripletQuery;
import org.gbif.portal.web.controller.RestController;
import org.gbif.portal.web.download.DownloadUtils;
import org.gbif.portal.web.download.Field;
import org.gbif.portal.web.download.FileWriterFactory;
import org.gbif.portal.web.filter.CriteriaDTO;
import org.gbif.portal.web.filter.CriteriaUtil;
import org.gbif.portal.web.filter.FilterMapWrapper;
import org.gbif.portal.web.filter.FilterUtils;
import org.gbif.portal.web.util.QueryHelper;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import java.io.InputStream;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import org.json.*;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.entity.ContentType;
import org.apache.http.protocol.HTTP;

/**
 * Controller that supports the download of filter query results in multiple formats.
 * 
 * @author dmartin
 */
public class FilterDownloadController extends RestController {

  protected static Log logger = LogFactory.getLog(FilterDownloadController.class);
  /** Filters to use */
  protected FilterMapWrapper filters;
  /** Fields available for download */
  protected List<Field> downloadFields;
  /** Views of different formats */
  protected Map<String, View> downloadViews;
  /** QueryHelper to produce triplets */
  protected QueryHelper queryHelper;
  /** Message source for i18n messages */
  protected MessageSource messageSource;
  /** Configurable download limit */
  protected int maxResultsDownload = 50000;
  /** results model key */
  protected String criteriaRequestKey = "criteria";
  /** request fields model key */
  protected String requestedFieldsModelKey = "requestedFields";
  /** The record count to retrieve */
  protected String recordCountRequestKey = "recordCount";
  /** The g recaptcha response */
  protected String recaptchaResponse = "recaptcha_response_field";
  protected String recaptchaChallengeResponse = "recaptcha_challenge_field";
  
  protected String email = "user_email";
  protected String downloadReasonListKey = "downloadReasonList";
  protected String googleRecaptchaKey = "googleRecaptchaKey";
  /** Max download overide */
  protected String maxDownloadOverrideRequestKey = "maxDownloadOverride";
  /** The download format - used to chose the FileWriterFactory instance */
  protected String formatRequestKey = "format";
  /** The search id request key */
  protected String searchIdRequestKey = "searchId";
  /** allFields request key - allowing all the fields to be downloaded without specifying */
  protected String allFieldsRequestKey = "allFields";
  /** The file name prefix for the prepared file */
  protected String downloadFilenamePrefix = "occurrence-search-";
  /** Whether downloads should be zipped */
  protected boolean zipped = true;
  /** The property store to use */
  protected PropertyStore propertyStore;
  /** The property store namespace to use for the downloads - defaults to the namespace for occurrences */
  protected String namespace = "http://gbif.org/portal-service/occurrenceOutput/2006/1.0";
  /** The service layer property store key for the download fields */
  protected String downloadFieldPSKey = "downloadFields";
  /** Maps formats to a FileWriterFactory */
  protected Map<String, FileWriterFactory> format2FileWriterFactories;
  /** Maps formats to a query manager */
  protected Map<String, TripletQueryManager> format2TripletQueryManager;
  /** The view to direct to once the thread has been started */
  protected String prepareView = "occurrenceDownloadPreparing";
  /** Whether or conditions should be met for the query or any */
  protected boolean matchAll = true;
  /** The file extension for zipped files */
  protected String zippedFileExtension = ".zip";
  /** The base url that this search can be traced to e.g. occurrences/search.htm? */
  protected String searchUrl;
  /** Whether or not time taken should be displayed for this download */
  protected boolean displayTimeTaken = true;
  /** i18n property used in the download descriptor file */
  protected String downloadFileType;

  /**
   * @see org.gbif.portal.web.controller.RestController#handleRequest(java.util.Map,
   *      javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
   */
  @Override
  public ModelAndView handleRequest(Map<String, String> propertiesMap, HttpServletRequest request,
    HttpServletResponse response) throws Exception {
	
	int statusCodeDatos = 400;
	String recaptcha = request.getParameter(recaptchaResponse);
	String challenge = request.getParameter(recaptchaChallengeResponse);
	// unravel the criteria
    Locale locale = new Locale("en");
    String criteriaString = request.getParameter(criteriaRequestKey);
    CriteriaDTO criteria = CriteriaUtil.getCriteria(criteriaString, filters.getFilters(), locale);
    // fix criteria value
    CriteriaUtil.fixEncoding(request, criteria);
    // retrieve the query description
    String queryDescription = FilterUtils.getQueryDescriptionObjectWithOutMessage(filters.getFilters(), criteria, messageSource, locale);
    logger.debug("queryDescription: " + queryDescription);
	
    try {
	    String[] parts = queryDescription.split(",");
	    logger.debug("parts:" + parts.length);
	    
	    JSONObject obj1 = new JSONObject();
	    for(int i = 0;i < parts.length; i++){
	    	logger.debug("parts: " + parts[i]);
	    	for(int j = i+1;j < parts.length; j++){
	    		if(!(parts[j].contains(" includes ")||parts[j].contains("or ")||parts[j].contains("is ")||parts[j].contains(" greater than ")||parts[j].contains(" less than "))){
		    		parts[j] = parts[i].concat(",".concat(parts[j]));
		    		i = j;
		    	}else{
		    		break;
		    	}
	    	}
	    	logger.debug("parts after for: " + parts[i]);
	    	if(parts[i].contains("(")){
	    		String[] subparts_1 = new String[100];
	    		subparts_1 = parts[i].split("\\(");
	    		parts[i] = subparts_1[0].trim();
	    		if(subparts_1.length>2){
	    			for(int j=1;j<(subparts_1.length)-1;j++){
	    				if(subparts_1[j].contains(")")){
			    			parts[i] = parts[i].concat(" (".concat(subparts_1[j]));
			    			parts[i] = parts[i].trim();
	    				}
	    			}
	    		}
	    	}
	    	logger.debug("parts after if: " + parts[i]);
	    	
	    	String[] subparts = new String[100];
    	    String textName;
    	    String predicado = "eq";
    	    JSONArray arr = new JSONArray();
    	    JSONObject textObject = new JSONObject();
	    	
    	    if(parts[i].contains(" includes ")){
	    		subparts = parts[i].split(" includes ");
	    		String[] subparts_taxon = subparts[1].split(": ");
	    		textObject.put("predicate", predicado);
	    		textObject.put("textName", subparts_taxon[0]);
	    		textObject.put("textObject",subparts_taxon[1]);
	    		arr.put(textObject);
	    		if(i+1<parts.length){
	    			if(parts[i+1].trim().startsWith("or")){
    	    			i = i +1;
    	    			while(parts[i].trim().startsWith("or")){
    	    				logger.debug("parts: " + parts[i]);
    	    				JSONObject classification_or = new JSONObject();
    	    				subparts = parts[i].split("or ");
    	    				String[] subparts_taxon_or = subparts[1].split(": ");
    	    				classification_or.put("predicate", predicado);
    	    				classification_or.put("textName", subparts_taxon_or[0]);
    	    				classification_or.put("textObject", subparts_taxon_or[1]);
    	    		    		arr.put(classification_or);
    	    	    		if(i+1<parts.length){
    	    	    			if(parts[i+1].trim().startsWith("or")){
    	    	    				i = i+1;
    	    	    			}
    	    	    		}else{
    	    	    			break;
    	    	    		}
    	    	    	}
	    			}
	    		}
	    		obj1.put("taxons",arr); 	
	    	}else {
	    		if(parts[i].contains(" is ")){
    	    		subparts = parts[i].split(" is ");
	    		}else if (parts[i].contains(" greater than ")){
    	    		subparts = parts[i].split(" greater than ");
    	    		predicado = "gt";
	    		}else if(parts[i].contains(" less than ")){
    	    		subparts = parts[i].split(" less than ");
    	    		predicado = "lt";
	    		}
	    		textName = subparts[0].replaceAll(" ","").toLowerCase();
	    		if(textName.equals("stateorprovince")){
	    			textName = "department";
	    			textObject.put("predicate", predicado);
    	    		textObject.put("textName", textName);
    	    		textObject.put("textObject",subparts[1]);
	    		}else if(textName.equals("complex")){
	    			textName = "paramo";
	    			textObject.put("predicate", predicado);
    	    		textObject.put("textName", textName);
    	    		textObject.put("textObject",subparts[1]);
	    		}else if(textName.equals("coordinatestatus")){
	    			textName = "coordinate";
	    			textObject.put("predicate", predicado);
    	    		textObject.put("textName", textName);
    	    		textObject.put("textObject",subparts[1]);
	    		}else if(textName.equals("datasetname")){
	    			textName = "resource";
	    			textObject.put("predicate", predicado);
    	    		textObject.put("textName", textName);
    	    		textObject.put("textObject", new String(messageSource.getMessage(subparts[1], null, subparts[1], locale).getBytes("UTF-8"), "UTF-8"));
	    		}else if(textName.equals("datapublisher")){
	    			textName = "provider";
	    			textObject.put("predicate", predicado);
    	    		textObject.put("textName", textName);
    	    		textObject.put("textObject", new String(messageSource.getMessage(subparts[1], null, subparts[1], locale).getBytes("UTF-8"), "UTF-8"));
	    		}else if(textName.equals("boundingbox")){
	    			JSONObject textObject1 = new JSONObject();
	    			JSONObject textObject2 = new JSONObject();
	    			JSONObject textObject3 = new JSONObject();
	    			textName = "poligonalCoordinate";
	    			String[] subparts_1 = new String[100];
		    		subparts_1 = subparts[1].split(",");
	    			String minLat = (subparts_1[1].contains("S")?("-").concat(subparts_1[1].substring(0,subparts_1[1].length()-1)):subparts_1[1].substring(0,subparts_1[1].length()-1));
	    			String minLong = (subparts_1[0].contains("W")?("-").concat(subparts_1[0].substring(0,subparts_1[0].length()-1)):subparts_1[0].substring(0,subparts_1[0].length()-1));
	    			String maxLat = (subparts_1[3].contains("S")?("-").concat(subparts_1[3].substring(0,subparts_1[3].length()-1)):subparts_1[3].substring(0,subparts_1[3].length()-1));
	    			String maxLong = (subparts_1[2].contains("W")?("-").concat(subparts_1[2].substring(0,subparts_1[2].length()-1)):subparts_1[2].substring(0,subparts_1[2].length()-1));
	    			textObject.put("lat",minLat);
	    			textObject.put("lng",minLong);
	    			textObject1.put("lat",maxLat);
	    			textObject1.put("lng",minLong);
	    			textObject2.put("lat",maxLat);
	    			textObject2.put("lng",maxLong);
	    			textObject3.put("lat",minLat);
	    			textObject3.put("lng",maxLong);
	    			arr.put(textObject);
	    			arr.put(textObject1);
	    			arr.put(textObject2);
	    			arr.put(textObject3);
	    		}else{
	    			textObject.put("predicate", predicado);
    	    		textObject.put("textName", textName);
    	    		textObject.put("textObject",subparts[1]);
	    		}
	    		if(!textName.equals("poligonalCoordinate")){
	    			arr.put(textObject);
	    		}
	    		
	    		if(i+1<parts.length){
	    			if(parts[i+1].trim().startsWith("or")){
    	    			i = i +1;
    	    			while(parts[i].trim().startsWith("or")){
    	    				logger.debug("parts: " + parts[i]);
    	    				logger.debug("parts after for: " + parts[i]);
    	    		    	if(parts[i].contains("(")){
    	    		    		String[] subparts_1 = new String[100];
    	    		    		subparts_1 = parts[i].split("\\(");
    	    		    		parts[i] = subparts_1[0].trim();
    	    		    		if(subparts_1.length>2){
    	    		    			for(int j=1;j<(subparts_1.length)-1;j++){
    	    		    				if(subparts_1[j].contains(")")){
    	    				    			parts[i] = parts[i].concat(" (".concat(subparts_1[j]));
    	    				    			parts[i] = parts[i].trim();
    	    		    				}
    	    		    			}
    	    		    		}
    	    		    	}
    	    		    	logger.debug("parts after if: " + parts[i]);
        	    			JSONObject textObjectOr = new JSONObject();
        	    			subparts = parts[i].split("or ");
        	    			textObjectOr.put("predicate", predicado);
        	    			textObjectOr.put("textName", textName);
        	    			textObjectOr.put("textObject",subparts[1]);
            	    		arr.put(textObjectOr);
            	    		if(i+1<parts.length){
    	    	    			if(parts[i+1].trim().startsWith("or")){
    	    	    				i = i + 1;
    	    	    			}else{
    	    	    				break;
    	    	    			}
    	    	    		}else{
            	    			break;
            	    		}
            	    	}
	    			}
	    		}
	    		logger.debug("arr: " + arr.toString());
	    		if(textName.charAt(textName.length()-1)=='y'){
	    			textName = textName.replace("y","ie");
	    		}
	    		obj1.put(textName+"s",arr);
	    	}
	    }
	    logger.debug(obj1.toString());
	    String urlDatos = "http://maps.sibcolombia.net/api/download/occurrences";
	    HttpClient clientDatos = HttpClientBuilder.create().build();
	    HttpPost methodDatos = new HttpPost(urlDatos);
	    
	    String ipAddress  = request.getHeader("X-FORWARDED-FOR");
	    if(ipAddress == null)
	    {
	      ipAddress = request.getRemoteAddr();
	    }
	    
	    logger.debug("ipsource: " + ipAddress);
	    JSONObject obj = new JSONObject();
	    obj.put("email", request.getParameter(email));
	    obj.put("reason", request.getParameter(downloadReasonListKey));
	    obj.put("response",recaptcha);
	    obj.put("challenge",challenge);
	    obj.put("type", "all");
	    obj.put("ipsource", ipAddress);
	    obj.put("date", System.currentTimeMillis() / 1000L );
	    obj.put("query",obj1);
    
	    StringEntity se = new StringEntity(obj.toString(),  ContentType.APPLICATION_JSON);
	   
	    methodDatos.setEntity(se);

        HttpResponse response_da = clientDatos.execute(methodDatos);
        HttpEntity entity_da = response_da.getEntity();
       
        statusCodeDatos = response_da.getStatusLine().getStatusCode();
        logger.debug(statusCodeDatos);

    }catch (Exception e) {
        e.printStackTrace();
    }finally{
    	if(statusCodeDatos==200){
        	// search id
        	String searchId = request.getParameter(searchIdRequestKey);
        	String downloadFile =request.getParameter(email);
        	  
        	
        	String filenameWithExt = FilenameUtils.removeExtension(downloadFile);
        	
        	String originalUrl = downloadFile;
        	
        	DownloadUtils.writeDownloadToDescriptor(request, filenameWithExt, originalUrl, downloadFileType, queryDescription,
        	  displayTimeTaken, null);
        	// redirect to download preparing page
        	ModelAndView mav =
        	  new ModelAndView(new RedirectView("/download/preparingDownload.htm?downloadFile=" + downloadFile, true));
        	return mav;
        }else{
        	// search id
        	String searchId = request.getParameter(searchIdRequestKey);
        	String downloadFile =request.getParameter(email);
        	  
        	
        	String filenameWithExt = FilenameUtils.removeExtension(downloadFile);
        	
        	String originalUrl = downloadFile;
        	
        	DownloadUtils.writeDownloadToDescriptor(request, filenameWithExt, originalUrl, downloadFileType, queryDescription,
        	  displayTimeTaken, null);
        	// redirect to download preparing page
        	ModelAndView mav =
        	  new ModelAndView(new RedirectView("/download/downloadExpired.htm?downloadFile=" + downloadFile, true));
        	return mav;
        }
    }
  }

  /**
   * @param criteriaRequestKey the criteriaRequestKey to set
   */
  public void setCriteriaRequestKey(String criteriaRequestKey) {
    this.criteriaRequestKey = criteriaRequestKey;
  }

  /**
   * @param displayTimeTaken the displayTimeTaken to set
   */
  public void setDisplayTimeTaken(boolean displayTimeTaken) {
    this.displayTimeTaken = displayTimeTaken;
  }

  /**
   * @param downloadFieldPSKey the downloadFieldPSKey to set
   */
  public void setDownloadFieldPSKey(String downloadFieldPSKey) {
    this.downloadFieldPSKey = downloadFieldPSKey;
  }

  /**
   * @param downloadFields the downloadFields to set
   */
  public void setDownloadFields(List<Field> downloadFields) {
    this.downloadFields = downloadFields;
  }

  /**
   * @param downloadFilenamePrefix the downloadFilenamePrefix to set
   */
  public void setDownloadFilenamePrefix(String downloadFilenamePrefix) {
    this.downloadFilenamePrefix = downloadFilenamePrefix;
  }

  /**
   * @param downloadFileType the downloadFileType to set
   */
  public void setDownloadFileType(String downloadFileType) {
    this.downloadFileType = downloadFileType;
  }

  /**
   * @param downloadViews the downloadViews to set
   */
  public void setDownloadViews(Map<String, View> downloadViews) {
    this.downloadViews = downloadViews;
  }

  /**
   * @param occurrenceFilters the occurrenceFilters to set
   */
  public void setFilters(FilterMapWrapper occurrenceFilters) {
    this.filters = occurrenceFilters;
  }

  /**
   * @param format2FileWriterFactories the format2FileWriterFactories to set
   */
  public void setFormat2FileWriterFactories(Map<String, FileWriterFactory> format2FileWriterFactories) {
    this.format2FileWriterFactories = format2FileWriterFactories;
  }

  /**
   * @param format2TripletQueryManager the format2TripletQueryManager to set
   */
  public void setFormat2TripletQueryManager(Map<String, TripletQueryManager> format2TripletQueryManager) {
    this.format2TripletQueryManager = format2TripletQueryManager;
  }

  /**
   * @param formatRequestKey the formatRequestKey to set
   */
  public void setFormatRequestKey(String formatRequestKey) {
    this.formatRequestKey = formatRequestKey;
  }

  /**
   * @param matchAll the matchAll to set
   */
  public void setMatchAll(boolean matchAll) {
    this.matchAll = matchAll;
  }

  /**
   * @param maxResultsDownload the maxResultsDownload to set
   */
  public void setMaxResultsDownload(int maxResultsDownload) {
    this.maxResultsDownload = maxResultsDownload;
  }

  /**
   * @param messageSource the messageSource to set
   */
  public void setMessageSource(MessageSource messageSource) {
    this.messageSource = messageSource;
  }

  /**
   * @param namespace the namespace to set
   */
  public void setNamespace(String namespace) {
    this.namespace = namespace;
  }

  /**
   * @param prepareView the prepareView to set
   */
  public void setPrepareView(String prepareView) {
    this.prepareView = prepareView;
  }

  /**
   * @param propertyStore the propertyStore to set
   */
  public void setPropertyStore(PropertyStore propertyStore) {
    this.propertyStore = propertyStore;
  }

  /**
   * @param queryHelper the queryHelper to set
   */
  public void setQueryHelper(QueryHelper queryHelper) {
    this.queryHelper = queryHelper;
  }

  /**
   * @param recordCountRequestKey the recordCountRequestKey to set
   */
  public void setRecordCountRequestKey(String recordCountRequestKey) {
    this.recordCountRequestKey = recordCountRequestKey;
  }

  /**
   * @param requestedFieldsModelKey the requestedFieldsModelKey to set
   */
  public void setRequestedFieldsModelKey(String requestedFieldsModelKey) {
    this.requestedFieldsModelKey = requestedFieldsModelKey;
  }

  /**
   * @param searchIdRequestKey the searchIdRequestKey to set
   */
  public void setSearchIdRequestKey(String searchIdRequestKey) {
    this.searchIdRequestKey = searchIdRequestKey;
  }

  /**
   * @param searchUrl the searchUrl to set
   */
  public void setSearchUrl(String searchUrl) {
    this.searchUrl = searchUrl;
  }

  /**
   * @param zipped the zipped to set
   */
  public void setZipped(boolean zipped) {
    this.zipped = zipped;
  }

  /**
   * @param zippedFileExtension the zippedFileExtension to set
   */
  public void setZippedFileExtension(String zippedFileExtension) {
    this.zippedFileExtension = zippedFileExtension;
  }
}