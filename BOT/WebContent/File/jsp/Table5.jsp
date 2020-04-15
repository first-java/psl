<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page isErrorPage="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	Exception ex = (Exception) request.getAttribute("Exception");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>导入正式表失败</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
body {
	background: #CCE8CF;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	background-size: cover;
	font-family: 华文新魏;
}
</style>
<script type="text/javascript">
	</script>
</head>
<body class="b" onload="javascript:window.alert(' 导入正式表失败  ')">
	<form action="chac.action" method="post">
		文件上传失败<br>
		${exception }
		
		<a href="javascript:history.back(-1)">返回上一页</a>
	</form>
</body>
</body>
</html>
