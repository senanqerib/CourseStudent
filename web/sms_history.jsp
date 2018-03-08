<%-- 
    Document   : sms_history
    Created on : Sep 20, 2017, 10:26:47 AM
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
   <title>SMS History Page</title>
  <meta charset="UTF-8">
   <link rel="stylesheet" href="css/style_table.css">
   <jsp:include page="header.jsp" />
</head>
</html>



<%
    
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {        
        response.sendRedirect("index.jsp");    
    } else {


         String s_id = "%";
         String t_id = "%";
         String l_id = "%";
         String sms_text = "%";
         String phone = "%";
         String sent_date = "%";
         String sms_response = "%";
         
         
        if (request.getParameter("s_id") != null) {         s_id =            request.getParameter("s_id"); }
        if (request.getParameter("t_id") != null) {         t_id =            request.getParameter("t_id"); }
        if (request.getParameter("l_id") != null) {         l_id =            request.getParameter("l_id"); }
        if (request.getParameter("sms_text") != null) {     sms_text =          request.getParameter("sms_text"); }
        if (request.getParameter("phone") != null) {        phone =             request.getParameter("phone"); }
        if (request.getParameter("sent_date") != null) {    sent_date =         request.getParameter("sent_date"); }
        if (request.getParameter("sms_response") != null) { sms_response =      request.getParameter("sms_response"); }
        
    
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
    
    String select_query =  "SELECT  s_id, t_id, l_id,  phone,  sent_date, sms_response, sms_text  FROM sms_history "
                         + " WHERE s_id LIKE ? AND t_id LIKE ? AND l_id LIKE ? AND PHONE  LIKE ?  AND sent_date LIKE ? AND sms_response LIKE ? AND sms_text LIKE ?";


        PreparedStatement stmt = con.prepareStatement(select_query);
        stmt.setString(1, "%" + s_id + "%");
        stmt.setString(2, "%" + t_id + "%");
        stmt.setString(3, "%" + l_id + "%");
        stmt.setString(4, "%" + phone + "%");
        stmt.setString(5, "%" + sent_date + "%");
        stmt.setString(6, "%" + sms_response + "%");
        stmt.setString(7, "%" + sms_text + "%");

        ResultSet rs = stmt.executeQuery();
%>
 
    <FORM id="cert" name="certs" method="POST" ACTION="#" >
        <table class="responsive-table">
            <tr>
                <td><b> Student ID  </b> </td> 
                <td><b> Teacher ID  </b> </td> 
                <td><b> Lesson ID  </b> </td> 
                <td><b> Phone  </b> </td> 
                <td><b> Sent Date </b> </td> 
                <td><b> SMS Response  </b> </td>
                <td><b> SMS Text </b> </td>
            </tr> 
            
           <tr>
               
                

                <input type="submit" value="Filter" style="position: absolute; left: -9999px; width: 1px; height: 1px;" tabindex="-1" />
                <td> <input name="s_id" size="4" value="<%=s_id %>" /> </td> 
                <td> <input name="t_id" size="4" value="<%=t_id %>" /> </td> 
                <td> <input name="l_id" size="4" value="<%=l_id %>" /> </td> 
                <td> <input name="phone" size="12" value="<%=phone %>"/> </td> 
                <td> <input name="sent_date" size="12" value="<%=sent_date %>"/> </td> 
                <td> <input name="sms_response" size="12" value="<%=sms_response %>"/> </td> 
                <td> <input name="sms_text" size="36" value="<%=sms_text %>"/> </td>
                
                </b>
            </tr>
            
            <%
                       
    while (rs.next()) {


                %>

                <td> <%=rs.getString("s_id")%>  </td>  
                <td> <%=rs.getString("t_id")%>  </td>  
                <td> <%=rs.getString("l_id")%>  </td>  
                <td> <%=rs.getString("phone")%>  </td> 
                <td> <%=rs.getString("sent_date")%>  </td> 
                <td> <%=rs.getString("sms_response")%>  </td> 
                <td> <%=rs.getString("sms_text")%>  </td> 

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
<%


    }



%>
