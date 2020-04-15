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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>机台看板</title>
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
	function check() {
		document.getElementById('myForm').submit();
	}
	setInterval("check()",1000);
</script>
<body onload="check()">
	<!-- 17.1 -->
	<form id="myForm"
		action="<%=path%>/ctm.action?methodstr=selectEqptStatus1"
		method="post" enctype="multipart/form-data">
		<table class="table table-striped table-bordered table-hover"
			id="sample-table-1" width="50%">
			<thead>
				<tr>
					<th>机台名称</th>
					<th>五位批次头</th>
					<th>级别</th>
					<th>蓝膜号</th>
					<th>当前蓝膜数量</th>
					<th>操作时间</th>
					<th>派料员</th>
					<input type="hidden" name="workId" value="<%=workId%>" />
				</tr>
			</thead>
		</table>
	</form>
</body>
</html>