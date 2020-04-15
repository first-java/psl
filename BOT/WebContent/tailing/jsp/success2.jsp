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
	<%-- <c:if test="${empty querySuccess }">
查无数据
<a href="javascript:history.back(-1)">返回上一页</a> --%>

	<c:if test="${not empty querySuccess }">
		<table border="1">
			<tr>
				<td>箱号</td>
				<td>蓝膜号</td>
				<td>数量</td>
				<td>material_NAME</td>
				<td>批次头前五位</td>
				<td>工号</td>
				<td>入库时间</td>
			</tr>
			<c:forEach items="${querySuccess }" var="s">
				<tr>
					<td>${s.caseNo}</td>
					<td>${s.filmNo}</td>
					<td>${s.pcs}</td>
					<td>${s.remark}</td>
					<td>${s.root_lot_id}</td>
					<td>${s.workid}</td>
					<td>${s.creat_time}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test="${empty query }">
		<c:if test="${empty querySuccess }">
查无数据
<a href="javascript:history.back(-1)">返回上一页</a>
		</c:if>
	</c:if>
	<c:if test="${not empty query}">
		<table border="1">
			<tr>
				<td>箱号</td>
				<td>蓝膜号</td>
				<td>数量</td>
				<td>创建时间</td>
				<td>工号</td>
				<td>级别</td>
				<td>批次头前五位</td>
			</tr>
			<c:forEach items="${query }" var="s">
				<tr>
					<td>${s.caseNo}</td>
					<td>${s.filmNo}</td>
					<td>${s.pcs}</td>
					<td>${s.creat_time}</td>
					<td>${s.workid}</td>
					<td>${s.remark}</td>
					<td>${s.root_lot_id}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>
