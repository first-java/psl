<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<%@ page trimDirectiveWhitespaces="true"%>
<title>My JSP 'batch.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<c:if test="${empty que }">
没有查到结果
</c:if>


	<c:if test="${not empty que }">
		<table border="1">
			<tr>
				<td>RelationID</td>
				<td>ProductType</td>
				<td>UnitType</td>
				<td>UnitSize</td>
				<td>UnitElec</td>
				<td>RelationVol</td>
				<td>ProductID</td>
				<td>K_Flag</td>
				<td>DelQty</td>
				<td>ModFlag</td>
			</tr>
			<c:forEach items="${que }" var="bath">
				<tr>
					<td>${bath.relationID }</td>
					<td>${bath.productType }</td>
					<td>${bath.unitType }</td>
					<td>${bath.unitSize }</td>
					<td>${bath.unitElec }</td>
					<td>${bath.relationVol }</td>
					<td>${bath.productID }</td>
					<td>${bath.k_Flag }</td>
					<td>${bath.delQty }</td>
					<td>${bath.modFlag }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

</body>
</html>
