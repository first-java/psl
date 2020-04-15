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
<head>
<meta charset="utf-8">
<title>品質送出</title>
<script src='http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js'></script>
</head>
<script>
	function check() {
		document.getElementById('myForm').submit(); //进行表单提交
	}
</script>
<body onload="check()">
	<form id="myForm" action="<%=path%>/re.action?methodstr=querySta"
		method="post" enctype="multipart/form-data">

		<input type="hidden" class="btn" id=" " value="查看检查单"
			onclick="check()" />

	</form>
</body>
</html>