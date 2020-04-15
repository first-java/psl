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
	}
 */%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

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
<body >
	<a href="findPage.action?page.pageno=1">查看卷轴状态</a>
</body>
</html>
