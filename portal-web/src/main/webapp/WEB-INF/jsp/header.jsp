<%@ include file="/common/taglibs.jsp"%>

<style type="text/css" media="all">
@import url("${pageContext.request.contextPath}/skins/standard/css/system.base.css");
@import url("${pageContext.request.contextPath}/skins/standard/css/system.menus.css");
@import url("${pageContext.request.contextPath}/skins/standard/css/style.css");
@import url("${pageContext.request.contextPath}/skins/standard/css/superfish.css");
@import url("${pageContext.request.contextPath}/skins/standard/css/boilerplate.css");
@import url("${pageContext.request.contextPath}/skins/standard/css/maintenance-page.css");
@import url("${pageContext.request.contextPath}/skins/standard/css/skeleton.css");

h2 {
	font:;
	margin-bottom: 35px;
	text-shadow: 1px 1px 3px rgba(0, 0, 0, 8.4) !important;
	text-transform: uppercase;
}
h3 {
	text-shadow: 1px 1px 3px rgba(0, 0, 0, 8.4) !important;
}
.container-12 {
	position: relative;
	width: 1500px !important;
	margin: 0 auto;
	padding: 0;
}
.container-12 .grid-9 {
	width: 914px !important;
}
#header .header-top {
	background: #ffffff;
	left: 0px !important;
	padding: 3px 0 8px !important;
	position: absolute;
	right: 0px !important;
	top: 0;
}

#search-block-form .container-inline, #search-block-form--2 .container-inline {
	border: none !important;
	display: block;
	overflow: hidden;
	position: relative;
	width: 192px !important;
}

#superfish-1 > li > a {
	border-radius: 0px;
	color: #333333;
	display: block;
	padding: 28px 12px !important;
	position: relative;
	text-decoration: none;
}
li.active-trail > a, #superfish-1 > li.sfHover > a {
	background: rgba(22, 138, 203, 0.19) !important;
	color: #333333 !important;
	text-decoration: none;
}
#superfish-1 > li > a:hover,
#superfish-1 > li.active-trail > a,
#superfish-1 > li.sfHover > a {
  background: rgba(22, 138, 203, 0.19) !important;
  color: #ffffff;
  text-decoration: none;
}
.grid-9 {
	float: right;
	display: inline;
	margin-left: 0px !important;
	margin-right: 0px !important;
}
#search-block-form, #search-block-form--2 {
	float: left;
	margin-top: 24px !important;
}
table th {
	border: none;
	color: #ba0c0d;
	font-size: 14px;
	padding: 5px;
}
</style>




	<link rel="stylesheet" href="...style-mobile.css" media="screen" id="style-mobile">
	<link rel="stylesheet" href="...skeleton-mobile.css" media="screen" id="skeleton-mobile">

		<header id="header" role="banner" class="clearfix">
			<div class="container-12 header-top-wrapper">
				<div class="header-top">
					<div class="clearfix">
						<div class="grid-3 alpha">
															<a href="/" title="Home" rel="home" id="logo">
			<img src="http://www.sibbr.gov.br/templates/sibbr/images/logo.png" alt="Home" />
								</a>
					  </div>

						<div class="grid-9 omega">
							  <div class="region region-menu">
    <div id="block-superfish-1" class="block block-superfish block-odd">
	
	<div class="content">
		<ul id="superfish-1" class="menu sf-menu sf-main-menu sf-horizontal sf-style-none sf-total-items-6 sf-parent-items-1 sf-single-items-5">

<li id="menu-201-1" class="middle first odd sf-item-1 sf-depth-1 sf-no-children">
<a href="${pageContext.request.contextPath}/especies/" title="<spring:message code='topmenu.species.title'/>" class="sf-depth-1 active"><spring:message code='topmenu.species'/></a>
</li>

<li id="menu-4655-1" class="middle even sf-item-2 sf-depth-2 sf-no-children">
<a href="${pageContext.request.contextPath}/conjuntos/" title="<spring:message code='topmenu.datasets.title'/>" class="sf-depth-1"><spring:message code='topmenu.datasets'/></a>
</li>

<li id="menu-4655-1" class="middle even sf-item-3 sf-depth-3 sf-no-children">
<a href="${pageContext.request.contextPath}/departamentos/" title="<spring:message code='topmenu.departments.title'/>" class="sf-depth-1"><spring:message code='topmenu.departments'/></a>
</li>

<li id="menu-4656-1" class="middle odd sf-item-4 sf-depth-4 sf-no-children">
<a href="${pageContext.request.contextPath}/publicadores/" title="<spring:message code='topmenu.publishers.title'/>" class="sf-depth-1"><spring:message code='topmenu.publishers'/></a>  
</li>

<li id="menu-739-1" class="middle even sf-item-5 sf-depth-5 sf-total-children-3 sf-parent-children-0 sf-single-children-3 menuparent">
<a href="${pageContext.request.contextPath}/ipt/" title="" class="sf-depth-1 menuparent">IPT</a>

<ul>
<li id="menu-3768-1" class="first odd sf-item-1 sf-depth-1 sf-no-children">
<a href="/drupal_47584/?q=portfolio-2" title="" class="sf-depth-2">Projects 2</a>
</li>

<li id="menu-3769-1" class="middle even sf-item-2 sf-depth-1 sf-no-children">
<a href="/drupal_47584/?q=portfolio-3" title="" class="sf-depth-2">Projects 3</a>
</li>

<li id="menu-3767-1" class="last odd sf-item-3 sf-depth-1 sf-no-children">
<a href="/drupal_47584/?q=portfolio-4" title="" class="sf-depth-2">Projects 4</a>
</li>
</ul>
</li>

</ul>

</div><!-- /.content -->
</div><!-- /.block -->  </div>
							  <div class="region region-search">
    <div id="block-search-form" class="block block-search block-even">
	
	<div class="content">
		<form action="" method="post" id="search-block-form" accept-charset="UTF-8"><div><div class="container-inline">
      <h2 class="element-invisible">Search form</h2>
    <div class="form-item form-type-textfield form-item-search-block-form">
  <label class="element-invisible" for="edit-search-block-form--2">Search </label>
 <input title="Enter the terms you wish to search for." type="search" id="edit-search-block-form--2" name="search_block_form" value="" size="15" maxlength="128" class="form-text" />
</div>
<div class="form-actions form-wrapper" id="edit-actions">
<input type="submit" id="edit-submit" name="op" value="Search" class="form-submit" />
</div>

<input type="hidden" name="form_build_id" value="form-syn1TF4cz-w4pm-FDBZ2COthlJqthCbyB33uw2WzTLM" />
<input type="hidden" name="form_id" value="search_block_form" />
</div>
</div></form>	</div><!-- /.content -->
</div><!-- /.block -->  </div>
						</div>
					</div>
				</div>
			</div>
<iframe width="100%" height="250px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=pt-BR&amp;geocode=&amp;q=brasil&amp;aq=&amp;sll=-16.299051,-48.164062&amp;sspn=79.111616,135.263672&amp;t=t&amp;ie=UTF8&amp;hq=&amp;hnear=Brasil&amp;z=5&amp;ll=-14.235004,-51.92528&amp;output=embed"></iframe>

								
					</header><!-- /#header -->
