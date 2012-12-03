<%@ page language="java" isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


<html>
  <head>
    <title>GBIF - Access Denied</title>
    <style>
       body {
        margin: 0px;
        padding: 20px;
        color: #333;
	background: #f2eee3 url("images/noise1.png") repeat 0 0;
	font-family: Helvetica, Verdana, Helvetica, Arial;
      }
      h1 {
        font-size: 14pt;
        padding-top: 40px;
        margin: 0px;
      }
      h2 {
        font-size: 1.6em;
        margin: 0px;
      }
      h3 {
        font-size: 12pt;
        margin: 0px;
      }
      #page {
        margin-left: 20px;
      }
      a {
        color: #006600;
      }
      #content {
        padding:30px;
      }
    </style>
  </head>
  <body>
    <div id="content">
      <h2>Access Denied</h2>
      <p>
      This might be because:<br/>
      <ul>
        <li>You dont have access privileges to view this page</li>      
        <li>You may have typed the web address incorrectly. Please check the address and spelling ensuring that it does not contain capital letters or spaces</li>
      </ul>
     </p>
     <p>To report this please send an email supplying the url for this page to 
        <a href="mailto:portal@gbif.org">portal@gbif.org</a>.
     </p> 
     <p>
          <a href="${pageContext.request.contextPath}">Click here</a> to continue.
     </p>      
     </giv>   
  </body>
</html>