<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>模板</title>
<base href="<%=basePath%>">

</head>
<body>
	<table border="1" align="center">
		<tr>
			<td>BARCODE_ID</td>
			<td>STORAGE_ID</td>
			<td>MATERIAL_NAME</td>
		</tr>
		<tr>
			<td>特采条码号</td>
			<td>特采存货编码</td>
			<td>特采级别</td>
		</tr>
		<tr>
			<td>AFN00088888</td>
			<td>6FNP2ECB</td>
			<td>FN-B-3-F3-T</td>
		</tr>
	</table>
</body>
</html>