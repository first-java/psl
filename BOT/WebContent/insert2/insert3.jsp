<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String newname = (String) request.getAttribute("newname");
	%>
	<%="save success....."%><br /> 上传的图片是：11
	<br />

	<img src="picture/<%=newname%>">
	${newname }
	${path }
	<br />

</body>
</html>