<%-- 
    Document   : member.jsp
    Created on : Sep 12, 2017, 4:56:35 PM
    Author     : Sanan Garibli
--%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page import="com.cs.INSUPD_DB"%>
<%@page import="java.sql.*"%>
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


<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("index.jsp");
    } 
    
    else {
       int USER_TYPE = Integer.parseInt(session.getAttribute("USER_TYPE").toString());


   String action  = "";
   String table_name = "";
   boolean load_form = false;
    

if (request.getParameterMap().containsKey("action"))
{
    action = request.getParameter("action");
}

if (action.equals("addteacher"))
{
    table_name = "teachers";
    load_form = true;
    //INSUPD_DB ins_to_db = new INSUPD_DB();
    //ins_to_db.DB_Insert_Update("insert", table_name,  "Ehtiram", "Kazimov", "Mirzəli", "21.11.1989", "+994552909137", "test@test.com", 1, "The best teacher");
}  
    
else if (action.equals("addstudent"))
{
    table_name = "students";
    load_form = true;
}
else 
    {   %>
               <script type="text/javascript">
                   alert("Wrong action!  <%=action%>");
               </script>
        <%
}

if (load_form) { %>
    <form method="post" id ="add_member" name="add_member" action="#" >           
            <input  class="name" type="text" name="name"  placeholder="Name"  required/>
            <input  class="name" type="text" id="surname" name="surname" placeholder="Surname" required/>
            <input  class="name" type="text" name="fathers_name" placeholder="Father's Name"  required/>
            <input  class="name"  type="text" name="birth_date"  placeholder="Date of birth"  required/>
            <input  class="name"  type="text" name="phone"  placeholder="Phone (e.g. +994551234567;+994501234567" onkeypress="return (event.charCode >= 48 && event.charCode <= 57) || event.charCode===43 || event.charCode===59" />
            <input  class="name"  type="email" name="email"  placeholder="E-mail address (e.g. ali@example.com" />         
            <input  class="name" type="text" name="description" placeholder="description" />
            <input  type="hidden" name="action" value="<%=action%>">             
            <input class="button" type="submit" name="btnSubmit" id="btnSubmit" value="Add member" onclick="if (confirm('Adding Member: \nAre   you sure?')){ document.forms['add_member'].action='add_member.jsp?action=<%=action%>';document.forms['add_member'].submit();} else { void(''); }; "/>
    </form>
<%
}

} // session scope


%>
</head>
</html>
