<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shall we Begin?</title>
 <link rel="stylesheet" href="./style.css">
</head>
<body>
<%
  String who= request.getParameter("eid");
  if(who.toLowerCase().equals("agent")){
	  response.sendRedirect("../Agent_Login/login.html");
  }
  else{
	  response.sendRedirect("../Client_Login/login.html");
  }
 %>

</body>
</html>