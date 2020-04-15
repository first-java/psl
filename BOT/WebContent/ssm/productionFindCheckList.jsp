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
<title>动态创建按钮</title>
<script src='http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js'></script>
</head>
<script>
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交
	}
</script>
<body>
	<form id="myForm" action="<%=path%>/re.action?methodstr=queryList"
		method="post">
		卷轴号查检查单： <input type="text" name="barcode" /> <input type="submit"
			id="" value="查询" class="btn btn-primary" />
	</form>
	<c:if test="${not empty  requestScope.query}">
		<div>
			<table class="table table-striped table-bordered table-hover"
				id="sample-table-1">
				<thead>
					<tr>
						<th>检查单名称</th>
						<th>产品型号</th>
						<th>创建时间</th>
						<th>数量</th>
						<th>操作</th>
						<input type="hidden" name="workId" value="<%=workId%>" />
					</tr>
				</thead>
				<c:forEach items="${requestScope.query }" var="bath">
					<tr>
						<td>${bath.odd}</td>
						<td>${bath.productModel}</td>
						<td>${bath.createTime}</td>
						<td>${bath.quantity}</td>
						<td><form id="myForm"
								action="<%=path%>/re.action?methodstr=query" method="post">
								<input type="hidden" value="${bath.odd} " name="inspection" />
								<input type="submit" id="" value="审核" class="btn btn-primary" />
							</form></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	<c:if test="${not empty  queryList}">
		<div>
			<table class="table table-striped table-bordered table-hover"
				id="sample-table-1">
				<thead>
					<tr>
						<th>检查单名称</th>
						<th>产品型号</th>
						<th>创建时间</th>
						<th>数量</th>
						<th>操作</th>
						<input type="hidden" name="workId" value="<%=workId%>" />
					</tr>
				</thead>
				<c:forEach items="${queryList }" var="bath">
					<tr>
						<td>${bath.odd}</td>
						<td>${bath.productModel}</td>
						<td>${bath.createTime}</td>
						<td>${bath.quantity}</td>
						<td><form id="myForm"
								action="<%=path%>/re.action?methodstr=query" method="post">
								<input type="hidden" value="${bath.odd} " name="inspection" />
								<input type="submit" id="" value="审核" class="btn btn-primary" />
							</form></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	<c:if test="${ empty  requestScope.query}">
		<c:if test="${ empty  queryList}">
		没有查到结果
		</c:if>
	</c:if>
</body>
</html>