<%-- 
    Document   : success
    Created on : Sep 5, 2017, 4:56:35 PM
    Author     : Sanan Garibli
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  
  <title>Home Page</title>
  <link rel="stylesheet" href="css/style_table.css">
  <jsp:include page="header.jsp" />
</head>



<%!
public  long Convert_to_longint(String startDateString)
{
Date return_date;
DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
Date startDate;
try {
    startDate = df.parse(startDateString);
    return_date= startDate;
} catch (ParseException e) {
    System.out.println("Error ocurred when converted to long: " +e.toString());
    return_date = null;
}
return return_date.getTime() + 86400000;
}

%>

<%!
 public  long ToDay() 
{

Date startDate =  new Date();
long date_long;

try {
    date_long=startDate.getTime();
} 
catch (Exception e) 
{
    e.printStackTrace();
    date_long = 0;
}
return date_long;
 
}
%>

<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {        
        response.sendRedirect("index.jsp");    
    } else {
        
       int USER_TYPE = Integer.parseInt(session.getAttribute("USER_TYPE").toString());

%>


<%
         String s_id = "";
         String t_id = "";
         String search_id = "";
         String name = "";
         String surname = "";
         String fathers_name = "";
         String birth_date = "";
         String phone = "";
         String email = "";
         String status = "";
         String description = "";
         boolean expired;
         boolean expiring;
         String table_name = "students";
         String id = "s_id";
         
         
        if (request.getParameter("s_id") != null) {         s_id =              request.getParameter("s_id"); }
        if (request.getParameter("t_id") != null) {         t_id =              request.getParameter("t_id"); }
        if (request.getParameter("name") != null) {         name =              request.getParameter("name"); }
        if (request.getParameter("surname") != null) {      surname =           request.getParameter("surname"); }
        if (request.getParameter("fathers_name") != null) { fathers_name =      request.getParameter("fathers_name"); }
        if (request.getParameter("birth_date") != null) {   birth_date =        request.getParameter("birth_date"); }
        if (request.getParameter("phone") != null) {        phone =             request.getParameter("phone"); }
        if (request.getParameter("email") != null) {        email =             request.getParameter("email"); }
        if (request.getParameter("status") != null) {       status =            request.getParameter("status"); }
        if (request.getParameter("description") != null) {  description =       request.getParameter("description"); }
        if (request.getParameter("table_name") != null) {   table_name =        request.getParameter("table_name"); }
        
    
 try { 
        
    String url = "";
    String driver = "";
    String username = "";
    String password = "";
    Properties  props = new Properties();
      
    
    props.load(new FileInputStream(getServletContext().getRealPath("/") + File.separator + "conf" + File.separator + "config.properties"));
    
    driver =    props.getProperty("driver").trim();
    url =       props.getProperty("url").trim();
    username =  props.getProperty("username").trim();
    password =  props.getProperty("password").trim();
    
    Class.forName(driver);
    Connection con =DriverManager.getConnection(url, username, password);
    
    if (table_name.equals("t") ){
        table_name = "teachers";
        id = "t_id";
        search_id = t_id;
        
    }
    else { 
        table_name = "students";
        id = "s_id"; 
        search_id = s_id;
    }
    
    String select_query =  "SELECT  " + id + " ,  name,  surname,  fathers_name, birth_date,  phone,  email,  status,  description "
            + " FROM  " + table_name 
            + " WHERE " + id + " LIKE ? AND name LIKE ? AND surname LIKE ? AND fathers_name LIKE ? AND birth_date LIKE ? AND phone LIKE ? AND email LIKE ? AND status LIKE ? AND "
            + " description LIKE ? ";
    
 
     expiring = request.getParameter("expiring" ) != null;
     expired  = request.getParameter("expired"  ) != null;
     /******
     if (expiring && expired)
    {

        select_query = select_query +" AND (SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),31) <= NOW() OR SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),0) < NOW()) ORDER BY STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y') ";
    }
     else if (expiring)
     {
        select_query = select_query +" AND SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),31) <= NOW() AND  SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),0) > NOW()  ORDER BY STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y') ";
     }
     else if (expired)
     {
        select_query = select_query +" AND  SUBDATE(STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y'),0) < NOW()  ORDER BY STR_TO_DATE(EXPIRY_DATE,'%d/%m/%Y') ";

     }
     *****/
        PreparedStatement stmt = con.prepareStatement(select_query);
        stmt.setString(1, "%" + search_id + "%");
        stmt.setString(2, "%" + name + "%");
        stmt.setString(3, "%" + surname + "%");
        stmt.setString(4, "%" + fathers_name + "%");
        stmt.setString(5, "%" + birth_date + "%");
        stmt.setString(6, "%" + phone + "%");
        stmt.setString(7, "%" + email + "%");
        stmt.setString(8, "%" + status + "%");
        stmt.setString(9, "%" + description + "%");

        
        ResultSet rs = stmt.executeQuery();
%>
 
    <FORM id="cert" name="certs" method="POST" ACTION="#" >
        <table class="responsive-table">
            <tr>

                <td>   </td>  
                <td></td> 
                <td><b> ID  </td> 
                <td><b> Name  </b> </td> 
                <td><b> Surname  </b> </td> 
                <td><b> Father's Name </b> </td> 
                <td><b> Birth date  </b> </td>
                <td><b> Phone </b> </td>
                <td><b> Email </b> </td> 
                <td><b> Status </b> </td> 
                <td><b> Description  </b> </td>
                </b>
            </tr> 
            
           <tr>
               
                
               <td><input id="expired" name="expired" type="checkbox" onclick="this.form.submit();" title="Show Expired Certificates" <% if (expired) {%> checked <% } %>></td>  
                <td> <input id="expiring" name="expiring" type="checkbox" onclick="this.form.submit();" title="Soon Expiring Certificates" <% if (expiring) {%> checked <% } %>> <input type="submit" value="Filter" style="position: absolute; left: -9999px; width: 1px; height: 1px;" tabindex="-1" /></td> 
                <td> <input name="id" size="4" value="" /> </td> 
                <td> <input name="cn" size="12" value="<%=name %>"/> </td> 
                <td> <input name="expiry_date" size="12" value="<%=surname %>"/> </td> 
                <td> <input name="server_name" size="12" value="<%=fathers_name %>"/> </td> 
                <td> <input name="server_ip" size="12" value="<%=birth_date %>"/> </td>
                <td> <input name="server_owner" size="12" value="<%=phone %>"/> </td>
                <td> <input name="algorithm" size="4" value="<%=email %>"/> </td> 
                <td> <input name="bit_length" size="4" value="<%=status %>"/> </td> 
                <td> <input name="type" size="12" value="<%=description %>"/> </td> 

                </b>
            </tr>
            
            <%
                
    String color = "";            
    while (rs.next()) {
        
        /*
            if ( (Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 0 ) 
            {
                color="#ff0000";
            }
            
             else if ( ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 > 0) &&  ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 10)) 
            {
                color="#ff69b4";
            }
             
            else if ( ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 > 10) &&  ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 20)) 
            {
                color="#ffbf00";
            } 
            
             else if ( ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 > 20) &&  ((Convert_to_longint(rs.getString("EXPIRY_DATE"))-ToDay())/86400000 <= 30)) 
            {
                color="#ffbf00";
            }
            
            else { color="black"; }
            **/

                %>

                 
            <tr style="color: <%=color%>; background: white;"> <td> <a href="edit_member.jsp?action=edit&id=<%=rs.getString(id.toString())%> "> EDIT </a></td> <td><a href='#' onclick=" if (confirm('Delete Certificate\nAre   you sure?')){ document.forms['certs'].action='edit_member.jsp?id=<%=rs.getString(id.toString())%>&action=delete';document.forms['certs'].submit();} else { void(''); };"> DELETE </a></td> 
                <td> <%=rs.getString(id.toString())%>  </td>  
                <td> <%=rs.getString("name")%>  </td> 
                <td> <%=rs.getString("surname")%>  </td> 
                <td> <%=rs.getString("fathers_name")%>  </td> 
                <td> <%=rs.getString("birth_date")%>  </td> 
                <td> <%=rs.getString("phone")%> </td> 
                <td> <%=rs.getString("email")%> </td>
                <td> <%=rs.getString("status")%> </td>
                <td> <%=rs.getString("description")%> </td>
            </tr>
                 
            <% 
            

    }
    stmt.close();
    con.close();
}
catch (Exception e)
{
       String error=e.toString();
         %>
               <script type="text/javascript">
                   alert("Error: <%=error%>");
               </script>
        <%
}
 

    %>
   </table>
    </FORM>
</html>
<%


    }



%>
