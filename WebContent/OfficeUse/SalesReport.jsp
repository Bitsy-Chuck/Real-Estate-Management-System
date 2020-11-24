<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate-Login</title>
 <link rel="stylesheet" href="./style2.css">
</head>
<body>

<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<a href="../HomePage/index.html" class="NewUser">Lets Go Back?</a>
<br/>
<%
Connection connect=null;
Statement statement=null;

PreparedStatement pst= null;
String id1= request.getParameter("id");
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
			response.sendRedirect("salesreporterror.html");
		}
	}
	//query="select eid from sold_by";
	//pst= connect.prepareStatement(query);
	//ResultSet eid_of_sold_by= pst.executeQuery();
	boolean break_flag=false;
	while(eid_of_agent.next()){
		if(break_flag) break;
		int eid= eid_of_agent.getInt(1);
		if(!flag_all && eid==id){
			break_flag=true;
		}
		if(!flag_all && eid!=id) continue;
		String q="select distinct * from sold_by where eid="+eid;
		pst=connect.prepareStatement(q);
		ResultSet ins= pst.executeQuery();
		int flag=0;
		while(ins.next()){
			flag=1;
			%>
			<pre>
			<%
			
			int trans_no= ins.getInt("trans_no");
			int pid = ins.getInt("pid");
			out.println("employee: "+eid+" sold: ");
			q="select * from sold s where trans_no="+trans_no;
			pst=connect.prepareStatement(q);
			ResultSet sold= pst.executeQuery();
			sold.next();
			System.out.println("ass");
			String date=sold.getString("date_sold");
			int price = sold.getInt("price");
			out.println("property with property id: "+pid+
					" on date: "+date+" at a price: "+price+
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
						sell_price+" is the listed price "
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
connect.close();
%>

</body>
</html>