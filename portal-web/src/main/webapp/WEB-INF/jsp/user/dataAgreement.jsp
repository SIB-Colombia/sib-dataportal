<%@ include file="/common/taglibs.jsp"%>
<div id="twopartheader">
	<h2><spring:message code="dataagreement.title" text="Data Use Agreement"/></h2>
</div>

<h4><spring:message code="dataagreement.background" text="dataagreement.background"/></h4>
<p><spring:message code="dataagreement.background.firstparagraph" text="dataagreement.background.firstparagraph"/></p>

<p><spring:message code="dataagreement.background.secondparagraph" text="dataagreement.background.secondparagraph"/></p>

<p><spring:message code="dataagreement.background.thirdparagraph" text="dataagreement.background.thirdparagraph"/></p>

<p><spring:message code="dataagreement.background.fourthparagraph" text="dataagreement.background.fourthparagraph"/></p>

<h4><spring:message code="dataagreement.datauseagreements" text="dataagreement.datauseagreements"/></h4>
<ol>
   <li><spring:message code="dataagreement.datauseagreements.listone" text="dataagreement.datauseagreements.listone"/></li>
   <li><spring:message code="dataagreement.datauseagreements.listtwo" text="dataagreement.datauseagreements.listtwo"/></li>
   <li><spring:message code="dataagreement.datauseagreements.listthree" text="dataagreement.datauseagreements.listthree"/></li>
   <li><spring:message code="dataagreement.datauseagreements.listfour" text="dataagreement.datauseagreements.listfour"/></li>
   <li><spring:message code="dataagreement.datauseagreements.listfive" text="dataagreement.datauseagreements.listfive"/></li>
</ol>

<h4><spring:message code="dataagreement.citingdata" text="dataagreement.citingdata"/></h4>
<p><spring:message code="dataagreement.citingdata.firstparagraph" text="dataagreement.citingdata.firstparagraph"/></p>  
<p><em><spring:message code="dataagreement.citingdata.secondparagraph" text="dataagreement.citingdata.secondparagraph"/></em></p>
<p><spring:message code="dataagreement.citingdata.thirdparagraph" text="dataagreement.citingdata.thirdparagraph"/></p>
<p><em><spring:message code="dataagreement.citingdata.fourthparagraph" text="dataagreement.citingdata.fourthparagraph"/></em></p>

<h4><spring:message code="dataagreement.definitions" text="dataagreement.definitions"/></h4>
<ul>
   <li><spring:message code="dataagreement.definitions.listone" text="dataagreement.definitions.listone"/></li>
   <li><spring:message code="dataagreement.definitions.listtwo" text="dataagreement.definitions.listtwo"/></li>
   <li><spring:message code="dataagreement.definitions.listthree" text="dataagreement.definitions.listthree"/></li>
   <li><spring:message code="dataagreement.definitions.listfour" text="dataagreement.definitions.listfour"/></li>
   <li><spring:message code="dataagreement.definitions.listfive" text="dataagreement.definitions.listfive"/></li>
   <li><spring:message code="dataagreement.definitions.listsix" text="dataagreement.definitions.listsix"/></li>
   <li><spring:message code="dataagreement.definitions.listseven" text="dataagreement.definitions.listseven"/></li>
   <li><spring:message code="dataagreement.definitions.listeight" text="dataagreement.definitions.listeight"/></li>
   <li><spring:message code="dataagreement.definitions.listnine" text="dataagreement.definitions.listnine"/></li>
   <li><spring:message code="dataagreement.definitions.listten" text="dataagreement.definitions.listten"/></li>
   <li><spring:message code="dataagreement.definitions.listeleven" text="dataagreement.definitions.listeleven"/></li>
   <li><spring:message code="dataagreement.definitions.listtwelve" text="dataagreement.definitions.listtwelve"/></li>
   <li><spring:message code="dataagreement.definitions.listthirteen" text="dataagreement.definitions.listthirteen"/></li>
</ul><br/>

<p><spring:message code="dataagreement.definitions.finalparagraph" text="dataagreement.definitions.finalparagraph"/></p>

<form method="post" action="terms.htm" form="acceptForm" class="acceptForm">
  <input type="hidden" name="forwardUrl" value="${param['forwardUrl']}"/>
  <input type="submit" name="acceptedTerms" value="<spring:message code="dataagreement.accept"/>"/>
  <input type="submit" name="refuseTerms" value="<spring:message code="dataagreement.cancel"/>"/>
</form>

<p><spring:message code="dataagreement.cookie.warning" text="Depending on your browser settings, a cookie may be stored to acknowledge your acceptance of these terms."/></p>