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
Connection connect=null;
Statement statement=null;
ResultSet resultSet= null;
String id= (request.getParameter("id"));
String passd= (request.getParameter("pass"));
try{
	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/realestate?user=root&password=qwertyui&useSSL=false");
	statement = connect.createStatement();
	// prepare query for first result
	resultSet = statement.executeQuery("select * from agent where eid = \"" + id +"\"");
	int flag=0;
	while(resultSet.next()){
		String userID=resultSet.getString(1);
		String pass= resultSet.getString(2);
		if(userID.equals(id)){
			if(!passd.equals(pass)){
				break;
			}
			flag=1;
			break;
		}
	}
	if(flag==1){
		connect.close();
		out.println("the path: "+request.getRealPath("/WebContent"));
		response.sendRedirect("../HomePage/AgentIndex.html");
	}
	else{
		connect.close();
		%>
		<jsp:forward page="FailedLogin.html"></jsp:forward>
		<%
	}
	
}
catch(Exception e){
	e.printStackTrace();
	connect.close();
}

%>

</body>
</html>