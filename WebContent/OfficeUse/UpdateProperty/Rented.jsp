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
<a href="../HomePage/index.html" class="NewUser">Lets Go Back?</a>
<br/>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.text.*" %>

<%
Connection connect=null;
Statement statement=null;

PreparedStatement pst= null;
int pid=0, trans_no=0, price=0, eid=0, advance=0;
String date="2001-8-15";
try{
	eid= Integer.parseInt(request.getParameter("eid"));
	pid= Integer.parseInt(request.getParameter("pid"));
	pid= Integer.parseInt(request.getParameter("advance"));
	trans_no=Integer.parseInt(request.getParameter("trans_no"));
	price=Integer.parseInt(request.getParameter("price"));
	date=request.getParameter("date");
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss:ms");
    dateFormat.setLenient(false);
    boolean b=false;
    try {
        dateFormat.parse(date.trim());
    } catch (ParseException pe) {
    }
    b=true; 
	if(!b){
		response.sendRedirect("/FailedRented.html");
	}
}
catch(Exception e){
	response.sendRedirect("/FailedRented.html");
}
int total=0;
try{
	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/realestate?user=root&password=qwertyui&useSSL=false");
	String query="Insert into rent(trans_no, rent, date_rented, advance, pid) values(?, ?, ?, ?, ?)";
	pst=connect.prepareStatement(query);
	pst.setInt(1, trans_no);
	pst.setInt(2, price);
	pst.setString(3, date);
	pst.setInt(5, pid);
	pst.setInt(4, advance);
	pst.execute();
	query="Insert into rent_by(trans_no, pid, eid) values (?, ?, ?)";
	pst=connect.prepareStatement(query);
	pst.setInt(1, trans_no);
	pst.setInt(2, pid);
	pst.setInt(3, eid);
	pst.execute();
	connect.close();
	response.sendRedirect("../../HomePage/AgentIndex.html");
}
catch(Exception e){
	e.printStackTrace();
	connect.close();
	response.sendRedirect("./FailedRented.html");
}


%>

</body>
</html>