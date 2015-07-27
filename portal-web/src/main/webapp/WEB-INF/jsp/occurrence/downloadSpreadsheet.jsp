<%@ include file="/common/taglibs.jsp"%>

<h4><spring:message code="occurrence.record.download.spreadsheet.title"/></h4>

<tiles:insert page="downloadHelp.jsp"/>
<p><spring:message code="occurrence.record.download.maximum.message"/></p>

<div id="downloadFields">

<form method="get" action="${pageContext.request.contextPath}/occurrence/startDownload.htm">

	
	<input type="hidden" name="criteria" value="<gbif:criteria criteria="${criteria}"/>"/>
	<input type="hidden" name="searchId" value="${searchId}"/>
	<input type="hidden" name="format" value="csv" />
	
	<h5>Por favor ingrese el correo a donde llegará la información</h5><br>
	<input id="user_email" name="user_email" type="email" required/> 
	<h5>Confirmación de correo</h5><br>
	<input id="user_email_confir" name="user_email_confir" type="email" required/>
	<label id="message_mail" class="textbox-label"> * La dirección de correo electrónico y la dirección de confirmación deben ser iguales.</label> 
	<h5>Indique el motivo de la descarga</h5><br>
	<select name="downloadReasonList">
		<option value = "Conservation management/planning"><spring:message code="download.reasonList.conservation"/></option>
		<option value = "Biosecurity management, planning"><spring:message code="download.reasonList.biosecurity"/></option>
		<option value = "Enviromental impact, site assessment"><spring:message code="download.reasonList.enviromental"/></option>
		<option value = "Education"><spring:message code="download.reasonList.education"/></option>
		<option value = "Scientific research"><spring:message code="download.reasonList.scientific"/></option>
		<option value = "Collection management"><spring:message code="download.reasonList.collection"/></option>
		<option value = "Other"><spring:message code="download.reasonList.other"/></option>
		<option value = "Ecological research"><spring:message code="download.reasonList.ecological"/></option>
		<option value = "Systematic research"><spring:message code="download.reasonList.systematic"/></option>
		<option value = "Testing"><spring:message code="download.reasonList.testing"/></option>
	</select>
	<br><br>
	<script src='https://www.google.com/recaptcha/api/challenge?k=6LdwrAUTAAAAAL7SMgkNMSjvdiMxS0YwaZ8AcSYE'></script>
    <noscript>
	   <iframe src="http://www.google.com/recaptcha/api/noscript?k=6LdwrAUTAAAAAL7SMgkNMSjvdiMxS0YwaZ8AcSYE"
	        height="300" width="500" frameborder="0"></iframe><br>
	   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
	   </textarea>
	   <input type="hidden" name="recaptcha_response_field"
	        value="manual_challenge">
	 </noscript>
	
	<label id="message_captcha" class="textbox-label"> * Por favor complete todos los campos para iniciar la descarga. </label> 
	<input id="downloadNow" type="submit" value="<spring:message code="download.now"/>" onclick="return confirmEmail();" />
	
	
	<table id="mandatoryFields">
	<tr>
	<c:forEach items="${mandatoryFields}" var="field">
		<td>
			<input type="checkbox" name="${field.fieldName}" checked="true" style="visibility:hidden;"/>
		</td>
	</c:forEach>
	</tr>
	</table>
	
	<table id="datasetFields">
		<tr>
	<c:forEach items="${datasetFields}" var="field" varStatus="fieldStatus">
		<td><input type="checkbox" name="${field.fieldName}" checked="true" style="visibility:hidden;"/>
	</c:forEach>
		</tr>
	</table>
	
	<table id="taxonomyFields">
	<tr>
	<c:forEach items="${taxonomyFields}" var="field" varStatus="fieldStatus">
		<td><input type="checkbox" name="${field.fieldName}" checked="true" style="visibility:hidden;"/>
	</c:forEach>
	</tr>
	</table>
	
	
	<table id="geospatialFields">
	<tr>
	<c:set var="count" value="0" scope="page" />
	<c:forEach items="${geospatialFields}" var="field" varStatus="fieldStatus">
		<!-- the field continent.ocean is hidden with this condition -->
		<c:if test="${field.fieldI18nNameKey !='occurrence.record.raw.continent.ocean'}">
			<td><input type="checkbox" name="${field.fieldName}" checked="true" style="visibility:hidden;"/>
			<c:set var="count" value="${count + 1}" scope="page"/>
		</c:if>
	</c:forEach>
	</tr>
	</table>
</form>

</div>
<script type="text/javascript">
	function confirmEmail(){
		var email = (document.getElementById("user_email").value).toLowerCase();
        var confemail = (document.getElementById("user_email_confir").value).toLowerCase();
        if (email == confemail) {
       	 	if(grecaptcha.getResponse()!=""){
       	 		return true;
       	 	}else{
       	 	document.getElementById("message_captcha").className = "warning";
       	 	}
       	}else{
       		document.getElementById("message_mail").className = "warning";
       	}
		return false;
	}
</script><!--end download fields -->