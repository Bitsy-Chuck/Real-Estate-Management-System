<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate-Login</title>
 <link rel="stylesheet" href="./style1.css">
</head>
<body>

<%@ page import="java.sql.*, java.util.*, java.io.*" %>

<%
String eid= request.getParameter("Name");
int col2= Integer.parseInt(request.getParameter("choice"));
switch(col2){
case 1:
	response.sendRedirect("salesreport.html");
	break;
case 2:
	response.sendRedirect("RentReport.html");
	break;

case 3:
	response.sendRedirect("UpdateProp.html");
}
%>



</body>
</html>