<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");//直接传递
%>
<%
	String eqptId = (String) request.getParameter("eqptId");//直接传递
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>设置货架存放产品</title>
<base href="<%=basePath%>">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/print.css" media="all">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/ace.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/assets/css/bootstrap.min.css"
	media="all">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css"
	media="all">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function check1() {
		var shelfName = $("#shelfName").val();
		var floors = $("#floors").val();
		if ((floors == "") || (shelfName == "")) {
			layer.msg('请输入要清空的对象！', {
				icon : 2
			});
			return false;
		}
		layer.confirm("确定重置该货架层数的产品吗？", {
			btn : [ '确定', '取消' ],
			title : "提示"
		}, function() {
			document.getElementById('myForm1').submit();
		});
	}

	function check() {
		var shelfName = $("#shelfName1").val();
		if ((shelfName == "") || (shelfName == "")) {
			layer.msg('还没输入货架！', {
				icon : 2
			});
			return false;
		}

		document.getElementById('myForm').submit();

	}
</script>
<body>
	<div class="page-header">
		<form id="myForm"
			action="<%=path%>/ctm.action?methodstr=shelfProduct2" method="post"
			enctype="multipart/form-data">
			<table id="sample-table-1" width="50%">
				<thead>
					<tr>
						<td>查找货架： <input type="text" placeholder='请输入货架'
							name="counter.shelfName" value="" id="shelfName1" />&nbsp;&nbsp;<input
							class="btn btn-primary" type="button" onclick="check();"
							value="搜索" /></td>
					</tr>
				</thead>
			</table>
		</form>
	</div>

	<c:if test="${not empty que }">
		<table class="table table-striped table-bordered table-hover"
			id="mytable" width="50%">
			<thead>
				<tr>
					<th>货架名</th>
					<th>箱号</th>
					<th>已设置的产品类型</th>
					<th>已设置的存放类型</th>
					<th>bin号</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
			<c:forEach items="${que }" var="bath">
				<tr>
					<td>${bath.shelfName}<p style="display: none">,</p></td>
					<td><a>
							<p style="display: none">,</p>${bath.caseNo}<p
								style="display: none">,</p>
							<p style="display: none">,</p>
					</a></td>
					<td>${bath.product }</td>
					<td>${bath.deposit }</td>
					<td>${bath.bin }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>