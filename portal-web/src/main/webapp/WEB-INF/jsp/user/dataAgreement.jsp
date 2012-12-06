<%@ include file="/common/taglibs.jsp"%>
<div id="twopartheader">
	<h2><spring:message code="dataagreement.title" text="Data Use Agreement"/></h2>
</div>


<b>Términos y condiciones de acceso y uso del portal de datos del SiB Colombia</b></p>
Versión 1.0 “ diciembre de 2012</p>
</p>

El SiB Colombia es una iniciativa de paí­s que tiene como propósito brindar acceso libre a información sobre la diversidad biológica del paí­s para la construcción de una sociedad sostenible. Esta iniciativa facilita la publicación en lí­nea de datos sobre biodiversidad y su acceso a una amplia variedad de audiencias, apoyando de forma oportuna y eficiente la gestión integral de la biodiversidad.</p>
</p>
La publicación de datos en el SiB Colombia debe tener lugar en un marco de plena atribución de créditos y derechos. Por lo tanto, para usar los datos disponibles a través del portal de datos del SiB Colombia debe estar de acuerdo con lo siguiente:</p>
</p>
<b>1. Acuerdos de uso de los datos</b></p>
1.1. La calidad e integridad de los datos no se puede garantizar, es responsabilidad de cada publicador, propietario o autor del conjunto de datos. Los riesgos asociados al uso de los datos son responsabilidad del usuario.</p>
1.2. Los usuarios deben respetar las restricciones de acceso a datos sensibles establecidas por publicadores, propietarios y autores de conjunto de datos.</p>
1.3. Con el fin de garantizar los créditos y derechos de los publicadores, propietarios y autores de los datos, la identidad de los mismos se debe conservar para cada registro.</p>
1.4. En cuanto al uso de los datos, los usuarios deben dar reconocimiento explícito a los publicadores de datos; éstos pueden requerir de créditos adicionales para colecciones específicas dentro de su institución.</p>
1.5. Es responsabilidad del usuario verificar los créditos y cumplir con los términos y las condiciones de uso definidas por el publicador, en el metadato asociado al conjunto de datos.</p>
<b></b></p>
<b>2. Sobre la citación de los datos</b></p>
Utilice el siguiente formato para citar datos publicados a través del SiB Colombia:</p>
<i>Datos de registros biológicos publicados por: (Accedidos a través del portal de datos del SiB Colombia, data.sibcolombia.net, AAAA-MM-DD)</i></p>
</p>
Por ejemplo:</p>
<i>Datos de registros biológicos publicados por: Universidad de Antioquia, Federación Nacional de Cafeteros de Colombia y Fundación Pro-Sierra Nevada de Santa Marta</i> <i>(Accedidos a través del portal de datos de SiB Colombia, data.sibcolombia.net, 2012-12-06)</i></p>

<b>3. Licencia de uso</b></p>
El portal de datos del SiB Colombia utiliza y acoge los términos de uso y condiciones establecidos en la licencia Creative Commons (CC) (http://creativecommons.org/licenses/by-nc-sa/2.5/es/). Ésta busca la creación de un espacio que promueva y facilite el intercambio de obras y trabajos de investigadores y desarrolladores, como una forma de fomentar la cultura de la libertad basada en la confianza.</p>
<b></b></p>
<b>4. Uso no comercial de la información</b></p>
El usuario asegura que la información obtenida no será utilizada para fines comerciales.</p>
</p>
<b>5. Uso ético de la información</b></p>
El usuario asegura que esta información no será utilizada contra la preservación de la biodiversidad de Colombia, dentro o fuera del territorio del país, o en actividades que promuevan el deterioro de la biodiversidad como, por ejemplo, el tráfico de especies.</p>
</p>
<b>6. Responsabilidad del Equipo Coordinador del SiB Colombia y del Instituto Humboldt</b></p>
El Equipo Coordinador del SiB Colombia (EC-SiB) advierte a los autores, propietarios y publicadores acerca de la alta calidad que debe tener la información sobre biodiversidad accesible a través del portal de datos del SiB Colombia. Sin embargo, ni el EC-SiB ni el Instituto de Investigación de Recursos Biológicos Alexander von Humboldt, se hacen responsables ni de la calidad, ni de la veracidad de la informaciónn que es obtenida a través del portal de datos del SiB Colombia, como tampoco se hacen responsables de los posibles daños o contratiempos causados por el uso de la información o de las herramientas informáticas contenidas en este sitio web.</p>


<form method="post" action="terms.htm" form="acceptForm" class="acceptForm">
  <input type="hidden" name="forwardUrl" value="${param['forwardUrl']}"/>
  <input type="submit" name="acceptedTerms" value="<spring:message code="dataagreement.accept"/>"/>
  <input type="submit" name="refuseTerms" value="<spring:message code="dataagreement.cancel"/>"/>
</form>

<p><spring:message code="dataagreement.cookie.warning" text="Depending on your browser settings, a cookie may be stored to acknowledge your acceptance of these terms."/></p>