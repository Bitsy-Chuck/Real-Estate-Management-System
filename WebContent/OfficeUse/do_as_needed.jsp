<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate-Login</title>
 <link rel="stylesheet" href="./style.css">
</head>
<body>
<a href="../HomePage/index.html" class="NewUser">By Mistake?</a>
<br/>
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%
int pid=-1;
boolean flag=true;
	try{
		pid= Integer.parseInt(request.getParameter("pid"));
	}
	catch(Exception e){
		flag=false;
	}
	String act= request.getParameter("act");
	if(flag)
	switch (act){
		case "sell":
			response.sendRedirect("UpdateProperty/Sold.html");
			break;
		case "rent":
			response.sendRedirect("UpdateProperty/Rented.html");
			break;
		default:
			response.sendRedirect("./UpdatePropError.html");
	}
	else response.sendRedirect("UpdatePropError.html");
%>

<h1 class="general"> 
<%
	out.println(pid);
%>
</h1>

</body>
</html>