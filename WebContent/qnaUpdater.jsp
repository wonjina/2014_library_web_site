<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("EUC-KR");

	String num = request.getParameter("NUM");
	String qna = request.getParameter("qna");
	
	String answer ="X";
	
	if(qna == "")	{
		answer = "X";
	}
	else answer ="O";
	
	if (qna.length() == 0){
		%>
		<script>
			alert("������ �Է����ּ���.");
			history.go(-1);
		</script>
		<%
	}
	else {

		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webdb","root","1234");
			if (conn == null)
				throw new Exception("�����ͺ��̽��� ������ �� �����ϴ�.");
			stmt = conn.createStatement();
			String command = String.format(
				"update board set answer:='%s', qna:='%s' where num=%s;",
				answer, qna, num);
			
			int rowNum = stmt.executeUpdate(command);
			if (rowNum < 1)
				throw new Exception("�����͸� DB�� �Է��� �� �����ϴ�.");
		}
		finally {
			try {
				stmt.close();
			}
			catch (Exception ignored) {
			}
			try {
				conn.close();
			}
			catch (Exception ignored) {
			}
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("Main.jsp?BODY_PATH=BoardContent.jsp?NUM="+num);
		dispatcher.forward(request, response);
	}
%>