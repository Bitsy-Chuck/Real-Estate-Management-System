<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate-Login</title>
 <link rel="stylesheet" href="./style1.css">
</head>
<body>
<a href="../HomePage/index.html" class="NewUser">Lets Go Back?</a>
<br/>
<%@ page import="java.sql.*, java.util.*, java.io.*" %>

<%
Connection connect=null;
Statement statement=null;

PreparedStatement pst= null;
String id1= request.getParameter("id");
int total=0;
try{
	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/realestate?user=root&password=qwertyui&useSSL=false");
	String query="SELECT eid FROM agent";
	pst=connect.prepareStatement(query);
	ResultSet eid_of_agent= pst.executeQuery();
	int id=-1;
	
	boolean flag_all=false;
	if(id1.equals("*")){
		flag_all=true;
	}else{
		try{
			id=Integer.parseInt(id1);
		}
		catch(Exception e){
			response.sendRedirect("RentReportError.html");
		}
	}
	boolean break_flag=false;
	//query="select eid from sold_by";
	//pst= connect.prepareStatement(query);
	//ResultSet eid_of_sold_by= pst.executeQuery();
	while(eid_of_agent.next()){
		if(break_flag) break;
		int eid= eid_of_agent.getInt(1);
		if(!flag_all && eid==id){
			break_flag=true;
		}
		if(!flag_all && eid!=id) continue;
		
		String q="select distinct * from rent_by where eid="+eid;
		pst=connect.prepareStatement(q);
		ResultSet ins= pst.executeQuery();
		int flag=0;
		while(ins.next()){
			flag=1;
			total++;
			%>
			<pre>		
			<%		
			int trans_no= ins.getInt("trans_no");
			int pid = ins.getInt("pid");
			String check="----------------";
			pageContext.setAttribute("pid", check);
			%>
			<c:out value="-s-"/>
			<%
			out.println("employee: "+eid+" rented: ");
			q="select * from rent s where trans_no="+trans_no;
			pst=connect.prepareStatement(q);
			ResultSet rent= pst.executeQuery();
			rent.next();
			String date=rent.getString("date_rented");
			int price = rent.getInt("rent");
			int advance = rent.getInt("advance");
			out.println("property with property id: "+pid+
					" on date: "+date+" at a rent(annual): "+price+
					" trans_no: "+trans_no);
			q="select * from property p natural join details d natural join location l where p.lid=l.lid and d.did=p.did and p.pid="+pid;
			pst=connect.prepareStatement(q);
			ResultSet p_details= pst.executeQuery();
			p_details.next();
			int no_of_beds = p_details.getInt("no_of_bed");
			int no_of_bath = p_details.getInt("no_of_bath");
			int sell_price = p_details.getInt("sell_price");
			int rent_price = p_details.getInt("rent_price");
			String location = "Country: "+p_details.getString("country")+
					" state: "+p_details.getString("state")+"  pin: "+
					p_details.getInt("pincode")+" landmark: "+p_details.getString("landmark");
			out.println("PROPERTY DETAILS");
			out.println(no_of_beds+ " bedroom "+no_of_bath+" bathroom"+
						rent_price+" is the listed price "
					);
			out.println("located at: "+location);
		}
		if(flag==0){
			out.println("eid: "+eid+" sold no property\n");
		}
			%>
		</pre>
	<br><%
	}
}
catch(Exception e){
	e.printStackTrace();
	connect.close();
}

out.println("total property rented: "+total);
connect.close();
%>

</body>
</html>