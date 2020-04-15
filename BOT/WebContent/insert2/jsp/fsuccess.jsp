
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String workId = request.getParameter("id");//直接传递
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	border-collapse: collapse;
	border-spacing: 0;
}

table th {
	/* background: #0090D7; */
	font-weight: normal;
	line-height: 30px;
	font-size: 24px;
	color: #444444;
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

<html>
<head>
<title>查询</title>
<style>
.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 1001;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 88);
}

.white_content {
	display: none;
	position: absolute;
	top: 25%;
	left: 25%;
	width: 55%;
	height: 55%;
	padding: 20px;
	border: 8px solid #2E6AA8;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
</head>
<body>

	<c:if test="${empty que }">
		 没有查到数据
	</c:if>
	<c:if test="${not empty que }">
		<table border="1" width="1000%"
			style="font-family:'宋体'; font-size:16px;">
			<tr>
				<td>UnitID</td>
				<td>TBinID</td>
				<td>TLotID</td>
				<td>StorageID</td>
				<td>ModelID</td>
				<td>S_Flag</td>
				<td>ChipVer</td>
				<td>Qty</td>
				<td>Confirm_UID</td>
				<td>Confirm_TIME</td>
				<td>File_Name</td>
			</tr>
			<c:forEach items="${que }" var="p">
				<tr>
					<td>${p.unitID}</td>
					<td>${p.tBinID}</td>
					<td>${p.tLotID}</td>
					<td>${p.storageID}</td>
					<td>${p.modelID}</td>
					<td>${p.s_Flag}</td>
					<td>${p.chipVer}</td>
					<td>${p.qty}</td>
					<td>${p.confirm_UID}</td>
					<td>${p.confirm_TIME}</td>
					<td><a href="image.jsp?id=${p.file_Name}" target="_blank">
							${p.file_Name} </a>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>