<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String workId = (String) request.getParameter("workId");
	/* if (workId == " " || workId == null) {
	
		out.print("<script>alert('工号有误！')</script>");
		out.print("<a href='#' onClick='javascript :history.back(-1);'>返回上一页</a>");
		return;
	} */
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link rel="stylesheet" href="<%=request.getContextPath() %>/Theme/CSS/print.css" media="all">

<link rel="stylesheet" href="<%=request.getContextPath() %>/Theme/assets/css/ace.min.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath() %>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet" href="<%=request.getContextPath() %>/Theme/assets/css/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/Theme/CSS/font-awesome-4.2.0/css/font-awesome.css" media="all">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/Theme/Scripts/layer-v1.9.3/layer.js"></script>
<script src="<%=request.getContextPath() %>/Theme/Scripts/My97DatePicker/WdatePicker.js"></script>
<head>
<title>登录成功</title>
<base href="<%=basePath%>">

</head>
<body>
<body>
	<c:if test="${not empty  query}">

		<div>
			<table class="table table-striped table-bordered table-hover"
				id="sample-table-1">
				<thead>
					<tr>
						<th>卷轴号</th>
						<th>蓝膜号</th>
						<th>数量</th>
						<th>创建时间</th>
						<th>序号</th>
					</tr>
				</thead>
				<c:forEach items="${query }" var="bath">
					<tr>
						<td>${bath.tapeId}</td>
						<td>${bath.filmNo}</td>
						<td>${bath.quantity}</td>
						<td>${bath.createtime}</td>
						<td>${bath.id}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	<a href="javascript:history.back(-1)">返回上一页</a>
</body>
</html>