<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page
	import="java.sql.*, java.util.*, java.net.*, 
   oracle.jdbc.*, oracle.sql.*"%>

	<%
		// Change these details to suit your database and user details

		String dbURL = "jdbc:oracle:thin:@10.129.44.104:1521:OICEHLXP";
		String username = "jlopezj";
		String password = "ANDYari146791";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String Salida = "";
		String ip = "10.129.47.109";

		try {
			conn = DriverManager.getConnection(dbURL, username, password);
			
			String SqlStrSinPar="";
			
			String SqlStr = "SELECT DISTINCT ma.ACCESS_NAME, mn.NE_NAME, mp2.PLUGIN_NAME, mpv.VAR_NAME, mvv.VAR_value, ma.ACC_STATUS ";
			SqlStr = SqlStr + "FROM COMM_DB.MED_ACCESS ma ";
			SqlStr = SqlStr + "JOIN COMM_DB.MED_SUBNET_NE msn ON ma.SUBNET_NUM = msn.SUBNET_NUM ";
			SqlStr = SqlStr + "JOIN COMM_DB.MED_NE mn ON msn.NE_NUM = mn.NE_NUM ";
			SqlStr = SqlStr + "JOIN COMM_DB.MED_PLUGIN mp2 ON ma.PLUGIN_NUM = mp2.PLUGIN_NUM ";
			SqlStr = SqlStr + "JOIN COMM_DB.MED_PROTOCOL_VARIABLES mpv ON mp2.PLUGIN_NUM = mpv.PLUGIN_NUM ";
			SqlStr = SqlStr
					+ "JOIN COMM_DB.MED_VARIABLES_VALUES mvv ON  (mpv.PROT_VAR_NUM = mvv.PROT_VAR_NUM and mvv.entity_num = ma.access_num) ";
			SqlStr = SqlStr
					+ "WHERE mp2.PLUGIN_NAME not in ( 'SnmpCommandPlugin             ','StreamPlugin/SSH              ' ,'ICMPPlugin                    ') ";
			SqlStr = SqlStr + "AND mpv.VAR_NAME LIKE '%Port%' ";
			
			SqlStrSinPar=SqlStr;
						
			if ( request.getParameter("puerto") != null ){
			 if (request.getParameter("puerto").compareTo("Escoja Puerto") != 0 && request.getParameter("puerto").compareTo("") != 0){
			  SqlStr = SqlStr + " AND mvv.VAR_VALUE = '"+request.getParameter("puerto")+"'";
			 }
			}
			
			/*
			if ( request.getParameter("plugin") != null ){
			 if (request.getParameter("plugin").compareTo("Escoja Plugin") != 0 && request.getParameter("plugin").compareTo("") != 0){
			  SqlStr = SqlStr + " AND mps.PLUGIN_NAME = '"+request.getParameter("plugin")+"'";
		     }
			}
            */
			
			SqlStr = SqlStr + "ORDER BY ma.ACCESS_NAME ASC";
			
			
			Salida = Salida + "<html>";
			Salida = Salida + "<head>";
			Salida = Salida + "<style type=\"text/css\">";
			Salida = Salida + "#final{display:none;}";
			Salida = Salida + "body{";
			Salida = Salida + "color: #0000A0;";
			Salida = Salida + "}";
			Salida = Salida + "table td {";
			Salida = Salida + "color: #ffffff";
			Salida = Salida + "}";
			Salida = Salida + "</style>";
			Salida = Salida + "<title>Puertos de Helix</title>";
			Salida = Salida + "</head>";
			Salida = Salida + "<body  style=\"font-family:Arial\" bgcolor=\"#ffffff\" color:\"#FFFFFF\">";
			Salida = Salida + "<center>";
			
			Salida = Salida + "<p><img src=\"http://" + ip 
					+ ":8080/PuertosHelix.jpg\" widtd=\"1046\" height=\"276\"></p>";
			Salida = Salida + "<div id=\"final\"></div>";
			Salida = Salida + "<br>";
			Salida = Salida + "<br>";
			Salida = Salida + "<br>";
			Salida = Salida + "<br>";
			
			ps = conn.prepareStatement(SqlStrSinPar);
			rs = ps.executeQuery();
			
			Salida = Salida + "<form action=\"http://10.129.47.109:8080/puertoshelix/puertos.jsp\" method=\"post\">";
			
			Salida = Salida + "<table id=\"tabla3\" width=\"457\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";	    
			Salida = Salida + "<tbody>";
			Salida = Salida + "<tr>";
			Salida = Salida + "<td colspan=\"4\"><img src=\"http://" + ip + ":8080/ArribaUsuarios.jpg\" width=\"457\" height=\"18\" alt=\"\"/></td>";
			Salida = Salida + "</tr>";		
						
		    HashSet puertos = new HashSet();
		    HashSet plugins = new HashSet();
		    	    
		    while (rs.next()) {		    
			    puertos.add(rs.getString(5));
			    plugins.add(rs.getString(3));
		    }
			
		    Salida = Salida + "<tr>";	    
		    Salida = Salida + "<td width=\"5\" background=\"http://" + ip + ":8080/bgazul.jpg\" height=\"40\"><img src=\"http://" + ip + ":8080/Palito.jpg\" width=\"5\" height=\"40\"/></td>";
		    Salida = Salida + "<td width=\"30\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\" align=\"left\">Puerto</td>";
		    Salida = Salida + "<td width=\"30\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\" align=\"left\">";
		    Salida = Salida + "<select name=\"puerto\">";
		    Salida = Salida + "<option value=\"Escoja Puerto\">Escoja Puerto</option>";
		    	    
		    for ( Object puerto  : puertos ){
		    	Salida = Salida + "<option value=\""+puerto.toString()+"\">"+puerto.toString()+"</option>";	
		    }
		    
		    Salida = Salida + "</select>";		    
		    Salida = Salida + "</td>";
		    
		        	    
		    Salida = Salida + "<td width=\"5\" background=\"http://" + ip + ":8080/bgazul.jpg\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\"><img src=\"http://" + ip + ":8080/Palito.jpg\" width=\"5\" height=\"40\" align=\"right\"/></td>";
		    Salida = Salida + "</tr>";
		    

		    /*
		    Salida = Salida + "<tr>";	    
		    Salida = Salida + "<td width=\"5\" background=\"http://" + ip + ":8080/bgazul.jpg\" height=\"40\"><img src=\"http://" + ip + ":8080/Palito.jpg\" width=\"5\" height=\"40\"/></td>";
		    Salida = Salida + "<td width=\"30\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\" align=\"left\">Plugin</td>";	
		    Salida = Salida + "<td width=\"30\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\" align=\"left\">";
		    Salida = Salida + "<select name=\"plugin\">";
		    Salida = Salida + "<option value=\"Escoja Plugin\">Escoja Plugin</option>";
		    	    
		    for ( Object plugin  : plugins ){
		    	Salida = Salida + "<option value=\""+plugin.toString()+"\">"+plugin.toString()+"</option>";	
		    }
		    
		    Salida = Salida + "</select>";		    
		    Salida = Salida + "</td>";		    	    	    
		    Salida = Salida + "<td width=\"5\" background=\"http://" + ip + ":8080/bgazul.jpg\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\"><img src=\"http://" + ip + ":8080/Palito.jpg\" width=\"5\" height=\"40\" align=\"right\"/></td>";
		    Salida = Salida + "</tr>";
		    */	
		    
		    Salida = Salida + "<tr>";
		    Salida = Salida + "<td width=\"5\" background=\"http://" + ip + ":8080/bgazul.jpg\" height=\"40\"><img src=\"http://" + ip + ":8080/Palito.jpg\" width=\"5\" height=\"40\"/></td>";
		    Salida = Salida + "<td width=\"30\" background=\"http://" + ip + ":8080/bgazul.jpg\"></td>";

		    Salida = Salida + "<td width=\"30\" background=\"http://" + ip + ":8080/bgazul.jpg\" align=\"left\"><input type=\"image\" src=\"http://" + ip + ":8080/Consulta.jpg\" width=\"80\" height=\"31\"></td>";
		    
		    
		    
		    
		    Salida = Salida + "<td width=\"5\" background=\"http://" + ip + ":8080/bgazul.jpg\" height=\"40\" background=\"http://" + ip + ":8080/bgazul.jpg\"><img src=\"http://" + ip + ":8080/Palito.jpg\" width=\"5\" height=\"40\" align=\"right\"/></td>";
		    Salida = Salida + "</tr>";
		    
		    Salida = Salida + "<tr>";
		    Salida = Salida + "<td colspan=\"4\"><img src=\"http://" + ip + ":8080/AbajoUsuarios.jpg\" width=\"457\" height=\"18\" alt=\"\"/></td>";
		    Salida = Salida + "</tr>";
		    Salida = Salida + "</tbody>";
		    Salida = Salida + "</table>";
		    
		    Salida = Salida + "</form>";
		    
				
			Salida = Salida + "<table id=\"tabla2\" width=\"1221\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 10pt\">";
			Salida = Salida + "<tbody>";
			Salida = Salida + "<tr>";
			Salida = Salida + "<td colspan=\"8\"><img src=\"http://" + ip
					+ ":8080/ArribaUsuarios.jpg\" width=\"1221\" height=\"21\" alt=\"\"/></td>";
			Salida = Salida + "</tr>";


			int j = 1;
			String fondotd = "azul";

			
			Salida = Salida + "<tr style=\"color:#BFD62A\">";
			Salida = Salida + "<td width=\"8\" height=\"55\" background=\"" + "http://" + ip + ":8080/bgazul.jpg"
					+ "\" height=\"55\"><img src=\"" + "http://" + ip + ":8080/Palito.jpg"
					+ "\" width=\"8\" height=\"55\" align=\"left\"/></td>";

			Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
					+ "\">NOMBRE ACCESO</td>";
			Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
					+ "\">NOMBRE EQUIPO</td>";
			Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
					+ "\">NOMBRE PLUGIN</td>";
			Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
					+ "\">TIPO</td>";
			Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
					+ "\">PUERTO</td>";
			Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
					+ "\">ESTADO</td>";

			Salida = Salida + "<td width=\"8\" height=\"55\" background=\"" + "http://" + ip + ":8080/bgazul.jpg"
					+ "\" height=\"55\"><img src=\"" + "http://" + ip + ":8080/Palito.jpg"
					+ "\" width=\"8\" height=\"55\" align=\"right\"/></td>";
			Salida = Salida + "</tr>";

			ps = conn.prepareStatement(SqlStr);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				if (j % 2 == 0)
					fondotd = "azul";
				else
					fondotd = "celeste";
				j++;

				Salida = Salida + "<tr>";
				Salida = Salida + "<td width=\"8\" height=\"55\" background=\"" + "http://" + ip
						+ ":8080/bgazul.jpg" + "\" height=\"55\"><img src=\"" + "http://" + ip + ":8080/Palito.jpg"
						+ "\" width=\"8\" height=\"55\" align=\"left\"/></td>";

				Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
						+ "\">" + rs.getString(1) + "</td>";
				Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
						+ "\">" + rs.getString(2) + "</td>";
				Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
						+ "\">" + rs.getString(3) + "</td>";
				Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
						+ "\">" + rs.getString(4) + "</td>";
				Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
						+ "\">" + rs.getString(5) + "</td>";
				Salida = Salida + "<td width=\"20\" background=\"" + "http://" + ip + ":8080/bg" + fondotd + ".jpg"
						+ "\">" + rs.getString(6) + "</td>";

				Salida = Salida + "<td width=\"8\" height=\"55\" background=\"" + "http://" + ip
						+ ":8080/bgazul.jpg" + "\" height=\"55\"><img src=\"" + "http://" + ip + ":8080/Palito.jpg"
						+ "\" width=\"8\" height=\"55\" align=\"right\"/></td>";
				Salida = Salida + "</tr>";
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Salida = Salida + "<tr>";
		Salida = Salida + "<td colspan=\"8\"><img src=\"" + "http://" + ip + ":8080/AbajoUsuarios.jpg"
				+ "\" width=\"1221\" height=\"21\" alt=\"\"/></td>";
		Salida = Salida + "</tr>";
		Salida = Salida + "</tbody>";
		Salida = Salida + "</table>";
		//Salida = Salida + "</table>";
		Salida = Salida
				+ "<p><img src=\"http://10.129.47.109:8080/Footer.jpg\" width=\"1096\" height=\"150\" id=\"eleccion\"></p>";
		Salida = Salida + "</center>";
		Salida = Salida + "</body>";
		Salida = Salida + "</html>";

		out.println(Salida);
	%>



</body>
</html>