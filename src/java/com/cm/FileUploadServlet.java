package com.cm;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.cert.CertificateException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet(name = "FileUploadServlet", urlPatterns = {"/CM"})
@MultipartConfig
public class FileUploadServlet extends HttpServlet {

    private final static Logger LOGGER = 
            Logger.getLogger(FileUploadServlet.class.getCanonicalName());
    
protected void processRequest(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException, CertificateException {
    response.setContentType("text/html;charset=UTF-8");

    // Create path components to save the file
    final String path = request.getParameter("destination");
    final String cert_type = request.getParameter("cert_type");
    final String cert_pass = request.getParameter("cert_pass");
    final Part filePart = request.getPart("file");
    final String fileName = getFileName(filePart);

    OutputStream out = null;
    InputStream filecontent = null;
    final PrintWriter writer = response.getWriter();
    final String file_full_path = path + File.separator + fileName;
            
    try {
        out = new FileOutputStream(new File(path + File.separator
                + fileName));
        
        filecontent = filePart.getInputStream();

        int read = 0;
        final byte[] bytes = new byte[1024];

        while ((read = filecontent.read(bytes)) != -1) {
            out.write(bytes, 0, read);
        }
        writer.println("New file " + fileName + " created at " + path);
        
                             ////////////////////////////////

        
              ReadCert RC = new ReadCert();
              String[] a;
              a = new String[10];
              
                switch (cert_type) {
                    case "0":
                       a = RC.Read_PEM_DER_Cert(file_full_path);
                       for (String a1 : a) {
                        writer.println(a1);
                        writer.println("</br>");
                         }  
                        break;
                    case "1":
                         a = RC.Read_PKCS7_Cert(file_full_path);
                         for (String a1 : a) {
                            writer.println(a1);
                            writer.println("</br>");
             }  
                        break;
                    case "2":
                         RC.Read_PFX_Cert(file_full_path, cert_pass); 
                         for (String a1 : a) {
                            writer.println(a1);
                            writer.println("</br>");
             }  
                        break;
                    case "3":
                         RC.Read_JKS(file_full_path, cert_pass);
                         for (String a1 : a) {
                            writer.println(a1);
                            writer.println("</br>");
             }  
                        break;
                    default:
                        writer.println("Select Certificate Type" );
                        break;
                        
                        
                }
                
                if (a == null)
                {
                    writer.println("Invalid Certificate Type or Coppupted Certificate File" );
                    writer.println("<li><a hrep='upload_cert.jsp'> Return Back </a></li>");
                }
                       
            //////////////////////////////////
           
        
        
        LOGGER.log(Level.INFO, "File{0}being uploaded to {1}", 
                new Object[]{fileName, path});
    } catch (FileNotFoundException fne) {
        writer.println("You either did not specify a file to upload or are "
                + "trying to upload a file to a protected or nonexistent "
                + "location.");
        writer.println("<br/> ERROR: " + fne.getMessage());

        LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}", 
                new Object[]{fne.getMessage()});
    } finally {
        if (out != null) {
            out.close();
        }
        if (filecontent != null) {
            filecontent.close();
        }
        if (writer != null) {
            writer.close();
        }
    }
}

private String getFileName(final Part part) {
    final String partHeader = part.getHeader("content-disposition");
    LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
    for (String content : part.getHeader("content-disposition").split(";")) {
        if (content.trim().startsWith("filename")) {
            return content.substring(
                    content.indexOf('=') + 1).trim().replace("\"", "");
        }
    }
    return null;
}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (CertificateException ex) {
            Logger.getLogger(FileUploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (CertificateException ex) {
            Logger.getLogger(FileUploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
