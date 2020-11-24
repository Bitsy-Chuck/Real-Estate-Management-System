<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate-Login</title>
 <link rel="stylesheet" href="./style32.css">
</head>
<body>
<a href="../HomePage/index.html" class="NewUser">Lets Go Back?</a>
<br/>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.text.*" %>

<%
Connection connect=null;
Statement statement=null;

PreparedStatement pst= null;
String act="";
String dest="";
boolean break_flag=false;
int pid=-1;
try{
	act=request.getParameter("act");
	pid=Integer.parseInt(request.getParameter("pid"));
	if(act.toLowerCase().equals("sold")||act.toLowerCase().equals("sell")) act="sold";
	else if(act.toLowerCase().equals("rent")) act="rent";
	else break_flag=true;
}
catch(Exception e){
	response.sendRedirect("/FailedSold.html");
}
int total=0;
try{
	if(break_flag)
		out.println(1/0);
	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/realestate?user=root&password=qwertyui&useSSL=false");
	String query="Select pid from sold";
	pst=connect.prepareStatement(query);
	ResultSet rs=pst.executeQuery();
	while(rs.next()){
		if(rs.getInt("pid")==pid){
			break_flag=true;
			break;
		}
	}
	if(!break_flag){
		System.out.println("clear");
	}
	query="Select pid from rent";
	pst=connect.prepareStatement(query);
	rs=pst.executeQuery();
	while(rs.next()){
		if(rs.getInt("pid")==pid){
			break_flag=true;
			break;
		}
	}
	connect.close();
}
catch(Exception e){
	e.printStackTrace();
	connect.close();
	dest="./UpdatePropError.html";
	if(!break_flag)
		response.sendRedirect("");
	else
		response.sendRedirect("./UpdatePropError.html");
}
if(break_flag){
	out.println("PROPERTY ALREADY SOLD/RENTED");
	%>
	<br>
	<a href="UpdateProp.html">Try again?</a>
	<%
}
else{
	
	if(act.toLowerCase().equals("sold")){
		dest="UpdateProperty/Sold.html";
	}
	else if(act.toLowerCase().equals("rent")){
		dest="UpdateProperty/Rented.html";
	}
	else
		dest="./UpdatePropError.html";
	response.sendRedirect(dest);
}


%>

</body>
</html>