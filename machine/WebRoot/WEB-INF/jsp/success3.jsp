<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>查询</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<style>
body {
	padding: 0;
	margin: 0;
	font: normal 24px/48px "\5FAE\8F6F\96C5\9ED1";
	color: #444;
}

table {
	width: 80%;
	border: 0;
	margin: 0px auto 0;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
}

table th {
	background: #0090D7;
	font-weight: normal;
	line-height: 30px;
	font-size: 18px;
	color: #FFF;
}

table tr:nth-child(odd) {
	background: #F4F4F4;
}

table td:nth-child(even) {
	color: #C00;
}

table tr:nth-child(5) {
	background: #73B1E0;
	color: #FFF;
}

table tr:hover {
	background: #73B1E0;
	color: #FFF;
}

table td, table th {
	border: 1px solid #EEE;
}
</style>
<body>
<c:if test="${empty queryAll }">
没有查到结果
</c:if>
	<c:if test="${not empty queryAll }">
		<table border="1">
			<tr>
				<td>机种号</td>
				<td>贴带级别</td>

			</tr>
			<c:forEach items="${queryAll }" var="bath">
				<tr>
					<td>${bath.modelNo}</td>
					<td>${bath.product}${bath.sRa}${bath.cz}${bath.luminance}${bath.tension}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>
