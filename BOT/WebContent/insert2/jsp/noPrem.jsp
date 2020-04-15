<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递

	if (workId == "" || workId == "null") {

		out.print("<script>alert('工号不存在')</script>");
		out.print("<a> 13</a>");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'selec</title>

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css"
	href="./js/jquery.datetimepicker.css" />
</head>
<script type="text/javascript">
	function login() {
		alert("很抱歉，您无权限！");
		location.href = "javascript:window.open('','_parent','');window.close()"
	}
</script>
<body onload="login()">
</body>
</html>
