<%-- 
    Document   : member.jsp
    Created on : Sep 12, 2017, 4:56:35 PM
    Author     : Sanan Garibli
--%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page import="com.cm.DbConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Member Page</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="css/style_member.css">
  <jsp:include page="header.jsp" />
  
<script type="text/javascript">
function check_expiry_date()
{
    var expiry_date = document.getElementById('expiry_date').value;

    var curr_year = (new Date()).getFullYear();
    var my_expiry_date = expiry_date.split('/');
    var my_day=my_expiry_date[0];
    var my_month=my_expiry_date[1];
    var my_year = my_expiry_date[2];
    var response ;
    //alert(my_year);
  if (my_day>=1 && my_day<=31 && my_month>=1 && my_month<=12 && my_year>=curr_year)
  {
     response=true;
     return response;
  }
  else 
  {
    response=false;
    alert('Date not valid. Date format must be like dd/mm/yyyy. e.g. 31/12/'+curr_year);
    return response; 
  }
    
}

</script>

<%@ page import ="java.sql.*" %>
<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("index.jsp");
    } 
    
    else {
       int USER_TYPE = Integer.parseInt(session.getAttribute("USER_TYPE").toString());

try {
    DbConnect DB = new DbConnect();
    Connection con = DB.getConnection();

   String s_id = "";
   String t_id = "";
   
   String action  = "";
    
if (request.getParameterMap().containsKey("s_id"))
{
    s_id = request.getParameter("s_id");
}
if (request.getParameterMap().containsKey("t_id"))
{
    t_id = request.getParameter("t_id");
} 

if (request.getParameterMap().containsKey("action"))
{
    action = request.getParameter("action");
} 

}

catch (Exception e) 
{
       String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("database connection error: <%=error%>");
               </script>
        <%

}


} // session scope




%>
</head>
</html>
