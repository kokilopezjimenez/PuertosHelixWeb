<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page
	import="java.sql.*, java.util.*, java.net.*, 
   oracle.jdbc.*, oracle.sql.*"%>

<%
  
  //initialize driver class
  try {    
    Class.forName("oracle.jdbc.driver.OracleDriver");
  } catch (Exception e) {
    out.println("Fail to initialize Oracle JDBC driver: " + e.toString() + "<P>");
  }
  
  String dbUser = "jlopezj";
  String dbPasswd = "ANDYari146791";
  String dbURL = "jdbc:oracle:thin:@10.129.44.104:1521:OICEHLXP";

  //connect
  Connection conn = null;
  try {
    conn = DriverManager.getConnection(dbURL,dbUser,dbPasswd);
    out.println(" Connection status: " + conn + "<P>");
    conn.close();
  } catch(Exception e) {
          
  }

  
  
%>  

<HTML>
<BODY>
Bye bye!  The system time is now <%= new java.util.Date() %>
</BODY>
</HTML>
</body>
</html>