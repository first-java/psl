<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/CSS/print.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Theme/Scripts/layer-v1.9.3/layer.js"></script>
<head>
<meta charset="utf-8">
<script type="text/javascript" src="js/jquery.js"></script>

<style>
</style>
<title>送出检查单</title>
<script src='http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js'></script>
</head>
<body>
	<div>
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1">
			<thead>
				<tr>
					<th>检查单名称</th>
					<th>产品型号</th>
					<th>创建时间</th>
					<th>卷轴号</th>
					<th>级别</th>
					<th>数量</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
			<c:forEach items="${query}" var="bath">
				<tr>
					<td>${bath.odd}</td>
					<td>${bath.productModel}</td>
					<td>${bath.customsTime}</td>
					<td>${bath.barcode}</td>
					<td>${bath.remark}</td>	
					<td>${bath.quantity}</td>
				</tr>
				
			</c:forEach>
		</table>
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1">

			<c:forEach items="${query}" var="bath" begin="0" end="0">
				<tr style="display:none;">
					<td>${bath.odd}</td>
					<td>${bath.productModel}</td>
					<td>${bath.customsTime}</td>
					<td>${bath.barcode}</td>
					<td>${bath.remark}</td>
					<td>${bath.whetheredor}</td>
					<td>${bath.quantity}</td>
				</tr>
				<tr>
					<form id="myForm" action="<%=path%>/re.action?methodstr=accept"
						method="post">
						<input type="hidden" value="${bath.odd} " name="inspection" /> <input
							type="submit" class="btn btn-primary" id="" value="接收检查单" />
					</form>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>