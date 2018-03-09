<%-- 
    Document   : login
    Created on : Sep 5, 2017, 4:56:10 PM
    Author     : Sanan Garibli
--%>


<%@page import="com.cs.DbConnect"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@ page import ="java.sql.*" %>
<%
    


    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    try {
        DbConnect DB = new DbConnect();
        Connection con = DB.getConnection();
    
    PreparedStatement stmt = con.prepareStatement("select uname, IFNULL(TYPE,2) TYPE from USERS where status=0 and uname=? and pass=password(?)");
    stmt.setString(1, userid);
    stmt.setString(2, pwd);
    ResultSet rs;
    rs = stmt.executeQuery();
    if (rs.next()) {
        session.setAttribute("userid", userid);
        session.setAttribute("USER_TYPE", rs.getInt("TYPE"));
        response.sendRedirect("success.jsp?table_name=s");
        }
    
    
    else {
        
        %>
              <script type="text/javascript">
                alert("Incorrect username or password ");
                 window.location.href='index.jsp';
                document.getElementById("uname").focus();
              </script>
          
  <%
    }
    stmt.close();
    con.close();
    }
    catch (Exception e)
    {
           String error=e.toString();
           out.println(error);
         %>
               <script type="text/javascript">
                   alert("Error: <%=error%>");
               </script>
        <%
    }
%>
