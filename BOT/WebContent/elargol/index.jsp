<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="icon"
	href="<%=request.getContextPath()%>/layui/images/face/14.gif"
	type="image/x-icon" />
<title>银胶查批次</title>
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
</head>
<script type="text/javascript">
	function run() {
		var fullName = document.getElementById("fullName").innerText; //td里只有字符的时候
	}
</script>
<body>
	<form action="findPage1.action?page.pageno=1" id="myForm" method="post">

		<div class="page-header">
			<table align="left">
				<tr>
					<input id="clickMe" type="hidden" onclick="setFocus()"
						value="Set focus" />
					<td id="tt">扫描二维码：<input id="barcode1" name="fullName"
						type="text" size="28"
						onkeyup="this.value=this.value.toUpperCase().trim()"
						onkeypress='if(event.keyCode==13) check2();'> <input
						type="hidden" id='barcode2' onclick="setFocus()"> <input
						type="hidden" id="ajaxA" onclick="setFocus()" />
					</td>
				</tr>
				<input type="submit" id="s" value="查询" />
			</table>
		</div>
		</from>
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<th>二维码信息</th>
				<th>采集时间</th>
				<th>添加人</th>
				<th>批号</th>
			</tr>
			<c:if test="${not empty list }">
				<c:forEach var="i" items="${requestScope.list}">
					<tr>
						<td id="fullName">${i.fullName}</td>
						<td><fmt:formatDate value="${i.inTime}"
								pattern="yyyy年MM月dd日 hh时mm分ss秒" /></td>
						<td>${i.inUser}</td>
						<td>${i.lotId}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		第${page.pageno}/${page.totalpage }页 <a
			href="findPage1.action?page.pageno=1&&fullName=${list[0].fullName }"><span
			id="sp">首页</span></a>&nbsp;
		<c:choose>
			<c:when test="${page.pageno>1}">
				<a  href="findPage1.action?page.pageno=${page.pageno-1 }&&fullName=${list[0].fullName }">上一页</a>&nbsp;
        </c:when>
			<c:otherwise>
				<a href="javascript:layer.msg('已经是第一页了！', {icon : 2}); ">上一页</a>&nbsp;
        
        </c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${page.pageno<page.totalpage}">
				<a  href="findPage1.action?page.pageno=${page.pageno+1 }&&fullName=${list[0].fullName }">下一页</a>&nbsp;
        </c:when>
			<c:otherwise>
				<a href="javascript:layer.msg('已经是最后一页了！', {icon : 2}); ">下一页</a>&nbsp;
        
        </c:otherwise>
		</c:choose>
		<a
			href="findPage1.action?page.pageno=${page.totalpage}&&fullName=${list[0].fullName }">末页</a>&nbsp;
		总${page.totalcount }条
</body>
</html>