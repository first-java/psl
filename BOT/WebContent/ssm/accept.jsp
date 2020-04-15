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
<title>登录成功</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		if (event.keyCode == 13) {
			$("#submitBtn").click(function() {

				$("#myForm").submit();

			});
		}
	});
</script>

<script type="text/javascript">
	function handleEnter(field, event) {
		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		if (keyCode == 13) {
			var i;
			for (i = 0; i < field.form.elements.length; i++)
				if (field == field.form.elements[i])
					break;
			i = (i + 1) % field.form.elements.length;
			field.form.elements[i].focus();
			return false;
		}
		else
			return true;
	}
</script>

</head>
<body>

	<form id="myForm" action="<%=path%>/re.action?methodstr=queryAccept"
		method="post">
		卷轴号查检查单： <input type="text" name="barcode" /> <input type="submit"
			id="" value="查询" class="btn btn-primary" />
	</form>
	<c:if test="${empty  requestScope.query}">
		没有查到结果</c:if>
	<c:if test="${not empty  requestScope.query}">
		<div>
			<table class="table table-striped table-bordered table-hover"
				id="sample-table-1">
				<thead>
					<tr>
						<th>检查单名称</th>
						<th>产品型号</th>
						<th>创建时间</th>
						<th colspan="2">操作</th>
						<input type="hidden" name="workId" value="<%=workId%>" />
					</tr>
				</thead>
				<c:forEach items="${requestScope.query }" var="bath">
					<tr>
						<td>${bath.odd}</td>
						<td>${bath.productModel}</td>
						<td>${bath.sendTime}</td>
						<td>
							<form id="myForm" action="<%=path%>/re.action?methodstr=look"
								method="post">
								<input type="hidden" value="${bath.odd} " name="inspection" />
								<input type="submit" class="btn btn-primary" id="" value="查看明细" />
							</form>
						</td>
						<td><form id="myForm"
								action="<%=path%>/re.action?methodstr=accept" method="post">
								<input type="hidden" value="${bath.odd} " name="inspection" />
								<input type="submit" class="btn btn-primary" id="" value="接收检查单" />
							</form></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
</body>
</html>