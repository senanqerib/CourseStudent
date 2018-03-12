/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Acer
 */
public class INSUPD_DB {
    
    public int DB_Insert_Update(String command,
                                String table_name, 
                                String name, 
                                String surname, 
                                String fathers_name, 
                                String birth_date, 
                                String phone, 
                                String email, 
                                int  status, 
                                String description ) throws SQLException, IOException
    {
    DbConnect DB = new DbConnect();
    Connection con = DB.getConnection();
    
    String sql_query;
    if (command.equals("update"))
        sql_query = "update " + table_name + " set name=?, surname=?,  fathers_name=?, "
                     + "birth_date=?, phone=?, email=?, status=?, description=? "; /// uncomplete - ReCorrect
    else 
        sql_query = "insert into " + table_name + " (name, surname, fathers_name, birth_date,phone, email, status,description) "
                  + "values (?,?,?,?,?,?,?,?)";
    
    PreparedStatement stmt = con.prepareStatement(sql_query);
    
    
    stmt.setString(1, name);
    stmt.setString(2, surname);
    stmt.setString(3, fathers_name);
    stmt.setString(4, birth_date);
    stmt.setString(5, phone);
    stmt.setString(6, email);
    stmt.setInt(   7, status);
    stmt.setString(8, description);
    System.out.println(stmt);
   
    
    int i=stmt.executeUpdate();
    con.close();
    
    if (i>0)
        return 0;
    else 
        return -1;
    
    }
    
}
