<%@ include file="/common/taglibs.jsp"%>

<footer>
<section>
  <aside><img  alt="SiB Colombia" src="${pageContext.request.contextPath}/images/logos_cut/logo_sib_bn.png"></aside>
  <div>
    <h5>Sistema de información sobre <br/>Biodiversidad de Colombia</h5>
    <strong><spring:message code="address"/></strong> Calle 28A No. 15-09 Bogotá D.C., Colombia. <br/>
    <strong><spring:message code="telephone"/></strong> PBX 57(1) 320 2767<br/>
    <a href="mailto:sib@humboldt.org.co">sib@humboldt.org.co</a>
  </div>
  <div>
    <div><h5><spring:message code="portal.text.dataportal.footer"/></h5> 
        <a target="_self" href="${pageContext.request.contextPath}/especies/"><spring:message code="taxonomy.intro.foot"/></a>
        <a target="_self" href="http://data.sibcolombia.net/explorador/"><spring:message code="geographic.explorer.records"/></a>
        <a target="_self" href="${pageContext.request.contextPath}/conjuntos/"><spring:message code="datasets.foot"/></a> 
        <a target="_self" href="${pageContext.request.contextPath}/publicadores/"><spring:message code="pusblishers.foot"/></a> 
        <a target="_self" href="${pageContext.request.contextPath}/busqueda/"><spring:message code="advanced.search.foot"/></a>
        <!--<a target="_blank" href="#">¿Cómo usar el portal de datos?</a>!--></div>

     <div><h5><spring:message code="our.services.foot"/></h5> 
        <a target="_self" href="${pageContext.request.contextPath}/"><spring:message code="data.portal.foot"/></a> 
        <a target="_blank" href="http://www.sibcolombia.net"><spring:message code="sib.portal.foot"/></a> 
        <a target="_blank" href="http://www.siac.net.co/sib/catalogoespecies/welcome.do"><spring:message code="catalog.species.foot"/></a> 
        <a target="_blank" href="http://ipt.sibcolombia.net/"><spring:message code="ipt.footer"/></a></div> 

    <div><h5><spring:message code="sib.colombia"/></h5> 
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/acerca-del-sib"><spring:message code="what.is.sib"/></a> 
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/equipo-coordinador"><spring:message code="coordinator.team"/></a>
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/comite-directivo"><spring:message code="director.board"/></a> 
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/nuestra-red"><spring:message code="our.network"/></a> 
        <!--<a target="_blank" href="http://www.sibcolombia.net/web/sib/unete-al-sib">Úšnete al SiB</a>!--></div>

    <div><h5><spring:message code="current.news.foot"/></h5> 
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/linea-de-tiempo"><spring:message code="line.events"/></a> 
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/eventos"><spring:message code="workshops.committees"/></a> 
        <a target="_blank" href="http://www.sibcolombia.net/web/sib/reportesib"><spring:message code="sib.report"/></a>
        <!--<a target="_blank" href="#">Convocatorias</a>!--></div>
    

  </div>
  <span class="redes">
    <a title="<spring:message code="sib.on.facebook"/>" target="_blank" href="https://www.facebook.com/SibColombia"><img  alt="SiB en Facebook" src="${pageContext.request.contextPath}/images/logos_cut/fb_b.png"></a>
    <a title="<spring:message code="sib.on.twitter"/>" target="_blank" href="https://twitter.com/sibcolombia"><img  alt="SINCHI" src="${pageContext.request.contextPath}/images/logos_cut/tw_b.png"></a>
    <a title="<spring:message code="sib.on.pinterest"/>" target="_blank" href="http://pinterest.com/sibcolombia/pins/"><img  alt="SiB en Pinterest" src="${pageContext.request.contextPath}/images/logos_cut/pin_b.png"></a>
    <a title="<spring:message code="sib.on.youtube"/>" target="_blank" href="http://www.youtube.com/sibcolombia"><img  alt="SiB en Youtube" src="${pageContext.request.contextPath}/images/logos_cut/yt_b.png"></a>
  </span>
  <nav>
    <a href="${pageContext.request.contextPath}/terms.htm"><spring:message code="data.use.agreements.foot"/></a>  <a href="https://www.gobiernoenlinea.gov.co/" target="_blank"><spring:message code="gobierno.linea"/></a> <!--<<a href="#"><spring:message code="help.foot"/></a> <a href="#"><spring:message code="copyright.foot"/></a> <a href="#"><spring:message code="site.map"/></a>  -->
  </nav>
</section>



<section>
  <span><a title="Humboldt" target="_blank" href="http://www.humboldt.org.co"><img  alt="Humboldt" src="${pageContext.request.contextPath}/images/logos_cut/humboldt_bn.png"></a>
  <p><spring:message code="coordinator.entity"/></p> 
  </span>
  <span>
    <a title="Red Interamericana de Información sobre Biodiversidad" target="_blank" href="http://www.iabin.net"><img  alt="Red Interamericana de Informaci&amp;oacute;n sobre Biodiversidad" src="${pageContext.request.contextPath}/images/logos_cut/iabin_bn.png"></a>
    <a title="Global Biodiversity Information Facility" target="_blank" href="http://www.gbif.org"><img  alt="Global Biodiversity Information Facility" src="${pageContext.request.contextPath}/images/logos_cut/gbif_bn.png"></a>
  <p><spring:message code="related.initiatives.sib"/></p> 
  </span>
  <span>
    <a href="https://www.siac.gov.co/" target="_blank" title="El SiB Colombia es componente temático del SIAC"><img src="${pageContext.request.contextPath}/images/logos_cut/siac_bn.png"alt="El SiB Colombia es componente tem&aacute;tico del SIAC" /></a>
  <p><spring:message code="sib.thematic.siac"/></p> 
  </span>
  <span>
    <a title="SINCHI" target="_blank" href="http://www.sinchi.org.co"><img  alt="SINCHI" src="${pageContext.request.contextPath}/images/logos_cut/sinchi_bn.png"></a>
    <a title="Humboldt" target="_blank" href="http://www.humboldt.org.co"><img  alt="Humboldt" src="${pageContext.request.contextPath}/images/logos_cut/humboldt_bn.png"></a>
    <a title="IDEAM" target="_blank" href="http://www.ideam.gov.co"><img  alt="IDEAM" src="${pageContext.request.contextPath}/images/logos_cut/ideam_bn.png"></a>
    <a title="INVEMAR" target="_blank" href="http://www.invemar.org.co"><img  alt="INVEMAR" src="${pageContext.request.contextPath}/images/logos_cut/invemar_bn.png"></a>
    <a title="IIAP" target="_blank" href="http://www.iiap.org.co"><img  alt="IIAP" src="${pageContext.request.contextPath}/images/logos_cut/iiap_bn.png"></a>
    <a title="ICN" target="_blank" href="http://www.icn.unal.edu.co"><img  alt="ICN" src="${pageContext.request.contextPath}/images/logos_cut/unal_bn.png"></a>
    <a title="Ministerio de Ambiente y Desarrollo Sostenible" target="_blank" href="http://www.minambiente.gov.co"><img  alt="Ministerio de Ambiente y Desarrollo Sostenible" src="${pageContext.request.contextPath}/images/logos_cut/mads_bn.png"></a>
    <p><spring:message code="steering.committee"/></p> 
  </span>


</section>
</footer>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-1418857-10']);
  _gaq.push(['_setDomainName', 'sibcolombia.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script> 
<!-- End footer -->