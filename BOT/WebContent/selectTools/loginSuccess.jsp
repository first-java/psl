<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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

	function sb1() {
		var query = document.getElementById("quer");
		if (query.value == null || query.value == "") {
			alert("请输入方片号");
			return false;
		}

	}
	function sb2() {
		var queryF = document.getElementById("querys");
		if (queryF.value == null || queryF.value == "") {
			alert("请输入圆片号");
			return false;
		}
	}
	function sb3() {
		var queryY = document.getElementById("query");
		if (queryY.value == null || queryY.value == "") {
			alert("请输入方片号");
			return false;
		}
	}
	function sb4() {
		var querySY = document.getElementById("querya");
		if (querySY.value == null || querySY.value == "") {
			alert("请输入卷轴号");
			return false;
		}
	}
</script>
<style type="text/css">
span {
	font-family: 华文新魏;
	font-size: 24px;
	margin: 0;
}

.div {
	height: 40px;
	width: 100%;
	background: yellow;
}

.div2 {
	width: 50%;
}
</style>
</head>
<body>
	<div class="div2">
		<form id="myForm" action="selectTools.action?methodstr=batch"
			method="post" onsubmit="return sb1()">
			<table>
				<tr>
					<td>方片查卷轴，请输入方片：<input type="text" name="query" size="4"
						id="quer"> <input id="submitBtn" type="submit" value="查询" /></td>
				</tr>
			</table>
		</form>
		<form id="myForm" action="selectTools.action?methodstr=selectF"
			method="post" onsubmit="return sb2()">
			<table>
				<tr>
					<td>圆片查方片，请输入圆片：<input type="text" name="queryF" size="4"
						id="querys"> <input id="submitBtn" type="submit"
						value="查询" /></td>
				</tr>
			</table>
		</form>
		<form id="myForm" action="selectTools.action?methodstr=selectY"
			method="post" onsubmit="return sb3()">
			<table>
				<tr>
					<td>方片查圆片，请输入方片：<input type="text" name="queryY" size="4"
						id="query"> <input id="submitBtn" type="submit" value="查询" /></td>
				</tr>
			</table>
		</form>
		<form id="myForm" action="selectTools.action?methodstr=selectSY"
			method="post" onsubmit="return sb4()">
			<table>
				<tr>
					<td>卷轴查方片，请输入卷轴号：<input type="text" name="querySY" size="4"
						id="querya"> <input id="submitBtn" type="submit"
						value="查询" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>