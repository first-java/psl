<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
</head>
<script>
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交rt(s);
	}
</script>
<body onload="check()">

	<form action="findPage.action?page.pageno=1" id="myForm" method="post">
		<input type="hidden" id="s" />
		</from>
		<center>
			<a href="insert.jsp">添加</a>
			<table border="1">
				<tr>
					<td>部门编号</td>
					<td>部门名称</td>
					<td>部门地址</td>
					<td>操作</td>
				</tr>
				<c:forEach var="i" items="${requestScope.list}">
					<tr>
						<td>${i.deptno}</td>
						<td>${i.dname}</td>
						<td>${i.loc}</td>
						<td><a href="delete.action?dept.deptno=${i.deptno}">删除</a>
							&nbsp;|&nbsp; <a href="findById.action?dept.deptno=${i.deptno}">修改</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			第${page.pageno}/${page.totalpage }页 <a
				href="findPage.action?page.pageno=1">首页</a>&nbsp;
			<c:choose>
				<c:when test="${page.pageno>1}">
					<a href="findPage.action?page.pageno=${page.pageno-1 }">上一页</a>&nbsp;
        </c:when>
				<c:otherwise>
					<a href="javascript:alert('已经是第一页了！');">上一页</a>&nbsp;
        
        </c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${page.pageno<page.totalpage}">
					<a href="findPage.action?page.pageno=${page.pageno+1 }">下一页</a>&nbsp;
        </c:when>
				<c:otherwise>
					<a href="javascript:alert('已经是最后一页了！');">上一页</a>&nbsp;
        
        </c:otherwise>
			</c:choose>
			<a href="findPage.action?page.pageno=${page.totalpage}">末页</a>&nbsp;
			总${page.totalcount }条
		</center>
</body>
</html>