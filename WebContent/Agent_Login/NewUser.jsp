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
PreparedStatement pst= null;
int id= Integer.parseInt(request.getParameter("New_User"));
String pass= (request.getParameter("New_Pass"));
String name= (request.getParameter("Name"));
String email= (request.getParameter("email"));
int phone= Integer.parseInt(request.getParameter("phone"));
try{
	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/realestate?user=root&password=qwertyui&useSSL=false");
	String query="INSERT INTO agent(eid, password,ename, email, phone, score) VALUES (?, ?, ?, ?, ?, ?);";
	pst= connect.prepareStatement(query);
	//id="\""+id+"\"";
	System.out.println("id: "+id);
	//pass="\""+pass+"\"";
	System.out.println("pass: "+pass);
	pst.setInt(1, id);
	pst.setString(2, pass);
	pst.setString(3, name);
	pst.setString(4, email);
	pst.setInt(5, phone);
	pst.setInt(6, 0);
	pst.execute();
}
catch(Exception e){
	e.printStackTrace();
	connect.close();
}
connect.close();
out.println("USER REGISETER");
%>
<jsp:forward page="login.html"></jsp:forward>



</body>
</html>